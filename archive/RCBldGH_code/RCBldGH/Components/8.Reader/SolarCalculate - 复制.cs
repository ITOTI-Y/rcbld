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
using SimBldPyUI.Modules;
using SimBldPyUI.Utils;

namespace SimBldPyUI.Components.Reader
{
    public class SolarCalculate_beta:GH_Component
    {
        public SolarCalculate_beta(): base("SolarCalculate_beta", "SolarCalculate_beta", "SolarData", "SimBldPy", "Reader"){}
        
        public override Guid ComponentGuid => new Guid("{229ffe8a-2452-40c1-a05c-bc56947a53a3}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddGenericParameter("SolarData", "S", " SolarData form SolarDataFromEPW Component", GH_ParamAccess.item);
            pManager.AddSurfaceParameter("Surface", "S", " surface", GH_ParamAccess.tree);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("occupants", "occupants", "occupants", GH_ParamAccess.tree);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            Dictionary<string, List<double>> Solardata = new Dictionary<string, List<double>> { };
            DA.GetData(0, ref Solardata);

            DA.GetDataTree<GH_Surface>(1, out GH_Structure<GH_Surface> SolarSurface);

            DataTree<List<double>> data = new DataTree<List<double>> { };

            for (int i = 0; i < SolarSurface.Paths.Count; i++)
            {
                for (int j = 0; j < SolarSurface.get_Branch(i).Count; j++)
                {
                    List<double> radianceData = new List<double>();
                    for (int h = 0; h < 8760; h++)
                    {
                        int d = h / 24;
                        double radiance;
                        Surface surface = SolarSurface.get_DataItem(SolarSurface.Paths[i], j).Value.Faces[0].ToNurbsSurface();
                        Point3d center = surface.GetBoundingBox(false).Center;
                        _ = surface.ClosestPoint(center, out double u, out double v);
                        Vector3d normal = surface.NormalAt(u, v);
                        double gama;
                        if (normal.Z == 0)//墙面，垂直Slope=90°
                        {
                            if (normal.Y > 0)
                            {
                                if (normal.X >= 0)
                                {
                                    gama = Math.PI / 2 - Math.Acos(normal.X);//𝛾  Surface azimuth angle 第一象限，东北方向，-90°——-180°  , the deviation of the projection on a horizontal plane of the nnormal to the surface from the local meridian, with zero due south, east negative, and west positive; −180∘ ≤ 𝛾 ≤ 180∘.
                                }
                                else
                                {
                                    gama = 3 * Math.PI / 2 - Math.Acos(normal.X);//𝛾 Surface azimuth angle 第二象限，西北方向，90°——180°
                                }
                            }
                            else
                            {
                                gama = Math.Acos(normal.X) - Math.PI / 2;//𝛾  Surface azimuth angle 三四象限，南方向，-90°——90°
                            }
                            double gama_cos = Math.Cos(gama);
                            double gama_sin = Math.Sin(gama);
                            radiance = Solardata["EB"][h] * Math.Sin(Math.Acos(((-Solardata["delta_sin"][d]) * Solardata["lat_cos"][0] * gama_cos + Solardata["delta_cos"][d] * Solardata["lat_sin"][0] * gama_cos * Solardata["omega_cos"][h] + Solardata["delta_cos"][d] * gama_sin * Solardata["omega_sin"][h])));
                        }
                        else if (normal.Z != 0 && (normal.Y == 0 && normal.X == 0))//屋顶，slope=0°
                        {
                            radiance = Solardata["EB"][h] * Math.Sin(Math.Acos(Solardata["zenith_cos"][h]));
                        }
                        else//斜面
                        {
                            double beta_cos = normal.Z;//表面坡度 slope 与水平面的夹角
                            double beta = Math.Acos(normal.Z);
                            double beta_sin = Math.Sin(beta);
                            if (normal.Y > 0)
                            {
                                if (normal.X >= 0)
                                {
                                    gama = Math.PI / 2 - Math.Acos(normal.X / Math.Sqrt(normal.Y * normal.Y + normal.X * normal.X));//𝛾  Surface azimuth angle 第一象限，东北方向，-90°——-180°  , the deviation of the projection on a horizontal plane of the nnormal to the surface from the local meridian, with zero due south, east negative, and west positive; −180∘ ≤ 𝛾 ≤ 180∘.
                                }
                                else
                                {
                                    gama = 3 * Math.PI / 2 - Math.Acos(normal.X / Math.Sqrt(normal.Y * normal.Y + normal.X * normal.X));//𝛾 Surface azimuth angle 第二象限，西北方向，90°——180°
                                }
                            }
                            else
                            {
                                gama = Math.Acos(normal.X / Math.Sqrt(normal.Y * normal.Y + normal.X * normal.X)) - Math.PI / 2;//𝛾  Surface azimuth angle 三四象限，南方向，-90°——90°
                            }
                            radiance = Solardata["EB"][h] * Math.Sin(Math.Acos((Solardata["zenith_cos"][h] * beta_cos + Solardata["zenith_sin"][h] * beta_sin * Math.Cos(Solardata["zenith_sin"][h] - gama))));
                        }
                        radianceData.Add(radiance);
                    }
                    data.Add(radianceData, SolarSurface.Paths[i]);
                }
            }
            DA.SetDataTree(0, data);
        }


    }
}