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
using RCBldGH.Components.Envelope;


namespace RCBldGH.Components.Envelope.envelopeSurface
{
    //标准
    public class MaterialAssignComp : GH_Component
    {
        public MaterialAssignComp() : base("MaterialAssign", "Material to Brep", "Assignment MaterialSetting to breps", "RCBldGH", "2.Envelops")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.primary;
        public override Guid ComponentGuid => new Guid("{8bc61b52-620e-4940-b9dd-2fba81855ce2}");
        protected override System.Drawing.Bitmap Icon => Properties.Resources.MSettingAssign;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddGenericParameter("MaterialSetting", "MaterialSetting", "set the room material set,using roof material/externalfl", GH_ParamAccess.item);
            
            pManager.AddBrepParameter("Rooms", "R", "breps to represent rooms", GH_ParamAccess.list);
            WindowParam windowParam = new WindowParam();
            pManager.AddParameter(windowParam, "Windows", "Windows", "Windows objects.", GH_ParamAccess.list);
            pManager[2].Optional = true;
        }
        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddTextParameter("Zone_Name", "name", "name", GH_ParamAccess.tree);
            pManager.AddGenericParameter("Envelope setting", "setting", "Envelope setting", GH_ParamAccess.tree);
            //pManager.AddTextParameter("Envelope setting", "setting", "Envelope setting", GH_ParamAccess.tree);
            pManager.AddGenericParameter("SuperSurface", "setting", "Envelope setting", GH_ParamAccess.tree);
        }
        protected override void SolveInstance(IGH_DataAccess DA)
        {
            List<GH_Brep> rooms = new List<GH_Brep>();
            MaterialSetting materialSetting;
            List<WindowGoo> windows = new List<WindowGoo>();
            object materialSettingObj = null;
            if (!DA.GetData(0, ref materialSettingObj))
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
            if (!DA.GetDataList(1, rooms))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Rooms message");
                return;
            }
            DA.GetDataList(2, windows);
            GH_Structure<EnvelopeSettingGoo> result = new GH_Structure<EnvelopeSettingGoo>();

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
                    {  // Otherwise, it is a wall face
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
                                prTree[prTree.Paths[i], j].Material = materialSetting.InternalFloorMaterial;
                                //if (Math.Abs(buildingBottoms[k].EnvelopeSetting.Value.GetPlanePartArea() - prTree[prTree.Paths[i], j].EnvelopeSetting.Value.GetPlanePartArea())<5)
                                {
                                    prTree[prTree.Paths[i], j].Name=buildingBottoms[k].Name ;//9/8
                                }
                                isExter = false;
                                break;
                            }
                        }
                        if (isExter)
                        {
                            prTree[prTree.Paths[i], j].Material = materialSetting.RoofMaterial;
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
                                //if (Math.Abs(buildingWalls[k].EnvelopeSetting.Value.GetPlanePartArea() - prTree[prTree.Paths[i], j].EnvelopeSetting.Value.GetPlanePartArea())<5)
                                {
                                    prTree[prTree.Paths[i], j].Name=buildingWalls[k].Name;//9/8
                                }
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
                                //if (Math.Abs(buildingTops[k].EnvelopeSetting.Value.GetPlanePartArea() - prTree[prTree.Paths[i], j].EnvelopeSetting.Value.GetPlanePartArea())<5)
                                { 
                                     prTree[prTree.Paths[i], j].Name= buildingTops[k].Name; ///9/8
                                }
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
           // DataTree<string> suName = new DataTree<string>();
            foreach (var branch in prTree.Branches)
            {
                // Get the data and path of the branch
                var data = branch as List<SuperSurface>;
                var path = prTree.Paths[prTree.Branches.IndexOf(branch)];
                // Convert the data to the desired type
                var esetting = new List<EnvelopeSettingGoo>();
                //var lala=new List<string>();
                for (int i = 0; i < data.Count; i++)
                {
                    data[i].EnvelopeSetting.Value.Name = data[i].Name;
                    esetting.Add(data[i].EnvelopeSetting);
                    //lala.Add(data[i].Name);
                }
                // Add the data to the GH_Structure
                //suName.AddRange(lala,path);
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
            }//创建zone名字
            DA.SetDataTree(0, zoneNames);
            DA.SetDataTree(2, prTree);
        }
    }
}








