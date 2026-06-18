using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Xml.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Parameters;
using Grasshopper.Kernel.Types;
using Rhino;
using Rhino.Commands;
using RCBldGH.Modules;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using Rhino.Geometry;
using System.Data.SqlTypes;
using System.Text.RegularExpressions;

namespace RCBldGH.Components.Basics
{
    public class EPWReader:GH_Component
    {
        public EPWReader(): base("EPWReader", "EPWReader", "EPWReader", "RCBldGH", "Other")
        {
        }

        public override Guid ComponentGuid => new Guid("{fa88af86-63f6-401b-9cbe-8d93d05e721f}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            Param_FilePath path = new Param_FilePath();
            pManager.AddParameter(path, "Weather file", "F", "only supports .epw file, the file should be under \\\\Weather_Files\\\\",
                GH_ParamAccess.item);           
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddTextParameter("Location", "L", "Location data, include lat, lon ,elv ,timezone ", GH_ParamAccess.item);
            pManager.AddGenericParameter("SolarData", "S", "Location data, include lat, lon ,elv ,timezone ", GH_ParamAccess.item);
            pManager.AddVectorParameter("SolarVector", "S", "sunVector ", GH_ParamAccess.list);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string path = string.Empty;
            DA.GetData(0, ref path);
            StreamReader sr = new StreamReader(path, Encoding.UTF8);
            String location = sr.ReadLine();
            var LocationStrings = location.Split(',');
            string result = $"{LocationStrings[1]}, lat:{LocationStrings[LocationStrings.Length - 4]}, lon: {LocationStrings[LocationStrings.Length - 3]}, tz: {LocationStrings[LocationStrings.Length - 2]}, elev: {LocationStrings[LocationStrings.Length - 1]}";
            for (int i = 0; i < 7; i++)
            {
                sr.ReadLine();
            }
            
            List<double>[] columns = new List<double>[2];
            for (int i = 0; i < columns.Length; i++)
            {
                columns[i] = new List<double>();
            }
            while (sr.Peek() >= 0)
            {
                string line = sr.ReadLine();
                string[] values = line.Split(',');

                columns[0].Add(double.Parse(values[14]));//直射辐照
                columns[1].Add(double.Parse(values[15]));//水平漫射辐照
            }
            Dictionary<string, List<double>> keyValuePair = new Dictionary<string, List<double>>
            {
                { "EB", columns[0] },{"ED", columns[1] }
            };


            DA.SetData(0, result);
            DA.SetData(1, ReadSolarDataFromLocation(result, keyValuePair, out List<Vector3d> sunPath));
            DA.SetDataList(2, sunPath);


        }

