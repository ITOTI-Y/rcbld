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
using RCBldGH.Components.Envelope;
using Rhino;

namespace RCBldGH.Components.Reader
{
    public class SolarCalculateBeamtest:GH_Component
    {
        public SolarCalculateBeamtest(): base("SolarCalculateBeam1.2test", "SolarData", "SolarData", "RCBldGH", "Other"){}
        
        public override Guid ComponentGuid => new Guid("{1d10009d-932d-495e-bf7c-5eb4c109f8f3}");
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {

            pManager.AddGenericParameter("SolarData", "S", " SolarData form SolarDataFromEPW Component", GH_ParamAccess.item);
            EnvelopSurfaceParam surfaceParam = new EnvelopSurfaceParam();
            pManager.AddParameter(surfaceParam,"Envelope Surfaces", "S", "Surfaces that can form a closed zone.", GH_ParamAccess.tree);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("beam", "occupants", "occupants", GH_ParamAccess.tree);
            pManager.AddNumberParameter("areaFraction", "WWR", "WWR", GH_ParamAccess.tree);
        }


        protected override void SolveInstance(IGH_DataAccess DA)
        {
            Dictionary<string, double[]> Solardata = new Dictionary<string, double[]> { };
            GH_Structure<EnvelopeSettingGoo> SolarSurfaces=new GH_Structure<EnvelopeSettingGoo> { };
            DA.GetData(0, ref Solardata);            
            
            if (!DA.GetDataTree(1, out SolarSurfaces))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "At least one Envelope Surface list is empty.");
                return;
            }
          

