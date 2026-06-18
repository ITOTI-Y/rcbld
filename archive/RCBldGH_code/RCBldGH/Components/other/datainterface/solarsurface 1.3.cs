using Grasshopper.Kernel;
using RCBldGH.Modules;
using RCBldGH.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Rhino.Geometry.Collections;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Components.Material;
using Grasshopper;
using Grasshopper.Kernel.Data;
using System.IO;
using Rhino;
using Grasshopper.Kernel.Geometry.Delaunay;
using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;
using Rhino.Render;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace RCBldGH.Components.Envelope.envelopeSurface
{
    public class SolarSurface3Comp : GH_Component
    {
        public SolarSurface3Comp() : base("Solarsurface1.3", "Material to Brep", "Assignment MaterialSetting to breps", "RCBldGH", "Other")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.primary;
        public override Guid ComponentGuid => new Guid("{9de96d23-287f-48d1-b680-371621393e5b}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.MSettingAssign;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddBrepParameter("Rooms", "R", "breps to represent rooms", GH_ParamAccess.list);
            pManager.AddGenericParameter("MaterialSetting", "MaterialSetting", "set the room material set,using roof material/externalfl", GH_ParamAccess.item);            
            WindowParam windowParam = new WindowParam();
            pManager.AddParameter(windowParam, "Windows", "Windows", "Windows objects.", GH_ParamAccess.list);
            pManager.AddGenericParameter("SolarData", "S", " SolarData form SolarDataFromEPW Component", GH_ParamAccess.item);
            pManager[2].Optional = true; pManager[3].Optional = true;
        }
        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddTextParameter("Zone_Name", "name", "name", GH_ParamAccess.tree);
            pManager.AddGenericParameter("Envelope setting", "setting", "Envelope setting", GH_ParamAccess.tree);            
            pManager.AddGenericParameter( "Envelope setting", "setting", "Envelope setting", GH_ParamAccess.tree);
            pManager.AddGenericParameter("beam", "occupants", "occupants", GH_ParamAccess.tree);
            pManager.AddNumberParameter("areaFraction", "WWR", "WWR", GH_ParamAccess.tree);
            pManager[3].Optional = true; pManager[4].Optional = true;


        }
        protected override void SolveInstance(IGH_DataAccess DA)
        {            
            ///6.19 14:07 增加Dictionary
            ///下一步继续实现

            List<GH_Brep> rooms = new List<GH_Brep>();
            if (!DA.GetDataList(0, rooms))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Rooms message");
                return;
            }

            MaterialSetting materialSetting;            
            object materialSettingObj = null;
            if (!DA.GetData(1, ref materialSettingObj))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "NO MaterialSetting");
                return;
            }
            try
            {
                materialSetting = (MaterialSetting)((GH_ObjectWrapper)materialSettingObj).Value;
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid MaterialSetting");
                return;
            }

            List<WindowGoo> windows = new List<WindowGoo>();
            DA.GetDataList(2, windows);

            Dictionary<string, double[]> Solardata = new Dictionary<string, double[]> { };            
            DA.GetData(3, ref Solardata);


            GH_Structure<SuperSurfaceGoo> SolarSurfaces = new GH_Structure<SuperSurfaceGoo> { };
            GH_Structure<EnvelopeSettingGoo> result = new GH_Structure<EnvelopeSettingGoo>();
            DataTree<SuperSurfaceGoo> RadSurface = new DataTree<SuperSurfaceGoo>();

            DataTree<SuperSurface> prTree = new DataTree<SuperSurface>();
            List<SuperSurface> buildingWalls = new List<SuperSurface>();
            List<SuperSurface> buildingTops = new List<SuperSurface>();
            List<SuperSurface> buildingBottoms = new List<SuperSurface>();
            for (int i = 0; i < rooms.Count; i++)//建筑
            {
                GH_Path path = new GH_Path(i);
                // Use a dictionary to store the face and its normal vector
                Dictionary<BrepFace, Vector3d> faceNormals = new Dictionary<BrepFace, Vector3d>();
                // Loop through the faces of the brep
                for (int j = 0; j < rooms[i].Value.Faces.Count; j++)
                {
                    BrepFace face = rooms[i].Value.Faces[j];
                    Surface surface = face.ToNurbsSurface();
                    SuperSurface superSurface = new SuperSurface(new GH_Surface(surface));
                    prTree.Add(superSurface, path);//按照房间，提取face至房间列表

                    Point3d center = face.PointAt(face.Domain(0).Mid, face.Domain(1).Mid);
                    Vector3d normal = face.NormalAt(center.X, center.Y);
                    // Add the face and its normal vector to the dictionary
                    faceNormals.Add(face, normal);
                }; //分解几何体，提取6个Supersurface

                for (int k = 0; k < prTree.Branch(i).Count; k++)
                {
                    // Get the face and its normal vector from the dictionary
                    BrepFace face = rooms[i].Value.Faces[k];
                    Vector3d normal = faceNormals[face];
                    // Compare the normal vector with the world Z axis direction
                    double angle = Vector3d.VectorAngle(normal, Vector3d.ZAxis);
                    if (angle < RhinoMath.ZeroTolerance || Math.Abs(angle - Math.PI) < RhinoMath.ZeroTolerance)
                    {
                        // If the angle is zero or pi, then it is a top or bottom face
                        if (normal.Z > 0)
                        {
                            // If the normal vector points up, then it is a top face
                            prTree[path, k].RelativePosition = 0;
                            buildingTops.Add(prTree[path, k]);
                        }
                        else
                        {
                            // If the normal vector points down, then it is a bottom face
                            prTree[path, k].RelativePosition = 2;
                            buildingBottoms.Add(prTree[path, k]);
                        }
                    }
                    else
                    {
                        // Otherwise, it is a wall face
                        prTree[path, k].RelativePosition = 1;
                        buildingWalls.Add(prTree[path, k]);
                    }
                }//提取每个房间面赋予位置，顶面=0、底面=2、墙面=1
            }//判断几何模型各个面相对位置


            for (int k = 0; k < windows.Count; k++)
            {
                for (int i = 0; i < prTree.BranchCount; i++)//每个房间
                {
                    for (int j = 0; j < prTree.Branch(prTree.Paths[i]).Count; j++)//每个面
                    {
                        if (prTree[prTree.Paths[i], j].RelativePosition == 0 || prTree[prTree.Paths[i], j].RelativePosition == 1)
                        {
                            Point3d windowCentroid = windows[k].Value.GeometrySurface.Face.PointAt(windows[k].Value.GeometrySurface.Face.Domain(0).Mid, windows[k].Value.GeometrySurface.Face.Domain(1).Mid);
                            prTree[prTree.Paths[i], j].Surface.ClosestPoint(windowCentroid, out double u, out double v);
                            Point3d point = prTree[prTree.Paths[i], j].Surface.PointAt(u, v);
                            if (windowCentroid.DistanceTo(point) < 0.00001)
                            {
                                prTree[prTree.Paths[i], j].Window.Add(windows[k].Value);
                                goto OK;
                            }

                        }
                    }
                }
            OK:;
            }//为supersurface添加window

            for (int i = 0; i < prTree.BranchCount; i++)//每个房间
            {
                for (int j = 0; j < prTree.Branch(prTree.Paths[i]).Count; j++)//每个面
                {
                    if (prTree[prTree.Paths[i], j].RelativePosition == 0)//若为顶面
                    {
                        bool isExter = true;
                        for (int k = 0; k < buildingBottoms.Count; k++)
                        {
                            buildingBottoms[k].Surface.ClosestPoint(prTree[prTree.Paths[i], j].Centroid, out double u, out double v);
                            Point3d point = buildingBottoms[k].Surface.PointAt(u, v);
                            if (prTree[prTree.Paths[i], j].Centroid.DistanceTo(point) < 0.00001)
                            {
                                prTree[prTree.Paths[i], j].Material = materialSetting.InternalFloorMaterial;
                                isExter = false;
                                break;
                            }
                        }
                        if (isExter)
                        {
                            prTree[prTree.Paths[i], j].Material = materialSetting.RoofMaterial;
                            RadSurface.Add(prTree[prTree.Paths[i], j], prTree.Paths[i]);
                        }
                    }//top

                    if (prTree[prTree.Paths[i], j].RelativePosition == 1)//若为墙面
                    {
                        bool isExter = true;
                        int exceptitself = 0;
                        for (int k = 0; k < buildingWalls.Count; k++)
                        {
                            buildingWalls[k].Surface.ClosestPoint(prTree[prTree.Paths[i], j].Centroid, out double u, out double v);
                            Point3d point = buildingWalls[k].Surface.PointAt(u, v);
                            if (prTree[prTree.Paths[i], j].Centroid.DistanceTo(point) < RhinoMath.ZeroTolerance)
                            {
                                exceptitself += 1;

                            }

                        }
                        if (exceptitself >= 2)
                        {
                            prTree[prTree.Paths[i], j].Material = materialSetting.InternalWallMaterial;
                            isExter = false;

                        }
                        if (isExter)
                        {
                            prTree[prTree.Paths[i], j].Material = materialSetting.ExternalWallMaterial;
                            RadSurface.Add(prTree[prTree.Paths[i], j], prTree.Paths[i]);
                        }
                    }//wall

                    if (prTree[prTree.Paths[i], j].RelativePosition == 2)//若为底面
                    {
                        bool isExter = true;
                        for (int k = 0; k < buildingTops.Count; k++)
                        {
                            buildingTops[k].Surface.ClosestPoint(prTree[prTree.Paths[i], j].Centroid, out double u, out double v);
                            Point3d point = buildingTops[k].Surface.PointAt(u, v);
                            if (prTree[prTree.Paths[i], j].Centroid.DistanceTo(point) < 0.00001)
                            {
                                prTree[prTree.Paths[i], j].Material = materialSetting.InternalFloorMaterial;
                                isExter = false;
                                break;
                            }
                        }
                        if (isExter)
                        {
                            prTree[prTree.Paths[i], j].Material = materialSetting.ExternalFloorMaterial;
                        }
                    }//bottom
                }
            }//根据相对位置为各个几何面分配material
            
            //supersurface中无window,有material            
            


            foreach (var branch in prTree.Branches)
            {
                // Get the data and path of the branch
                var data = branch as List<SuperSurface>;
                var path = prTree.Paths[prTree.Branches.IndexOf(branch)];
                // Convert the data to the desired type
                var esetting=new List<EnvelopeSettingGoo>();
                for (int i = 0; i < data.Count; i++)
                {
                    esetting.Add(data[i].EnvelopeSetting);
                }
                // Add the data to the GH_Structure
                result.AppendRange(esetting, path);
            }//把supersurface转化为envelopsetting
            DA.SetDataTree(1, result);

            DataTree<String> zoneNames = new DataTree<String>();
            int p = 1;
            foreach (var branch in prTree.Branches)
            {
                // Get the data and path of the branch
                
                var path = prTree.Paths[prTree.Branches.IndexOf(branch)];
                // Convert the data to the desired type
                string name = String.Format("Zone_{0}",p);
                p++;
                // Add the data to the GH_Structure
                zoneNames.Add(name, path);
                SolarSurfaces.AppendRange(RadSurface.Branch(path),path );
            }//创建zone名字            
            DA.SetDataTree (0, zoneNames); 

            DA.SetDataTree(2, SolarSurfaces);


            DataTree<double> radianceDict = new DataTree<double>();//储存结果
            DataTree<double> areaFracTree = new DataTree<double>();
            for (int k = 0; k < SolarSurfaces.Paths.Count; k++)//遍历每个zone
            {
                double[] radianceT = new double[8760];
                double totalArea = 0;
                double windowArea = 0;
                for (int i = 0; i < SolarSurfaces.Branches[k].Count; i++)
                {

                    EnvelopeSetting SolarSurface = SolarSurfaces[SolarSurfaces.Paths[k]][i].Value.EnvelopeSetting.Value;
                    double wwr = SolarSurface.WWR;
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
                        totalArea += area;
                        windowArea += area * wwr;
                    }
                    //var radianceDN=radianceD.Select(x => double.IsNaN(x) ? 0 : x).ToList();
                }
                radianceDict.AddRange(radianceT, SolarSurfaces.Paths[k]);
                areaFracTree.Add(windowArea/totalArea, SolarSurfaces.Paths[k]);
            }
            DA.SetDataTree(3, radianceDict);
            DA.SetDataTree(4, areaFracTree);
        }
    }
}

           

        
            

            

            