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
using RCBldGH.Components;
using Rhino.Geometry.Intersect;
//接入阴影计算的辐照
//会把复杂的几何面简化为untrimmed surface
namespace RCBldGH.Components.Envelope.envelopeSurface
{

    public class ShadowAssign : GH_Component
    {
        public ShadowAssign() : base("ShadowAssign1.0", "Material to Brep", "Assignment MaterialSetting to breps", "RCBldGH", "Subcategory") { }
        public override GH_Exposure Exposure => GH_Exposure.primary;
        public override Guid ComponentGuid => new Guid("{2ecc1fdd-ff8d-44e4-9275-fe7817519ad7}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.MSettingAssign;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddBrepParameter("Rooms", "R", "breps to represent rooms", GH_ParamAccess.list);
            pManager.AddGenericParameter("MaterialSetting", "MaterialSetting", "set the room material set,using roof material/externalfl", GH_ParamAccess.item);
            WindowParam windowParam = new WindowParam();
            pManager.AddParameter(windowParam, "Windows", "Windows", "Windows objects.", GH_ParamAccess.list);
            pManager.AddGenericParameter("SolarData", "S", " SolarData form SolarDataFromEPW Component", GH_ParamAccess.item);
            pManager.AddVectorParameter("SolarVector", "S", " SolarData form SolarDataFromEPW Component", GH_ParamAccess.list);
            pManager.AddIntegerParameter("Interval", "I", " Shadow calculation interval,unit:day", GH_ParamAccess.item, 20);
            pManager[2].Optional = true; pManager[3].Optional = true; pManager[5].Optional = true;
        }
        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddTextParameter("Zone_Name", "name", "name", GH_ParamAccess.tree);
            pManager.AddGenericParameter("Envelope setting", "setting", "Envelope setting", GH_ParamAccess.tree);
            pManager.AddGenericParameter("SolarSurfaces", "setting", "Envelope setting", GH_ParamAccess.tree);
            pManager.AddGenericParameter("beam", "occupants", "occupants", GH_ParamAccess.tree);
            pManager.AddNumberParameter("areaFraction", "WWR", "WWR", GH_ParamAccess.tree);
            pManager[3].Optional = true;
            pManager[4].Optional = true;
        }
        protected override void SolveInstance(IGH_DataAccess DA)
        {
            ///全局属性
            double rg = 0.2;//ground reflectivity

            ///输入参数
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
            List<Vector3d> solarVector = new List<Vector3d> { };
            DA.GetDataList(4, solarVector);
            int interval = 20;
            DA.GetData(5, ref interval);
            ///房间材质的区分
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
                    SuperSurface superSurface = new SuperSurface(new GH_Surface(face.DuplicateFace(false)));
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
            for (int i = 0; i < prTree.BranchCount; i++)//每个房间
            {
                for (int j = 0; j < prTree.Branch(prTree.Paths[i]).Count; j++)//每个面
                {
                    if (prTree[prTree.Paths[i], j].RelativePosition == 0)//若为顶面
                    {
                        bool isExter = true;
                        for (int k = 0; k < buildingBottoms.Count; k++)
                        {
                            buildingBottoms[k].GH_Surface.Value.Faces[0].ClosestPoint(prTree[prTree.Paths[i], j].Centroid, out double u, out double v);
                            Point3d point = buildingBottoms[k].GH_Surface.Value.Faces[0].PointAt(u, v);
                            if (prTree[prTree.Paths[i], j].Centroid.DistanceTo(point) < 0.00001)
                            {
                                prTree[prTree.Paths[i], j].Name = buildingBottoms[k].Name;
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
                            buildingWalls[k].GH_Surface.Value.Faces[0].ClosestPoint(prTree[prTree.Paths[i], j].Centroid, out double u, out double v);
                            Point3d point = buildingWalls[k].GH_Surface.Value.Faces[0].PointAt(u, v);
                            if (prTree[prTree.Paths[i], j].Centroid.DistanceTo(point) < RhinoMath.ZeroTolerance)
                            {
                                exceptitself += 1;
                                prTree[prTree.Paths[i], j].Name = buildingWalls[k].Name;
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
                                prTree[prTree.Paths[i], j].Name = buildingTops[k].Name;
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
            for (int k = 0; k < windows.Count; k++)
            {
                for (int i = 0; i < prTree.BranchCount; i++)//每个房间
                {
                    for (int j = 0; j < prTree.Branch(prTree.Paths[i]).Count; j++)//每个面
                    {
                        if (prTree[prTree.Paths[i], j].RelativePosition == 0 || prTree[prTree.Paths[i], j].RelativePosition == 1)
                        {
                            Point3d windowCentroid = windows[k].Value.GeometrySurface.Face.PointAt(windows[k].Value.GeometrySurface.Face.Domain(0).Mid, windows[k].Value.GeometrySurface.Face.Domain(1).Mid);
                            prTree[prTree.Paths[i], j].GH_Surface.Value.Faces[0].ClosestPoint(windowCentroid, out double u, out double v);
                            Point3d point = prTree[prTree.Paths[i], j].GH_Surface.Value.Faces[0].PointAt(u, v);
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
            foreach (var branch in prTree.Branches)
            {
                // Get the data and path of the branch
                var data = branch as List<SuperSurface>;
                var path = prTree.Paths[prTree.Branches.IndexOf(branch)];
                // Convert the data to the desired type
                var esetting = new List<EnvelopeSettingGoo>();
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
                string name = String.Format("Zone_{0}", p);
                p++;
                // Add the data to the GH_Structure
                zoneNames.Add(name, path);
                if (RadSurface.Branch(path) != null)
                {
                    SolarSurfaces.AppendRange(RadSurface.Branch(path), path);
                }
            }//创建zone名字            
            DA.SetDataTree(0, zoneNames);
            DA.SetDataTree(2, SolarSurfaces);///与天空和太阳进行辐射换热的表面集合

            
            //////////////辐照计算
            double[] t = Solardata["DBT"];
            double[] ter = Solardata["Ter"];
            double[] rse = Solardata["RSE"];
            double[] zero = new double[8760];
            DataTree<double> radianceDict = new DataTree<double>();//储存结果
            for (int i = 0; i < result.PathCount; i++)
            {
                radianceDict.AddRange(zero, result.Paths[i]);
            }
            DataTree<double> solarW = new DataTree<double>();
            for (int i = 0; i < result.PathCount; i++)
            {
                solarW.AddRange(zero, result.Paths[i]);
            }


            //计算辐照  
            for (int k = 0; k < SolarSurfaces.Paths.Count; k++)//遍历每个zone
            {
                double[] radianceT = new double[8760];
                double[] radianceW = new double[8760];
                for (int i = 0; i < SolarSurfaces.Branches[k].Count; i++)  //遍历每个zone中的每个surface,在这里对surface辐照计算进行解耦              
                {
                    double[] radiance = new double[8760];
                    EnvelopeSetting SolarSurface = SolarSurfaces[SolarSurfaces.Paths[k]][i].Value.EnvelopeSetting.Value;
                    double wwr = SolarSurface.WWR;
                    double area = SolarSurface.GetPlanePartArea();

                    double E = SolarSurface.Opaques[0].Material.Emissivity;
                    double U = SolarSurface.Opaques[0].Material.UValue;
                    double Absort = SolarSurface.Opaques[0].Material.AbsorptionCoefficient;
                    double shgc = 0;
                    double we = 0;
                    if (SolarSurface.Windows != null && SolarSurface.Windows.Count > 0)
                    {
                        shgc = SolarSurface.Windows[0].Material.SHGC;
                        we = SolarSurface.Windows[0].Material.Emissivity;
                    }                    
                    

                    radiance = SolarRad(SolarSurfaces[SolarSurfaces.Paths[k]][i], SolarSurfaces, Solardata,solarVector,20, rg,out double viewFactor);
                    ///
                    for (int h = 0; h < 8760; h++)
                    {
                        radianceW[h] += (radiance[h] * shgc - we * 5.67e-8 * (Math.Pow(t[h] + 273.15, 4) - Math.Pow(ter[h] + 273.15, 4))) * area * wwr * 0.8;//窗吸收的辐照//(total * lst[3] - lst[1]  * lst[-1] * (self.Te - self.T_er))* self.rse * lst[2] * lst[0]
                        radianceT[h] += radiance[h] * (area - area * wwr) * U * Absort * rse[h] - viewFactor * rse[h] * U * E * area * (t[h] - ter[h]);// 
                    }
                }
                //var radianceDN=radianceD.Select(x => double.IsNaN(x) ? 0 : x).ToList();
                //每个surface 在这个位置进行解耦，每个surface都要进行阴影计算
                radianceDict.RemovePath(SolarSurfaces.Paths[k]);
                radianceDict.AddRange(radianceT, SolarSurfaces.Paths[k]);
                solarW.RemovePath(SolarSurfaces.Paths[k]);
                solarW.AddRange(radianceW, SolarSurfaces.Paths[k]);
            }
            DA.SetDataTree(3, radianceDict);
            DA.SetDataTree(4, solarW); 
        }


        /// <summary>
        /// 不确定这个数据转换是否有用
        /// </summary>
        /// <param name="ghStructure"></param>
        /// <returns></returns>
        //public List<GH_Surface> FlattenGHStructure(GH_Structure<SuperSurfaceGoo> ghStructure)
        //{
        //    List<GH_Surface> ghSurfaceList = new List<GH_Surface>();

        //    List<SuperSurfaceGoo> flatList = new List<SuperSurfaceGoo>((IEnumerable<SuperSurfaceGoo>)ghStructure.AllData(true));
        //    foreach (var super in flatList)
        //    {
        //        ghSurfaceList.Add(super.Value.GH_Surface);
        //    }
        //    return ghSurfaceList;
        //}
        public double[] SolarRad(SuperSurfaceGoo supersurface, GH_Structure<SuperSurfaceGoo> occluder, Dictionary<string, double[]> Solardata,List<Vector3d>solarVector, int interval,double rg, out double viewFactor, int day = 20)
        {
            double[] total = new double[8760];                       
            double radiance;
            double diffuse;


            double gama = 0;//表面方向角，南偏东为负，南偏西
            double radianceTest;
            double beta_cos = 0;//表面坡度 slope 与水平面的夹角
            double beta_sin = 0;
            GH_Surface gh_surface = supersurface.Value.GH_Surface;/////bug1
            Surface surface = supersurface.Value.EnvelopeSetting.Value.GetAllSurfaces()[0].Value.Faces[0];/////bug1
            ////面的法向量
            Point3d center = surface.GetBoundingBox(false).Center;
            _ = surface.ClosestPoint(center, out double u, out double v);
            Vector3d normal = surface.NormalAt(u, v);

            //判断面的类型
            SurfaceType surfaceType;
            if (normal.Z == 0)//墙面，垂直Slope=90°
            {
                surfaceType = SurfaceType.Facade;
                viewFactor = 0.5;
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
                viewFactor = 1;
            }
            else//斜面
            {
                surfaceType = SurfaceType.Slope;
                beta_cos = normal.Z;//表面坡度 slope 与水平面的夹角
                viewFactor = (1 - beta_cos) / 2;
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

            //判断是否存在遮挡
            ////收集遮挡面
            List<GH_Surface> occluderList = new List<GH_Surface> { };
            for (int k = 0; k < occluder.PathCount; k++)
            {
                for (int i = 0; i < occluder[k].Count; i++)
                {
                    // 跳过与自身比较
                    if (occluder[k][i] == supersurface) continue;
                    // 对当前元素进行比较
                    occluderList.Add(occluder[k][i].Value.GH_Surface);
                }
            }

            ///判断可以产生阴影的遮挡面
            List<GH_Surface> candidateSurface = new List<GH_Surface> { };
           //筛选与targetSurface同向的面
            foreach (GH_Surface obj in occluderList)
            {
                var points = GetCornerPoints(obj.Value);
                for (int i = 0; i < points.Count; i++)
                {
                    Vector3d vector = points[i] - center;
                    if (vector * normal > 0)
                    {
                        candidateSurface.Add(obj);
                        break;
                    }
                }
            }
            double[] shadows = SFCaculateYear(gh_surface, candidateSurface, Solardata, solarVector, interval);
            //计算辐照
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

                    if (radianceTest > 0) 
                    { radiance = radianceTest- radianceTest * shadows[h] ; }
                    else { radiance = 0; }
                    diffuse = Solardata["ED"][h] * ((1 - Solardata["f1"][h]) * 0.5 + (Solardata["f1"][h] * Math.Max(0, theta_cos) / Math.Max(Math.Cos(1.48353), Solardata["zenith_cos"][h])) + Solardata["f2"][h]);
                    if (diffuse < 0 || double.IsNaN(diffuse))
                    { diffuse = 0; }
                    total[h] = radiance + diffuse + (Solardata["ED"][h] + Solardata["EB"][h]) * rg * 0.5;
                }
                else if (surfaceType == SurfaceType.Plane)//屋顶，slope=0°
                {
                    radianceTest = Solardata["EB"][h] * Solardata["zenith_cos"][h];
                    if (radianceTest > 0) { radiance = radianceTest - radianceTest * shadows[h]; }
                    else { radiance = 0; }
                    diffuse = Solardata["ED"][h] * ((1 - Solardata["f1"][h]) + (Solardata["f1"][h] * Math.Max(0, Solardata["zenith_cos"][h]) / Math.Max(Math.Cos(1.48353), Solardata["zenith_cos"][h])));
                    if (diffuse < 0 || double.IsNaN(diffuse))
                    { diffuse = 0; }
                    total[h] = radiance + diffuse;
                }
                else//斜面
                {
                    double theta_cos = Solardata["zenith_cos"][h] * beta_cos + Solardata["zenith_sin"][h] * beta_sin * Math.Cos(Solardata["azimuth"][h] - gama);
                    // cos 𝜃 = cos 𝜃z cos 𝛽 +sin 𝜃z sin 𝛽 cos(𝛾s −𝛾)
                    if (theta_cos <= 0)
                    {
                        radianceTest = 0;
                    }
                    else { radianceTest = Solardata["EB"][h] * theta_cos; }
                    if (radianceTest > 0) { radiance = radianceTest - radianceTest * shadows[h]; }
                    else { radiance = 0; }
                    diffuse = Solardata["ED"][h] * ((1 - Solardata["f1"][h]) * ((1 + beta_cos) / 2) + (Solardata["f1"][h] * Math.Max(0, theta_cos) / Math.Max(Math.Cos(1.48353), Solardata["zenith_cos"][h])) + (Solardata["f2"][h] * beta_sin));
                    if (diffuse < 0 || double.IsNaN(diffuse))
                    { diffuse = 0; }
                    total[h] = radiance + diffuse + (Solardata["ED"][h] + Solardata["EB"][h]) * rg * (1 - beta_cos) / 2;
                }
            }
            return total;
        }

        public double[] SFCaculateYear(GH_Surface supersurface, List<GH_Surface> occluder, Dictionary<string, double[]> Solardata, List<Vector3d> solarVector, int interval = 1)
        {
            int totalDays = 365;
            int count = totalDays / interval + 1;
            double[][] annualShadowFactors = new double[totalDays][]; // 存储每一天24小时的遮挡系数

            // 使用并行计算加速每一天的计算

            Parallel.For(0, count, i =>
            {
                double[] sFs = new double[24];
                List<Brep> dailyShadowBrep = new List<Brep>();
                // 调用SFCaculate方法计算每天的遮挡系数
                int day = i * interval;
                sFs = SFCaculate(supersurface, occluder, Solardata, solarVector, out dailyShadowBrep, day);

                for (int j = 0; j < interval && (day + j) < totalDays; j++)
                {
                    annualShadowFactors[day + j] = sFs;
                }
            });


            int totalLength = 0;
            foreach (var row in annualShadowFactors)
            {
                totalLength += row.Length;
            }
            // 创建一个一维数组来存放所有元素
            double[] oneDimArray = new double[totalLength];
            // 填充一维数组
            int index = 0;
            foreach (var row in annualShadowFactors)
            {
                foreach (var item in row)
                {
                    oneDimArray[index++] = item;
                }
            }
            return oneDimArray;
        }

        //12.13 筛选检验
        public double[] SFCaculate(GH_Surface supersurface, List<GH_Surface> occluder, Dictionary<string, double[]> Solardata, List<Vector3d> solarVector, out List<Brep> shadowBrep, int day = 0)
        {
            double[] sFs = new double[24];
            shadowBrep = new List<Brep>();
            Surface surface = supersurface.Value.Faces[0];
            Point3d center = surface.GetBoundingBox(false).Center;
            _ = surface.ClosestPoint(center, out double u, out double v);
            Vector3d normal = surface.NormalAt(u, v);
            List<GH_Surface> candidateSurface = new List<GH_Surface>();

            foreach (GH_Surface obj in occluder)
            {
                var points = GetCornerPoints(obj.Value);
                for (int i = 0; i < points.Count(); i++)
                {
                    Vector3d vector = points[i] - center;
                    if (vector * normal > 0)
                    {
                        candidateSurface.Add(obj);
                        break;
                    }
                }
            }
            if (candidateSurface.Count == 0)
            {
                sFs = new double[24];
            }
            else
            {
                int hour = day * 24;
                for (int h = 0; h < 24; h++)
                {
                    if ((Solardata["zenith"][hour + h] > 1.57) || (normal * solarVector[hour + h] > 0))
                    {
                        sFs[h] = 0;
                    }
                    else
                    {
                        List<Brep> allShadow = new List<Brep>(); // 存储所有阴影Brep
                        List<Brep> unionBrep = new List<Brep>();
                        for (int i = 0; i < candidateSurface.Count; i++)
                        {
                            Rhino.Geometry.Plane targetPlane = new Rhino.Geometry.Plane(center, normal);
                            BrepFace occludingFace = candidateSurface[i].Face;
                            GH_Surface occluding = new GH_Surface(occludingFace.DuplicateFace(false));
                            occluding.Transform(Transform.ProjectAlong(targetPlane, solarVector[hour + h]));

                            GH_Surface shadowface = occluding;
                            Brep brep = supersurface.Value;

                            // 检查是否有交集

                            bool isIntersect = Intersection.BrepBrep(brep, shadowface.Value, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance, out Curve[] intersectionCurves, out _);
                            bool isPointInside = IsPointInsideSurface(shadowface.Value.Faces[0], center); // 检查目标是否在阴影内部

                            // 没有交点且目标点在阴影面内，遮挡系数为1
                            if (!isIntersect && isPointInside)
                            {
                                sFs[h] = 1;
                                break; // 如果没有交点，点在目标面内部，遮挡系数为1
                            }
                            else
                            {
                                if (intersectionCurves != null && intersectionCurves.Length > 0)
                                {
                                    var closedCurves = intersectionCurves.Where(c => c.IsClosed).ToArray();
                                    if (closedCurves != null && closedCurves.Length > 0)
                                    { allShadow.AddRange(Brep.CreatePlanarBreps(closedCurves, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance)); }
                                }
                            }//某小时所有的阴影                           
                            if (allShadow.Count > 0)
                            {
                                unionBrep = Brep.CreateBooleanUnion(allShadow.ToArray(), RhinoDoc.ActiveDoc.ModelAbsoluteTolerance, true).ToList();
                                shadowBrep.AddRange(unionBrep); // 累积所有交集的Brep
                                double totalOverlapArea = 0;
                                foreach (Brep shadow in unionBrep)
                                {
                                    totalOverlapArea += AreaMassProperties.Compute(shadow).Area;
                                }
                                double targetArea = supersurface.Value.GetArea();
                                // 计算遮挡系数
                                sFs[h] = totalOverlapArea / targetArea;
                            }//合并后求面积
                            else
                            {
                                sFs[h] = 0;
                            }
                        }
                    }
                }
            }
            return sFs;
        }

        //

        //
        public bool IsPointInsideSurface(Surface surface, Point3d point)
        {
            surface.ClosestPoint(point, out double u, out double v);
            Point3d closestPoint = surface.PointAt(u, v);
            return closestPoint.DistanceTo(point) < 0.001;
        }
        /// <summary>
        /// 提取Brep角点
        /// </summary>
        /// <param name="surface"></param>
        /// <returns></returns>
        public List<Point3d> GetCornerPoints(Brep surface)
        {
            List<Point3d> cornerPoints = new List<Point3d>();

            // 获取 Surface 的边界曲线
            Curve[] boundaryCurves = surface.DuplicateEdgeCurves(true);

            // 提取边界曲线的端点作为角点
            foreach (Curve curve in boundaryCurves)
            {
                Point3d startPoint = curve.PointAtStart;
                Point3d endPoint = curve.PointAtEnd;

                if (!cornerPoints.Contains(startPoint))
                {
                    cornerPoints.Add(startPoint);
                }

                if (!cornerPoints.Contains(endPoint))
                {
                    cornerPoints.Add(endPoint);
                }
            }
            return cornerPoints;
        }
    }
}    