            DataTree<double> radianceDict = new DataTree<double>();//储存结果
            DataTree<double> areaFracTree = new DataTree<double>();
            for (int k = 0; k < SolarSurfaces.Paths.Count; k++)//遍历每个zone
            {
                double[] radianceT = new double[8760]; double areafraction=0;
                for (int i = 0; i < SolarSurfaces.Branches[k].Count; i++)
                {

                    EnvelopeSetting SolarSurface = SolarSurfaces[SolarSurfaces.Paths[k]][i].Value;
                    areafraction = SolarSurface.WWR;
                    double area = SolarSurface.GetPlanePartArea();
                    //List<double> radianceBeamNew = new List<double>();

                    double rg = 0.2;//ground reflectivity
                    double radiance;
                    double diffuse;//漫射
                    double total;//漫射加直射加反射

                    Surface surface = SolarSurface.GetAllSurfaces()[0].Value.Faces[0].ToNurbsSurface();/////bug1
                    Point3d center = surface.GetBoundingBox(false).Center;
                    _ = surface.ClosestPoint(center, out double u, out double v);
                    Vector3d normal = surface.NormalAt(u, v);
                    double gama = 0;//表面方向角，南偏东为负，南偏西
                    double radianceTest;
                    double beta_cos = 0;//表面坡度 slope 与水平面的夹角
                    double beta_sin = 0;

                    SurfaceType surfaceType;
                    if (normal.Z == 0)//墙面，垂直Slope=90°
                    {
                        surfaceType = SurfaceType.Facade;
                        if (normal.Y > 0)
                        {
                            if (normal.X >= 0)
                            {
                                gama = -Math.PI / 2 - Math.Acos(normal.X);//𝛾  Surface azimuth angle 第一象限，东北方向，-90°——-180°  , the deviation of the projection on a horizontal plane of the nnormal to the surface from the local meridian, with zero due south, east negative, and west positive; −180∘ ≤ 𝛾 ≤ 180∘.
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
                    }
                    else if (normal.Z != 0 && (normal.Y == 0 && normal.X == 0))//屋顶，slope=0°
                    {
                        surfaceType = SurfaceType.Plane;
                    }
                    else//斜面
                    {
                        surfaceType = SurfaceType.Slope;
                        beta_cos = normal.Z;//表面坡度 slope 与水平面的夹角
                        double beta = Math.Acos(normal.Z);
                        beta_sin = Math.Sin(beta);
                        if (normal.Y > 0)
                        {
                            if (normal.X >= 0)
                            {
                                gama = -Math.PI / 2 - Math.Acos(normal.X / Math.Sqrt(normal.Y * normal.Y + normal.X * normal.X));//𝛾  Surface azimuth angle 第一象限，东北方向，-90°——-180°  , the deviation of the projection on a horizontal plane of the nnormal to the surface from the local meridian, with zero due south, east negative, and west positive; −180∘ ≤ 𝛾 ≤ 180∘.
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
                    }
                    for (int h = 0; h < 8760; h++)
                    {
                        if (surfaceType == SurfaceType.Facade)
                        {
                            double theta_cos = Solardata["zenith_sin"][h] * Math.Cos(Solardata["azimuth"][h] - gama);
                            if (theta_cos <= 0)
                            {
                                radianceTest = 0;
                            }
                            else { radianceTest = Solardata["EB"][h] * theta_cos; }

                            if (radianceTest > 0) { radiance = radianceTest; }
                            else { radiance = 0; }
                            diffuse = Solardata["ED"][h] * ((1 - Solardata["f1"][h]) * 0.5 + (Solardata["f1"][h] * Math.Max(0, theta_cos) / Math.Max(Math.Cos(1.48353), Solardata["zenith_cos"][h])) + Solardata["f2"][h]);
                            if (diffuse < 0 || double.IsNaN(diffuse))
                            { diffuse = 0; }

                            total = radiance + diffuse + (Solardata["ED"][h] + Solardata["EB"][h]) * rg * 0.5;
                        }
                        else if (surfaceType == SurfaceType.Plane)//屋顶，slope=0°
                        {
                            radianceTest = Solardata["EB"][h] * Solardata["zenith_cos"][h];
                            if (radianceTest > 0) { radiance = radianceTest; }
                            else { radiance = 0; }
                            diffuse = Solardata["ED"][h] * ((1 - Solardata["f1"][h]) + (Solardata["f1"][h] * Math.Max(0, Solardata["zenith_cos"][h]) / Math.Max(Math.Cos(1.48353), Solardata["zenith_cos"][h])));
                            if (diffuse < 0 || double.IsNaN(diffuse))
                            { diffuse = 0; }
                            total = radiance + diffuse;
                        }
                        else//斜面
                        {
                            double theta_cos = Solardata["zenith_sin"][h] * Math.Cos(Solardata["azimuth"][h] - gama);
                            if (theta_cos <= 0)
                            {
                                radianceTest = 0;
                            }
                            else { radianceTest = Solardata["EB"][h] * theta_cos; }
                            if (radianceTest > 0) { radiance = radianceTest; }
                            else { radiance = 0; }
                            diffuse = Solardata["ED"][h] * ((1 - Solardata["f1"][h]) * ((1 + beta_cos) / 2) + (Solardata["f1"][h] * Math.Max(0, theta_cos) / Math.Max(Math.Cos(1.48353), Solardata["zenith_cos"][h])) + (Solardata["f2"][h] * beta_sin));
                            if (diffuse < 0 || double.IsNaN(diffuse))
                            { diffuse = 0; }
                            total = radiance + diffuse + (Solardata["ED"][h] + Solardata["EB"][h]) * rg * (1 - beta_cos) / 2;
                        }
                        radianceT[h] += total * area;
                    }
                    //var radianceDN=radianceD.Select(x => double.IsNaN(x) ? 0 : x).ToList();
                }
                radianceDict.AddRange(radianceT, SolarSurfaces.Paths[k]);
                areaFracTree.Add(areafraction, SolarSurfaces.Paths[k]);
            }
            DA.SetDataTree(0, radianceDict);
            DA.SetDataTree(1, areaFracTree);
        }
    }
}