        public Dictionary<string, List<double>> ReadSolarDataFromLocation(string location, Dictionary<string, List<double>> keyValuePairs, out List<Vector3d> sunPath)
        {
            string[] str = location.Split(':');
            double lat = double.Parse(str[1].Split(',')[0]);//Φ（fai）纬度latitude 
            double lat_cos = Math.Cos(lat * Math.PI / 180);//cosΦ 纬度的cos值
            double lat_sin = Math.Sin(lat * Math.PI / 180);//sinΦ 纬度的sin值
            double lon = double.Parse(str[2].Split(',')[0]);//经度
            double tz = double.Parse(str[3].Split(',')[0]);//时区
            double lst = tz * 15;//子午线经度
            double Gsc = 1366.1;//solar constant W/m2

            //List<double> lat_cos_1 = new List<double> { lat_cos };
            //List<double> lat_sin_1 = new List<double> { lat_sin };
            List<double> b_365 = new List<double>();
            List<double> et_365 = new List<double>();
            List<double> delta_365 = new List<double>();
            List<double> delta_sin_365 = new List<double>();
            List<double> delta_cos_365 = new List<double>();
            List<double> Gon_365 = new List<double>();
            for (int n = 1; n <= 365; n++)
            {
                //时间方程
                double b = (n - 1.0) * 360.0 / 365.0 * Math.PI / 180.0;//B 转化为弧度
                double d = 6.24004077 + 0.01720197 * (365.25 * (2024 - 2000) + n);//wiki公式
                double et_wiki = -7.659 * Math.Sin(d) + 9.863 * Math.Sin(2 * d + 3.5932);//wiki公式

                //赤纬（declination）δ(小写delta)
                double delta = (0.006918 - 0.399912 * Math.Cos(b) + 0.070257 * Math.Sin(b) - 0.006758 * Math.Cos(2 * b) + 0.000907 * Math.Sin(2 * b) - 0.002697 * Math.Cos(3 * b) + 0.00148 * Math.Sin(3 * b));//赤纬（declination）δ(小写delta) 弧度
                double delta_sin = Math.Sin(delta);//sinδ
                double delta_cos = Math.Cos(delta);//cosδ

                //地外辐射 Gon
                double Gon = Gsc * (1.000110 + 0.034221 * Math.Cos(b) + 0.001280 * Math.Sin(b) + 0.00719 * Math.Cos(2 * b) + 0.000077 * Math.Sin(2 * b));

                b_365.Add(b);
                et_365.Add(et_wiki);
                delta_365.Add(delta);
                delta_sin_365.Add(delta_sin);
                delta_cos_365.Add(delta_cos);
                Gon_365.Add(Gon);
            }

            List<double> solar_time_8760 = new List<double>();
            List<double> omega_8760 = new List<double>();
            List<double> omega_cos_8760 = new List<double>();
            List<double> omega_sin_8760 = new List<double>();
            List<double> zenith_cos_8760 = new List<double>();
            List<double> zenith_sin_8760 = new List<double>();
            List<double> zenith_8760 = new List<double>();
            List<double> azimuth_8760 = new List<double>();
            List<double> f1_8760= new List<double>();
            List<double> f2_8760 = new List<double>();

            //List<double> azimuth_8760_new = new List<double>();
            List<Vector3d> sunPath1 = new List<Vector3d>();
            for (int h = 0; h < 8760; h++)
            {
                //太阳时
                //double solar_time = (h % 24 + 0.5 + et_365[h / 24] / 60 + (lon - lst) / 15 + 24) % 24;
                double solar_time = (h % 24 +0.5 + et_365[h / 24] / 60 + (lon - lst) / 15 + 24) % 24;
                //时角，早上为负，下午为正
                double omega;
                if (solar_time < 0)
                { omega = 15.0 * (solar_time + 12.0); }
                else
                {
                  omega = 15.0 * (solar_time - 12.0);
                }//ω 时角 
                double omega_cos = Math.Cos(omega * Math.PI / 180);//cosω
                double omega_sin = Math.Sin(omega * Math.PI / 180);//sinω

                //天顶角
                double zenith_cos = lat_cos * delta_cos_365[h / 24] * omega_cos + lat_sin * delta_sin_365[h / 24];//cos 𝜃z =sin𝛼s= cos 𝜙 cos 𝛿 cos 𝜔 + sin 𝜙 sin 𝛿  cosθz天顶角的cos值
                double zenith = Math.Acos(zenith_cos);//θz天顶角，弧度
                double zenith_sin = Math.Sin(zenith);

                //方向角
                double azimuth;
                double az_init = (lat_sin * zenith_cos - delta_sin_365[h / 24]) / (lat_cos * zenith_sin);
                try
                {
                    if (omega > 0)
                    {
                        azimuth = ((Math.Acos(az_init) + Math.PI) % (2 * Math.PI))- Math.PI;
                    }
                    else { azimuth =  (3 * Math.PI - Math.Acos(az_init)) % (2 * Math.PI)- Math.PI; }
                }
                catch
                { azimuth = 0; }


                sunPath1.Add(new Vector3d(-Math.Sin(azimuth) * Math.Sin(zenith), Math.Cos(azimuth) * Math.Sin(zenith), -Math.Cos(zenith)));
                //Epsilon ε a clearness 一种天空透明度指数
                double zenithDegree = zenith / Math.PI * 180;
                double epsilon = (((keyValuePairs["EB"][h]+ keyValuePairs["ED"][h])/ keyValuePairs["ED"][h])+(0.000005535* zenithDegree * zenithDegree * zenithDegree))/(1+ (0.000005535 * zenithDegree * zenithDegree * zenithDegree));

                double brightness= keyValuePairs["ED"][h] / ((zenith_cos + 0.50572 * Math.Pow(96.07995 - zenithDegree, -1.6364)) * Gon_365[h / 24]);
               
                double[] fValues = GetFValues(epsilon);
                double F1 = Math.Max(0, fValues[0] + fValues[1] * brightness + zenith * fValues[2]);
                double F2 = fValues[3] + fValues[4] * brightness + zenith * fValues[5];
                

                solar_time_8760.Add(solar_time);
                omega_8760.Add(omega);
                omega_cos_8760.Add(omega_cos);
                omega_sin_8760.Add(omega_sin);
                zenith_cos_8760.Add(zenith_cos);
                zenith_sin_8760.Add(zenith_sin);
                zenith_8760.Add(zenith);
                azimuth_8760.Add(azimuth);
                f1_8760.Add(F1);
                f2_8760.Add(F2);
                
            }
            //keyValuePairs.Add("lat_cos", lat_cos_1);
            //keyValuePairs.Add("lat_sin", lat_sin_1);
            keyValuePairs.Add("delta_sin", delta_sin_365);
            keyValuePairs.Add("delta_cos", delta_cos_365);
            keyValuePairs.Add("omega_sin", omega_sin_8760);
            keyValuePairs.Add("omega_cos", omega_cos_8760);
            keyValuePairs.Add("zenith_cos", zenith_cos_8760);
            keyValuePairs.Add("zenith_sin", zenith_sin_8760);
            keyValuePairs.Add("zenith", zenith_8760);
            keyValuePairs.Add("azimuth", azimuth_8760);
            keyValuePairs.Add("solar_time", solar_time_8760);
            keyValuePairs.Add("f1", f1_8760); //和diffuse radiation有关的参数
            keyValuePairs.Add("f2", f2_8760);
            keyValuePairs.Add("delta", delta_365);
           // keyValuePairs.Add("azimuth_new", azimuth_8760_new);
            keyValuePairs.Add("lat",new  List<double>{lat});
            sunPath = sunPath1;
            return keyValuePairs;
        }
        static double[] GetFValues(double d)
        {
            // 根据 d 的范围选择相应的 f11-f23 值
            if (d >= 1.000 && d < 1.065)
            {
                return new double[6] { -0.008, 0.588, -0.062, -0.060, 0.072, -0.022 };
            }
            else if (d >= 1.065 && d < 1.230)
            {
                return new double[6] { 0.130, 0.683, -0.151, -0.019, 0.066, -0.029 };
            }
            else if (d >= 1.230 && d < 1.500)
            {
                return new double[6] { 0.330, 0.487, -0.221, 0.055, -0.064, -0.026 };
            }
            else if (d >= 1.500 && d < 1.950)
            {
                return new double[6] { 0.568, 0.187, -0.295, 0.109, -0.152, -0.014 };
            }
            else if (d >= 1.950 && d < 2.800)
            {
                return new double[6] { 0.873, -0.392, -0.362, 0.226, -0.462, 0.001 };
            }
            else if (d >= 2.800 && d < 4.500)
            {
                return new double[6] { 1.132, -1.237, -0.412, 0.288, -0.823, 0.056 };
            }
            else if (d >= 4.500 && d < 6.200)
            {
                return new double[6] { 1.060, -1.600, -0.359, 0.264, -1.127, 0.131 };
            }
            else if (d >= 6.200)
            {
                return new double[6] { 0.678, -0.327, -0.250, 0.156, -1.377, 0.251 };
            }
            else
            {
                // 默认返回空数组
                return new double[6] ;
            }
        }
    }
}