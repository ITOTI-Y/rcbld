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
using Rhino.Geometry.Intersect;
using System.Security.Cryptography;
using System.Drawing;


namespace RCBldGH.Components.Envelope.envelopeSurface
{
    public class MaterialAssign3_1Comp : GH_Component
    {
        public MaterialAssign3_1Comp() : base("MaterialAssign3.1", "Material to Brep", "Assignment MaterialSetting to breps", "RCBldGH", "2.Envelops")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.primary;
        public override Guid ComponentGuid => new Guid("{97951a59-dc12-479c-9c44-cd8d3696d747}");
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
            pManager.AddGenericParameter("SuperSurface", "setting", "Envelope setting", GH_ParamAccess.tree);
            pManager.AddSurfaceParameter("Surface", "setting", "Envelope setting", GH_ParamAccess.list);
            pManager.AddCurveParameter("curve", "setting", "Envelope setting", GH_ParamAccess.list);

            //pManager.AddTextParameter("Envelope setting", "setting", "Envelope setting", GH_ParamAccess.tree);
        }

        public bool IsSurfaceAdjacent(SuperSurface a, SuperSurface b, out int state)//通过法向量方向以及一个bounding tolerance 判断是否相邻
        {
            state = -1;
            bool isOnSurface = false;
            if (a.Normal.IsParallelTo(b.Normal) == -1)//判断面是否反向
            {
                b.Surface.ClosestPoint(a.Centroid, out double u, out double v);
                Point3d bPoint = b.Surface.PointAt(u, v);//b距离a的中点最近的点
                a.Surface.ClosestPoint(bPoint, out double q, out double e);
                Point3d aPoint = a.Surface.PointAt(q, e);//a距离b的中点最近的点
                var bounding = (aPoint - b.Centroid);
                if (bounding.Length > 1)//两个面中心点距离在1以上
                { bounding.Unitize(); }
                var aBoundingPoint = aPoint - 0.1 * bounding;
                a.Surface.ClosestPoint(aBoundingPoint, out double r, out double t);
                Point3d bBoundingPoint = a.Surface.PointAt(r, t);//b距离a的中点最近的点
                if (aBoundingPoint.DistanceTo(bBoundingPoint) < 0.001)
                {
                    isOnSurface = true;
                    //1、完全重合
                    if ((a.Centroid.DistanceTo(b.Centroid) < 0.01) && (Math.Abs(a.Area - b.Area) < 3))//3和0.01都是tolerance
                    {
                        state = 0;
                    }
                    else//2、不完全重合
                    {
                        state = 1;
                    }
                }
            }          
            return isOnSurface;
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
            //bug检测
            List<GH_Surface> Surfaces = new List<GH_Surface> { };
            List<Curve> intersect = new List<Curve> { };

            List<SuperBrep> superBreps= new List<SuperBrep>();
            for (int i = 0; i < rooms.Count; i++)//建筑
            {
                SuperBrep superBrep=new SuperBrep(rooms[i].Value);
                foreach (var ceiling in superBrep.Ceiling)
                {
                    ceiling.Material = materialSetting.RoofMaterial;
                }
                foreach (var wall in superBrep.Wall)
                {
                    wall.Material = materialSetting.ExternalWallMaterial;
                }
                if (superBrep.MinZ == 0)
                {                    
                    foreach (var floor in superBrep.Floor)
                    {
                        floor.Material = materialSetting.GroundMaterial;
                    }                    
                }
                else
                {                   
                    foreach (var floor in superBrep.Floor)
                    {
                        floor.Material = materialSetting.ExternalFloorMaterial;
                    }                   
                }                
                superBreps.Add(superBrep);
            }                      
            for (int i = 0; i < superBreps.Count; i++)//每个房间
            {                
                for (int j = i + 1; j < superBreps.Count; j++)//依次比较
                {
                    if (superBreps[i].IsAdjacent(superBreps[j]))//判断是否存在相邻可能
                    {
                        if (superBreps[i].MinZ == superBreps[j].MaxZ)//底面与其他Brep相邻
                        {
                            Assign(superBreps[i].Floor, superBreps[j].Ceiling, materialSetting.InternalFloorMaterial, materialSetting.ExternalFloorMaterial, materialSetting.RoofMaterial);
                        }
                        else if (superBreps[i].MaxZ == superBreps[j].MinZ)//顶面与其他Brep相邻
                        {
                            Assign(superBreps[i].Ceiling, superBreps[j].Floor, materialSetting.InternalFloorMaterial, materialSetting.RoofMaterial, materialSetting.ExternalFloorMaterial);
                        }
                        else//墙面与其他Brep相邻 
                        {
                            Assign(superBreps[i].Wall, superBreps[j].Wall, materialSetting.InternalWallMaterial, materialSetting.ExternalWallMaterial, materialSetting.ExternalWallMaterial);
                        }
                    }
                }
            }
            for (int i = 0; i < superBreps.Count; i++)//建筑
            {
                GH_Path path = new GH_Path(i);
                prTree.AddRange(superBreps[i].Ceiling, path);
                prTree.AddRange(superBreps[i].Wall, path);
                prTree.AddRange(superBreps[i].Floor, path);                
            }
            DA.SetDataTree(2, prTree);
            //分配窗
            for (int k = 0; k < windows.Count; k++)
            {
                for (int i = 0; i < superBreps.Count; i++)//每个房间
                {
                    for (int j = 0; j < prTree.Branch(prTree.Paths[i]).Count; j++)//每个面
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
            OK:;
            }//为supersurface添加window
            // DataTree<string> suName = new DataTree<string>();
            foreach (var branch in prTree.Branches)
            {
                // Get the data and path of the branch
                var data = branch;
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
            DA.SetDataList(3, Surfaces);
            DA.SetDataList(4, intersect);

        }
        public void Assign(List<SuperSurface> a, List<SuperSurface> b,Modules.Material interMaterial, Modules.Material exterMaterialA, Modules.Material exterMaterialB)//a=superBreps[i].Floor//b=superBreps[j].Ceiling
        {
            List<SuperSurface> iSurface = new List<SuperSurface> { };
            List<SuperSurface> jSurface = new List<SuperSurface> { };
            for (int k = 0; k < a.Count; k++)
            {
                for (int g = 0; g <b.Count; g++)
                {
                    if (IsSurfaceAdjacent(a[k],b[g], out int state))//找到了相邻的面
                    {
                        if (state == 0)
                        {
                            a[k].Material = interMaterial;
                            b[g].Material = interMaterial;
                            a[k].Name = b[g].Name;
                        }
                        else
                        {
                            _ = Intersection.BrepBrep(a[k].GH_Surface.Value, b[g].GH_Surface.Value, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance, out Curve[] intersectionCurves, out _);
                            Curve[] joinedCurves = Curve.JoinCurves(intersectionCurves, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                            Curve intersectionCurve = joinedCurves[0]; // 取第一个交集曲线
                            Brep brep = Brep.CreatePlanarBreps(intersectionCurve, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance)[0];

                            Vector3d normal = brep.Faces[0].NormalAt(0.1, 0.1);
                            Brep[] jBreps;
                            Brep[] iBreps;
                            if (normal.IsParallelTo(b[g].Surface.NormalAt(0.1, 0.1)) == -1) // 假设墙面的法线方向应指向正Z方向
                            {
                                iBreps = Brep.CreateBooleanDifference(a[k].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                SuperSurface interA = new SuperSurface(new GH_Surface(brep))
                                {
                                    Material = interMaterial,
                                    Name = b[g].Name
                                };
                                a[k] = interA;                                
                                brep.Flip();
                                jBreps = Brep.CreateBooleanDifference(b[g].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                SuperSurface interB = new SuperSurface(new GH_Surface(brep))
                                {
                                    Material = interMaterial,
                                    Name = b[g].Name
                                };
                                b[g] = interB;
                            }
                            else
                            {
                                jBreps = Brep.CreateBooleanDifference(b[g].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                SuperSurface interB = new SuperSurface(new GH_Surface(brep))
                                {
                                    Material = interMaterial,
                                    Name = b[g].Name
                                };
                                b[g] = interB;
                                brep.Flip();
                                SuperSurface interA = new SuperSurface(new GH_Surface(brep))
                                {
                                    Material = interMaterial,
                                    Name = b[g].Name
                                };
                                a[k] = interA;
                                iBreps = Brep.CreateBooleanDifference(a[k].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                            }

                            if (jBreps != null && jBreps.Length > 0)//多余部分加入原列表，继续循环
                            {
                                for (int q = 0; q < jBreps.Count(); q++)
                                {
                                    if (jBreps[q].GetArea() > 0.1)
                                    {
                                        SuperSurface exter = new SuperSurface(new GH_Surface(jBreps[q]))
                                        {
                                            Material = exterMaterialB
                                        };
                                        jSurface.Add(exter);
                                    }
                                }
                            }
                            if (iBreps != null && iBreps.Length > 0)//多余部分加入原列表，继续循环
                            {
                                for (int q = 0; q < iBreps.Count(); q++)
                                {
                                    if (iBreps[q].GetArea() > 0.1)
                                    {
                                        SuperSurface exter = new SuperSurface(new GH_Surface(iBreps[q]));
                                        exter.Material = exterMaterialA;
                                        iSurface.Add(exter);
                                    }
                                }                                
                            }
                            //重叠部分输入inter材质，替代原Surface                            
                        }
                    }
                }
            }
            a.AddRange(iSurface);
            b.AddRange(jSurface);
        }    
    }
}







