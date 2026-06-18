using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Grasshopper;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using Grasshopper.Kernel.Parameters;
using Grasshopper.Kernel.Types;
using Microsoft.VisualBasic;
using Rhino.Geometry;
using RCBldGH.Modules;
using RCBldGH.Utils;

namespace RCBldGH.Components.Reader
{
    public class SolarCalculateCustom:GH_Component
    {
        public SolarCalculateCustom(): base("SolarCalculateCustom", "SolarData", "SolarData", "RCBldGH", "Other1"){}
        
        public override Guid ComponentGuid => new Guid("{dee8fc1e-f7fb-4181-9482-c65711b71ad2}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {            
            pManager.AddGenericParameter( "SolarData", "S", " SolarData form SolarDataFromEPW Component", GH_ParamAccess.item);
            pManager.AddNumberParameter("Slope", "S", " surface", GH_ParamAccess.list);
            pManager.AddIntegerParameter("Hoy", "S", " surface", GH_ParamAccess.list);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {            
            pManager.AddGenericParameter("beam", "occupants", "occupants", GH_ParamAccess.list);
            pManager.AddGenericParameter("diffuse", "occupants", "occupants", GH_ParamAccess.list);
            pManager.AddGenericParameter("total", "occupants", "occupants", GH_ParamAccess.list);
        }
        
        enum SurfaceType
        {
            Plane,
            Facade,
            Slope
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            Dictionary<string, List<double>> Solardata = new Dictionary<string, List<double>> { };
            DA.GetData(0, ref Solardata);
            List<double> slopes = new List<double>();
            List<int> hoys = new List<int>();
            DA.GetDataList(1, slopes);
            DA.GetDataList(2, hoys);  
            
            List<double> radianceB = new List<double>();
            List<double> radianceD = new List<double>();
            List<double> radianceT = new List<double>();

            //List<double> radianceBeamNew = new List<double>();

            double rg = 0.2;//ground reflectivity
            double radiance;
            double diffuse;//漫射
            double total;//漫射加直射加反射
            double radianceTest;
            for (int i = 0; i < hoys.Count; i++)
            {
                double beta_cos = Math.Cos(slopes[i]);
                double beta = slopes[i];
                double beta_sin = Math.Sin(beta);
                double gama = 0;
                double theta_cos = Solardata["zenith_sin"][hoys[i]] * Math.Cos(Solardata["azimuth"][hoys[i]] - gama);
                if (theta_cos <= 0)
                {
                    radianceTest = 0;
                }
                else { radianceTest = Solardata["EB"][hoys[i]] * theta_cos; }
                if (radianceTest > 0) { radiance = radianceTest; }
                else { radiance = 0; }
                diffuse = Solardata["ED"][hoys[i]] * ((1 - Solardata["f1"][hoys[i]]) * (1 + beta_cos) / 2 + (Solardata["f1"][hoys[i]] * Math.Max(0, theta_cos) / Math.Max(Math.Cos(1.48353), Solardata["zenith_cos"][hoys[i]])) + Solardata["f2"][hoys[i]] * beta_sin);
                total = radiance + diffuse + (Solardata["ED"][hoys[i]] + Solardata["EB"][hoys[i]]) * rg * (1 - beta_cos) / 2;

                radianceB.Add(radiance);
                radianceD.Add(diffuse);
                radianceT.Add(total);
            }
         
            DA.SetDataList("beam", radianceB);
            DA.SetDataList("diffuse", radianceD);
            DA.SetDataList("total", radianceT);
        }
    }
}
