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
using Rhino.Commands;


namespace RCBldGH.Components.Envelope.envelopeSurface
{
    public class MaterialAssign3Comp : GH_Component
    {
        public MaterialAssign3Comp() : base("MaterialAssign4.0", "Material to Brep", "Assignment MaterialSetting to breps", "RCBldGH", "2.Envelops")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.primary;
        public override Guid ComponentGuid => new Guid("{3785dcd4-3b24-45d8-9649-91905fb5d09b}");
        protected override Bitmap Icon => Properties.Resources.MSettingAssign;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddBrepParameter("Breps", "B", "breps to represent rooms", GH_ParamAccess.list);
            WindowParam windowParam = new WindowParam();
            pManager.AddParameter(windowParam, "Windows", "Windows", "Windows objects.", GH_ParamAccess.list);
            pManager[1].Optional = true;
            pManager.AddGenericParameter("MaterialSetting", "MaterialSetting", "set the room material setting, to be used with materialSetting Component", GH_ParamAccess.item);            
           
            pManager.AddGenericParameter("Program", "P", "Building usage conditions for the building brep", GH_ParamAccess.list);
            pManager.AddGenericParameter("ScheduleSetting", "S", "ScheduleSetting for the building brep.", GH_ParamAccess.list);
        }
        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {                      
            pManager.AddGenericParameter("SuperBreps", "setting", "Envelope setting", GH_ParamAccess.list);
            pManager.AddTextParameter("Text", "T", "Zone text", GH_ParamAccess.list);
            //pManager.AddGenericParameter("Superface", "setting", "Envelope setting", GH_ParamAccess.list);
            pManager.AddBrepParameter("debug", "T", "Zone text", GH_ParamAccess.list);
        }
        private const string Br = "\r\n";
        List<GH_Surface> results = new List<GH_Surface> { };
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
            if (!DA.GetData(2, ref materialSettingObj))
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
            if (!DA.GetDataList(0, rooms))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Rooms message");
                return;
            }
            DA.GetDataList(1, windows);
            
            List < Program > programs= new List<Program> { };
            DA.GetDataList("Program",  programs);

            List<Schedule.ScheduleSetting> schedules = new List<RCBldGH.Modules.Schedule.ScheduleSetting> { };
            DA.GetDataList("ScheduleSetting", schedules);

            List<Brep> debug = new List<Brep> { };

            List<SuperBrep> superBreps = new List<SuperBrep>();
            for (int i = 0; i < rooms.Count; i++)//建筑
            {
                SuperBrep superBrep = new SuperBrep(rooms[i].Value);
                
                foreach (var ceiling in superBrep.Ceiling)
                {
                    ceiling.Material = materialSetting.RoofMaterial;
                }
                foreach (var wall in superBrep.Wall)
                {
                    wall.Material = materialSetting.ExternalWallMaterial;
                }
                if (superBrep.MinZ < 1)
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
            

            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"屋顶{superBreps[0].Ceiling.Count}，底面{superBreps[1].Floor.Count}" );
            for (int i = 0; i < superBreps.Count; i++)
            {
                superBreps[i].Name = string.Format("Zone_{0}", i);
            }
            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, "zone命名完成" );
            for (int i = 0; i < (superBreps.Count - 1); i++)//每个房间
            {
                for (int j = i + 1; j < superBreps.Count; j++)//依次比较
                {
                    if (superBreps[i].IsAdjacent(superBreps[j]))//判断是否存在相邻可能
                    {
                        //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"Rooms {i} and {j} are adjacent."));
                        if (Math.Abs(superBreps[i].MinZ - superBreps[j].MaxZ)<0.1)//底面与其他Brep相邻
                        {
                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"Rooms {i} and {j} are 底面相邻."));
                            //Assign(superBreps[i], superBreps[j], superBreps[i].Floor, superBreps[j].Ceiling, materialSetting.InternalFloorMaterial, materialSetting.ExternalFloorMaterial, materialSetting.RoofMaterial, 0);
                            
                            for (int k = 0; k < superBreps[i].Floor.Count; k++)
                            {
                                for (int g = 0; g < superBreps[j].Ceiling.Count; g++)
                                {
                                    if (IsSurfaceAdjacent(superBreps[i].Floor[k], superBreps[j].Ceiling[g], out int state))//找到了相邻的面
                                    {
                                        List<SuperSurface> iSurface = new List<SuperSurface> { };
                                        List<SuperSurface> jSurface = new List<SuperSurface> { };
                                        //AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, ($"Surface  {k} and {g} are 相邻.{c}"));
                                        c++;
                                        if (state == 0)
                                        {
                                           // AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ("完全重合"));
                                            superBreps[i].Floor[k].Material = materialSetting.InternalFloorMaterial;
                                            superBreps[j].Ceiling[g].Material = materialSetting.InternalFloorMaterial;
                                            superBreps[i].Floor[k].Name = superBreps[j].Ceiling[g].Name;
                                            
                                             superBreps[i].AdjacentFloorList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[j], ContactArea = superBreps[j].Ceiling[g].Area });
                                             superBreps[j].AdjacentCeilingList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[i], ContactArea = superBreps[i].Floor[k].Area });
                                           

                                           // AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, ($"重合运算结束{g}"));
                                        }
                                        else
                                        {
                                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ("不完全重合"));
                                            _ = Intersection.BrepBrep(superBreps[i].Floor[k].GH_Surface.Value, superBreps[j].Ceiling[g].GH_Surface.Value, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance, out Curve[] intersectionCurves, out _);
                                            if (intersectionCurves == null || intersectionCurves.Count() < 1)
                                            {
                                                break;
                                            }
                                            Curve[] joinedCurves = Curve.JoinCurves(intersectionCurves, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                            Curve intersectionCurve = joinedCurves[0]; // 取第一个交集曲线
                                            if (intersectionCurve.IsClosed == false)
                                            {
                                                break;
                                            }

                                            Brep brep = Brep.CreatePlanarBreps(intersectionCurve, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance)[0];
                                            Vector3d normal = brep.Faces[0].NormalAt(0.1, 0.1);
                                            Brep[] jBreps;
                                            Brep[] iBreps;
                                            if (normal.IsParallelTo(superBreps[j].Ceiling[g].Surface.NormalAt(0.1, 0.1)) == -1) // 假设墙面的法线方向应指向正Z方向
                                            {
                                                iBreps = Brep.CreateBooleanDifference(superBreps[i].Floor[k].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interA = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalFloorMaterial,
                                                    Name = superBreps[j].Ceiling[g].Name
                                                };
                                                superBreps[i].Floor[k] = interA;
                                                brep.Flip();
                                                jBreps = Brep.CreateBooleanDifference(superBreps[j].Ceiling[g].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interB = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalFloorMaterial,
                                                    Name = superBreps[j].Ceiling[g].Name
                                                };
                                                superBreps[j].Ceiling[g] = interB;
                                            }
                                            else
                                            {
                                                jBreps = Brep.CreateBooleanDifference(superBreps[j].Ceiling[g].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interB = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalFloorMaterial,
                                                    Name = superBreps[j].Ceiling[g].Name
                                                };
                                                superBreps[j].Ceiling[g] = interB;
                                                brep.Flip();
                                                iBreps = Brep.CreateBooleanDifference(superBreps[i].Floor[k].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interA = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalFloorMaterial,
                                                    Name = superBreps[j].Ceiling[g].Name
                                                };
                                                superBreps[i].Floor[k] = interA;                                                
                                            }
                                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"裁剪完成{g}{c}");
                                            if (jBreps != null && jBreps.Length > 0)//多余部分加入原列表，继续循环
                                            {
                                                for (int q = 0; q < jBreps.Count(); q++)
                                                {
                                                    if (jBreps[q].GetArea() > 0.1)
                                                    {
                                                        SuperSurface exter = new SuperSurface(new GH_Surface(jBreps[q]))
                                                        {
                                                            Material = materialSetting.RoofMaterial
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
                                                        exter.Material = materialSetting.ExternalFloorMaterial;
                                                        iSurface.Add(exter);
                                                    }
                                                }
                                            }
                                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"交错判断结束{g}{c}");
                                            
                                                superBreps[i].AdjacentFloorList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[j], ContactArea = superBreps[j].Ceiling[g].Area });
                                                superBreps[j].AdjacentCeilingList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[i], ContactArea = superBreps[i].Floor[k].Area });


                                            superBreps[i].Floor.AddRange(iSurface);
                                            superBreps[j].Ceiling.AddRange(jSurface);
                                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"相邻信息存储结束{g}{c}");
                                        }
                                    }
                                }
                            }

                        }//底面与顶面相邻
                        else if (Math.Abs(superBreps[j].MinZ - superBreps[i].MaxZ)<0.1)//顶面与其他Brep相邻
                        {
                            AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"Rooms {i} and {j} are 顶面相邻."));
                            //Assign(superBreps[i], superBreps[j], superBreps[i].Ceiling, superBreps[j].Floor, materialSetting.InternalFloorMaterial, materialSetting.RoofMaterial, materialSetting.ExternalFloorMaterial, 1);
                            for (int k = 0; k < superBreps[i].Ceiling.Count; k++)
                            {
                                for (int g = 0; g < superBreps[j].Floor.Count; g++)
                                {
                                    if (IsSurfaceAdjacent(superBreps[i].Ceiling[k], superBreps[j].Floor[g], out int state))//找到了相邻的面
                                    {
                                        List<SuperSurface> iSurface = new List<SuperSurface> { };
                                        List<SuperSurface> jSurface = new List<SuperSurface> { };
                                        AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"Surface  {k} and {g} are 相邻.{c}"));
                                        if (state == 0)
                                        {
                                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ("完全重合"));
                                            superBreps[i].Ceiling[k].Material = materialSetting.InternalFloorMaterial;
                                            superBreps[j].Floor[g].Material = materialSetting.InternalFloorMaterial;
                                            superBreps[i].Ceiling[k].Name = superBreps[j].Floor[g].Name;
                                            superBreps[i].AdjacentCeilingList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[j], ContactArea = superBreps[j].Floor[g].Area });
                                            superBreps[j].AdjacentFloorList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[i], ContactArea = superBreps[i].Ceiling[k].Area });
                                        }
                                        else
                                        {
                                            _ = Intersection.BrepBrep(superBreps[i].Ceiling[k].GH_Surface.Value, superBreps[j].Floor[g].GH_Surface.Value, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance, out Curve[] intersectionCurves, out _);
                                            if (intersectionCurves == null || intersectionCurves.Count() < 1)
                                            {
                                                break;
                                            }
                                            AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"交错成功"));
                                            Curve[] joinedCurves = Curve.JoinCurves(intersectionCurves, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                            Curve intersectionCurve = joinedCurves[0]; // 取第一个交集曲线
                                            if (intersectionCurve.IsClosed == false)
                                            {
                                                break;
                                            }
                                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"交错曲线封闭"));
                                            Brep brep = Brep.CreatePlanarBreps(intersectionCurve, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance)[0];
                                            
                                            Vector3d normal = brep.Faces[0].NormalAt(0.1, 0.1);
                                            Brep[] jBreps;
                                            Brep[] iBreps;
                                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"向量方向{superBreps[j].Floor[g].Surface.NormalAt(0.1, 0.1)}and{normal}"));
                                            if (normal.IsParallelTo(superBreps[j].Floor[g].Surface.NormalAt(0.1, 0.1)) == -1) // 假设墙面的法线方向应指向正Z方向
                                            {
                                                iBreps = Brep.CreateBooleanDifference(superBreps[i].Ceiling[k].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interA = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalFloorMaterial,
                                                    Name = superBreps[j].Floor[g].Name
                                                };
                                                
                                                superBreps[i].Ceiling[k] = interA;
                                                brep.Flip();
                                                jBreps = Brep.CreateBooleanDifference(superBreps[j].Floor[g].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interB = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalFloorMaterial,
                                                    Name = superBreps[j].Floor[g].Name
                                                };
                                                superBreps[j].Floor[g] = interB;
                                            }
                                            else
                                            {
                                                jBreps = Brep.CreateBooleanDifference(superBreps[j].Floor[g].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interB = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalFloorMaterial,
                                                    Name = superBreps[j].Floor[g].Name
                                                };
                                                superBreps[j].Floor[g] = interB;
                                                brep.Flip();
                                                iBreps = Brep.CreateBooleanDifference(superBreps[i].Ceiling[k].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interA = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalFloorMaterial,
                                                    Name = superBreps[j].Floor[g].Name
                                                };                                                
                                                superBreps[i].Ceiling[k] = interA;     
                                            }
                                            // AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"裁剪完成{g}{c}");
                                            if (jBreps != null && jBreps.Length > 0)//多余部分加入原列表，继续循环
                                            {
                                                for (int q = 0; q < jBreps.Count(); q++)
                                                {
                                                    if (jBreps[q].GetArea() > 0.1)
                                                    {
                                                        SuperSurface exter = new SuperSurface(new GH_Surface(jBreps[q]))
                                                        {
                                                            Material = materialSetting.ExternalFloorMaterial
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
                                                        exter.Material = materialSetting.RoofMaterial;
                                                        iSurface.Add(exter);
                                                    }
                                                }
                                            }
                                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"交错判断结束{g}{c}");                                            

                                            superBreps[i].AdjacentCeilingList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[j], ContactArea = superBreps[j].Floor[g].Area });
                                            superBreps[j].AdjacentFloorList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[i], ContactArea = superBreps[i].Ceiling[k].Area });

                                            superBreps[i].Ceiling.AddRange(iSurface);
                                            superBreps[j].Floor.AddRange(jSurface);
                                        
                                    }                                       
                                    }
                                }
                            }
                        }//顶面与底面相邻
                        else
                        {
                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"Rooms {i} and {j} are 墙面相邻."));
                            //Assign(superBreps[i], superBreps[j], superBreps[i].Wall, superBreps[j].Wall, materialSetting.InternalWallMaterial, materialSetting.ExternalWallMaterial, materialSetting.ExternalWallMaterial, 2);
                            for (int k = 0; k < superBreps[i].Wall.Count; k++)
                            {
                                for (int g = 0; g < superBreps[j].Wall.Count; g++)
                                {
                                    if (IsSurfaceAdjacent(superBreps[i].Wall[k], superBreps[j].Wall[g], out int state))//找到了相邻的面
                                    {
                                        List<SuperSurface> iSurface = new List<SuperSurface> { };
                                        List<SuperSurface> jSurface = new List<SuperSurface> { };
                                        //AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, ($"Surface  {k} and {g} are 相邻."));

                                        if (state == 0)
                                        {
                                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ("完全重合"));
                                            superBreps[i].Wall[k].Material = materialSetting.InternalWallMaterial;
                                            superBreps[j].Wall[g].Material = materialSetting.InternalWallMaterial;
                                            superBreps[i].Wall[k].Name = superBreps[j].Wall[g].Name;
                                            superBreps[i].AdjacentWallList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[j], ContactArea = superBreps[j].Wall[g].Area });
                                            superBreps[j].AdjacentWallList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[i], ContactArea = superBreps[i].Wall[k].Area });

                                        }
                                        else
                                        {
                                            _ = Intersection.BrepBrep(superBreps[i].Wall[k].GH_Surface.Value, superBreps[j].Wall[g].GH_Surface.Value, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance, out Curve[] intersectionCurves, out _);
                                            if (intersectionCurves == null || intersectionCurves.Count() < 1)
                                            {
                                                break;
                                            }
                                            Curve[] joinedCurves = Curve.JoinCurves(intersectionCurves, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                            Curve intersectionCurve = joinedCurves[0]; // 取第一个交集曲线
                                            if (intersectionCurve.IsClosed == false)
                                            {
                                                break;
                                            }

                                            Brep brep = Brep.CreatePlanarBreps(intersectionCurve, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance)[0];

                                            Vector3d normal = brep.Faces[0].NormalAt(0.1, 0.1);
                                            Brep[] jBreps;
                                            Brep[] iBreps;
                                            if (normal.IsParallelTo(superBreps[j].Wall[g].Surface.NormalAt(0.1, 0.1)) == -1) // 假设墙面的法线方向应指向正Z方向
                                            {
                                                iBreps = Brep.CreateBooleanDifference(superBreps[i].Wall[k].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interA = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalWallMaterial,
                                                    Name = superBreps[j].Wall[g].Name
                                                };
                                                superBreps[i].Wall[k] = interA;
                                                brep.Flip();
                                                jBreps = Brep.CreateBooleanDifference(superBreps[j].Wall[g].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interB = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalWallMaterial,
                                                    Name = superBreps[j].Wall[g].Name
                                                };
                                                superBreps[j].Wall[g] = interB;
                                            }
                                            else
                                            {
                                                jBreps = Brep.CreateBooleanDifference(superBreps[j].Wall[g].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interB = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalWallMaterial,
                                                    Name = superBreps[j].Wall[g].Name
                                                };
                                                superBreps[j].Wall[g] = interB;
                                                brep.Flip();
                                                iBreps = Brep.CreateBooleanDifference(superBreps[i].Wall[k].GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                                                SuperSurface interA = new SuperSurface(new GH_Surface(brep))
                                                {
                                                    Material = materialSetting.InternalWallMaterial,
                                                    Name = superBreps[j].Wall[g].Name
                                                };
                                                superBreps[i].Wall[k] = interA;
                                               
                                            }
                                            if (jBreps != null && jBreps.Length > 0)//多余部分加入原列表，继续循环
                                            {
                                                for (int q = 0; q < jBreps.Count(); q++)
                                                {
                                                    if (jBreps[q].GetArea() > 0.1)
                                                    {
                                                        SuperSurface exter = new SuperSurface(new GH_Surface(jBreps[q]))
                                                        {
                                                            Material = materialSetting.ExternalWallMaterial
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
                                                        exter.Material = materialSetting.ExternalWallMaterial;
                                                        iSurface.Add(exter);
                                                    }
                                                }
                                            }

                                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"交错判断结束{g}{c}");


                                            superBreps[i].AdjacentWallList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[j], ContactArea = superBreps[j].Wall[g].Area });
                                            superBreps[j].AdjacentWallList.Add(new AdjacentBrepAreaPare() { SuperBrep = superBreps[i], ContactArea = superBreps[i].Wall[k].Area });
                                            superBreps[i].Wall.AddRange(iSurface);
                                            superBreps[j].Wall.AddRange(jSurface);
                                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"相邻信息存储结束{g}");
                                        }
                                    }
                                }
                            }
                        }//墙面与其他Brep相邻 
                    }
                }
            }
            debug.AddRange(superBreps[0].Ceiling.Select(x=>x.GH_Surface.Value));
            debug.AddRange(superBreps[0].Floor.Select(x => x.GH_Surface.Value));
            debug.AddRange(superBreps[0].Wall.Select(x => x.GH_Surface.Value));
            DA.SetDataList(2, debug);
            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, "材料分配完成" );            
            for (int k = 0; k < windows.Count; k++)
            {
                Point3d windowCentroid = windows[k].Value.GeometrySurface.Face.PointAt(windows[k].Value.GeometrySurface.Face.Domain(0).Mid, windows[k].Value.GeometrySurface.Face.Domain(1).Mid);
                for (int i = 0; i < superBreps.Count; i++)//每个房间
                {
                    for (int j = 0; j < superBreps[i].Wall.Count; j++)//每个面
                    {
                        superBreps[i].Wall[j].Surface.ClosestPoint(windowCentroid, out double u, out double v);
                        Point3d point = superBreps[i].Wall[j].Surface.PointAt(u, v);
                        if (windowCentroid.DistanceTo(point) < 0.01)
                        {
                            superBreps[i].Wall[j].Window.Add(windows[k].Value);
                            goto OK;
                        }
                    }
                }
            OK:;
            }//分配窗   

            if (programs.Count == 1)
            {
                for (int i = 0; i < superBreps.Count; i++)
                {
                    bool isZoneClosed = superBreps[i].IsZoneClosed(out Brep closedBrep);
                    if (!isZoneClosed)
                    {
                        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, $"Zone({superBreps[i].Name}) is not closed!");
                        return;
                    }
                    if (i == 2)
                    {
                        var gSurfaces = superBreps[i].Wall.Select(s => s.GH_Surface)
                       .Concat(superBreps[i].Floor.Select(s => s.GH_Surface))
                       .Concat(superBreps[i].Ceiling.Select(s => s.GH_Surface))
                       .ToList();
                        results = gSurfaces;
                        
                    }


                    double zoneVolume = closedBrep.GetVolume();
                    double area = superBreps[i].GetZoneArea();
                    superBreps[i].Area = area;
                    superBreps[i].Height = zoneVolume / superBreps[i].Area;
                    superBreps[i].MaterialSetting = materialSetting;
                    superBreps[i].Occupancy = programs[0].Occupancy;
                    superBreps[i].MetabolicRate = programs[0].MetabolicRate;
                    superBreps[i].Appliance = programs[0].Appliance;
                    superBreps[i].LightingTemplate = programs[0].LightingTemplate;
                    superBreps[i].OutdoorAir = programs[0].OutdoorAir;
                    superBreps[i].AirInfiltrationRate = programs[0].AirInfiltrationRate;
                    superBreps[i].AirInfiltrationLevel = programs[0].AirInfiltrationLevel;
                    superBreps[i].VentilationType = programs[0].VentilationType;
                    superBreps[i].NightFlushing = programs[0].NightFlushing;
                    superBreps[i].WindowAreaOpenPercentage = programs[0].WindowAreaOpenPercentage;
                    superBreps[i].AngleOfOpening = programs[0].AngleOfOpening;
                    superBreps[i].DHW = programs[0].DHW;
                    superBreps[i].HvacTemplate = programs[0].HvacTemplate;
                    superBreps[i].AirInfiltrationSchedule = schedules[0].AirInfiltrationSchedule;
                    superBreps[i].IndoorTemperatureSetPointSchedule = schedules[0].IndoorTemperatureSetPointSchedule;
                    superBreps[i].BuildingUseSchedule = schedules[0].BuildingUseSchedule;
                    //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"program and schedule setting applied to {superBreps[i].Name}"));

                    List<SuperSurface> flat = new List<SuperSurface> { };
                    flat.AddRange(superBreps[i].Ceiling);
                    flat.AddRange(superBreps[i].Floor);
                    foreach (var surface in superBreps[i].Wall)
                    {
                        if (surface.Material.MaterialType == MaterialType.InternalWall)
                        {
                            superBreps[i].InteriorWallMaterial = surface.Material;
                            break;
                        }
                    }
                    foreach (var surface in flat)
                    {
                        if (surface.Material.MaterialType == MaterialType.InternalFloor)
                        {
                            superBreps[i].InteriorFloorMaterial = surface.Material;
                            break;
                        }
                    }//设置interiorFloorMaterial和interiorWallMaterial

                    foreach (var surface in superBreps[i].Floor)//
                    {
                        if (surface.Material.MaterialType == MaterialType.Ground)
                        {
                            superBreps[i].AdjacentGroundList.Add(new AdjacentBrepAreaPare() { SuperBrep = null, ContactArea = surface.Area });
                            break;
                        }
                    }//设置adjacentGround

                    superBreps[i].MergeExternalEnvelope();//envelopSetting合并//设置Ground Slab Setting \ Roof Setting
                    //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"program and schedule setting applied to {superBreps[i].Ceiling[0].Material.MaterialType}"));
                    //for()

                }
            }
            else if (programs.Count == superBreps.Count)
            {
                for (int i = 0; i < superBreps.Count; i++)
                {
                    bool isZoneClosed = superBreps[i].IsZoneClosed(out Brep closedBrep);
                    if (!isZoneClosed)
                    {
                        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, $"Zone({superBreps[i].Name}) is not closed!");
                        return;
                    }

                    double zoneVolume = closedBrep.GetVolume();
                    double area = superBreps[i].GetZoneArea();
                    superBreps[i].Area = area;
                    superBreps[i].Height = zoneVolume / superBreps[i].Area;
                    superBreps[i].MaterialSetting = materialSetting;
                    superBreps[i].Occupancy = programs[i].Occupancy;
                    superBreps[i].MetabolicRate = programs[i].MetabolicRate;
                    superBreps[i].Appliance = programs[i].Appliance;
                    superBreps[i].LightingTemplate = programs[i].LightingTemplate;
                    superBreps[i].OutdoorAir = programs[i].OutdoorAir;
                    superBreps[i].AirInfiltrationRate = programs[i].AirInfiltrationRate;
                    superBreps[i].AirInfiltrationLevel = programs[i].AirInfiltrationLevel;
                    superBreps[i].VentilationType = programs[i].VentilationType;
                    superBreps[i].NightFlushing = programs[i].NightFlushing;
                    superBreps[i].WindowAreaOpenPercentage = programs[i].WindowAreaOpenPercentage;
                    superBreps[i].AngleOfOpening = programs[i].AngleOfOpening;
                    superBreps[i].DHW = programs[i].DHW;
                    superBreps[i].HvacTemplate = programs[i].HvacTemplate;
                    superBreps[i].AirInfiltrationSchedule = schedules[i].AirInfiltrationSchedule;
                    superBreps[i].IndoorTemperatureSetPointSchedule = schedules[i].IndoorTemperatureSetPointSchedule;
                    superBreps[i].BuildingUseSchedule = schedules[i].BuildingUseSchedule;
                    //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"program and schedule setting applied to {superBreps[i].Name}"));

                    List<SuperSurface> flat = new List<SuperSurface> { };
                    flat.AddRange(superBreps[i].Ceiling);
                    flat.AddRange(superBreps[i].Floor);
                    foreach (var surface in superBreps[i].Wall)
                    {
                        if (surface.Material.MaterialType == MaterialType.InternalWall)
                        {
                            superBreps[i].InteriorWallMaterial = surface.Material;
                            break;
                        }
                    }
                    foreach (var surface in flat)
                    {
                        if (surface.Material.MaterialType == MaterialType.InternalFloor)
                        {
                            superBreps[i].InteriorFloorMaterial = surface.Material;
                            break;
                        }
                    }//设置interiorFloorMaterial和interiorWallMaterial

                    foreach (var surface in superBreps[i].Floor)//
                    {
                        if (surface.Material.MaterialType == MaterialType.Ground)
                        {
                            superBreps[i].AdjacentGroundList.Add(new AdjacentBrepAreaPare() { SuperBrep = null, ContactArea = surface.Area });
                            break;
                        }
                    }//设置adjacentGround

                    superBreps[i].MergeExternalEnvelope();//envelopSetting合并//设置Ground Slab Setting \ Roof Setting
                    //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"program and schedule setting applied to {superBreps[i].Ceiling[0].Material.MaterialType}"));
                    //for()

                }
            }            
            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, "其他SuperBrep属性设置" );  


            DA.SetDataList(0, superBreps);
            
            List<string> textList = superBreps.Select(x => ToCen(x)).ToList();
            DA.SetDataList(1, textList);
            //DA.SetDataList(2, results);
        }
        private void ProcessIntersectionBrep(Brep brep, SuperSurface ceiling, SuperSurface floor, int i, int j, int k, int g, MaterialSetting materialSetting, ref List<SuperSurface> iSurface, ref List<SuperSurface> jSurface)
        {
            Vector3d normal = brep.Faces[0].NormalAt(0.1, 0.1);
            Brep[] jBreps;
            Brep[] iBreps;

            // 检查法线方向是否需要翻转
            if (normal.IsParallelTo(floor.Surface.NormalAt(0.1, 0.1)) == -1)
            {
                iBreps = Brep.CreateBooleanDifference(ceiling.GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                SuperSurface interA = new SuperSurface(new GH_Surface(brep))
                {
                    Material = materialSetting.InternalFloorMaterial,
                    Name = floor.Name
                };
                ceiling = interA;

                brep.Flip();
                jBreps = Brep.CreateBooleanDifference(floor.GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                SuperSurface interB = new SuperSurface(new GH_Surface(brep))
                {
                    Material = materialSetting.InternalFloorMaterial,
                    Name = floor.Name
                };
                floor = interB;
            }
            else
            {
                jBreps = Brep.CreateBooleanDifference(floor.GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                SuperSurface interB = new SuperSurface(new GH_Surface(brep))
                {
                    Material = materialSetting.InternalFloorMaterial,
                    Name = floor.Name
                };
                floor = interB;

                brep.Flip();
                SuperSurface interA = new SuperSurface(new GH_Surface(brep))
                {
                    Material = materialSetting.InternalFloorMaterial,
                    Name = floor.Name
                };
                ceiling = interA;
                iBreps = Brep.CreateBooleanDifference(ceiling.GH_Surface.Value, brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
            }

            // 处理裁剪后的剩余部分
            if (jBreps != null && jBreps.Length > 0)
            {
                foreach (Brep remaining in jBreps.Where(b => b.GetArea() > 0.1))
                {
                    jSurface.Add(new SuperSurface(new GH_Surface(remaining)) { Material = materialSetting.ExternalFloorMaterial });
                }
            }
            if (iBreps != null && iBreps.Length > 0)
            {
                foreach (Brep remaining in iBreps.Where(b => b.GetArea() > 0.1))
                {
                    iSurface.Add(new SuperSurface(new GH_Surface(remaining)) { Material = materialSetting.RoofMaterial });
                }
            }
        }
        public string ToCen(SuperBrep brep)
        {
            
                var result = $"Zone Name: {brep.Name}\t!!! specify the zone name" + Br;
                result +=
                    $"Length: {brep.LengthStr} \t!!! unit: m" + Br;
                result +=
                    $"Width: {brep.WidthStr} \t!!! unit: m" + Br;
                result +=
                    $"Area: {brep.AreaStr}\t!!! unit: m2" + Br;
                result +=
                    $"Height: {brep.HeightStr}\t!!! unit: m" + Br;
                result += $"Occupancy: {brep.OccupancyStr}\t!!! unit: m2/person " + Br;
                result +=
                    $"Metabolic Rate: {brep.MetabolicRateStr}\t!!! unit: W/person" + Br;
                result +=
                    $"Appliance: {brep.ApplianceStr}\t\t!!! W/m2" + Br;
                result +=
                    $"Lighting Template: {brep.LightingTemplateStr} \t!!!specify a predefined lighting system" + Br;
                result +=
                    $"Outdoor Air: {brep.OutdoorAirStr}\t!!! unit: liter/s/person. If ignored, then mininum outdoor air default will be used" + Br;
                result +=
                    $"Air Infiltration Level: {brep.AirInfiltrationLevelStr} \t!!! 1. low, 2. medium, 3. High" + Br;
                result +=
                    $"Air Infiltration Rate: {brep.AirInfiltrationRateStr} \t!!! leave blank if air infiltration level is used, unit: /h air change rate at Q4Pa" + Br;
                result +=
                    $"Air Infiltration Schedule: {brep.AirInfiltrationScheduleStr} \t!!! specify a predefined monthly air infiltration schedule" + Br;
                result +=
                    $"Ventilation Type: {brep.VentilationTypeStr} \t!!! 1. Mechanical vent only, 2. Mechanical vent shared w/ Natural, 3. Natural vent only. Note: zones that don't have external structures can't apply natural ventilation" + Br;

                result += $"Night Flushing: {brep.NightFlushingStr} \t!!! 1. Yes, 2. No" + Br;
                result +=
                    $"Window Area Open Percentage: {brep.WindowAreaOpenPercentageStr} \t!!! if natural ventilation is used, specify the opened area percentage of total window area, unit: %" +
                    Br;
                result +=
                    $"Angle of Opening: {brep.AngleOfOpeningStr} \t!!! if natural ventilation is used, specify the angle of opening for bottom hung windows, unit: degree" + Br;
                result +=
                    $"DHW: {brep.DHWStr} \t\t!!! unit: liter/m2/month" + Br;
                result +=
                    $"Indoor Temperature Setpoint Schedule: {brep.IndoorTemperatureSetPointScheduleStr} \t!!!specify a predefined indoor temperature setpoint schedule" + Br;
                result +=
                    $"Building Use Schedule: {brep.BuildingUseScheduleStr} \t!!!specify a predefined building use schedule" + Br;
                result +=
                    $"HVAC Template: {brep.HvacTemplateStr} \t!!!specify a predefined HVAC system" + Br;
                result +=
                    $"Multiplier: {brep.MultiplierStr}\t!!! If ignored, floor number will be used as multiplier of this zone" + Br;
                result +=
                    $"Interior Floor Material: {brep.InteriorFloorMaterialStr} \t!!!specify the material of interior floor, for the 1st floor, leave it '-'" + Br;
                result +=
                    $"Interior Wall Material: {brep.InteriorWallMaterialStr} \t!!!specify the material of interior wall, which is defined in wall materials" +
                    Br;
                result += $"South Facing External Facade Setting: {brep.SExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
                result +=
                    $"East Facing External Facade Setting: {brep.EExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
                result +=
                    $"North Facing External Facade Setting: {brep.NExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
                result +=
                    $"West Facing External Facade Setting: {brep.WExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
                result += $"Southeast Facing External Facade Setting: {brep.SeExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
                result +=
                    $"Northeast Facing External Facade Setting: {brep.NeExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
                result +=
                    $"Northwest Facing External Facade Setting: {brep.NwExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
                result +=
                    $"Southwest Facing External Facade Setting: {brep.SwExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
                result +=
                    $"Roof Setting: {brep.RoofSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
                result += $"Ground Slab Setting: {brep.GroundSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
                result += "Adjacent Wall Zone Name and Contact Area: ";
            
            if (brep.AdjacentWallList.Count == 0)
            {
                result += "-";
            }
            else
            {
                for (int i = 0; i < brep.AdjacentWallList.Count; i++)
                {
                    var adjacentWall = brep.AdjacentWallList[i];
                    result += $"{adjacentWall.SuperBrep.Name}, {Converter.DoubleToString(adjacentWall.ContactArea)}";
                    if (i != brep.AdjacentWallList.Count - 1)
                    {
                        result += "; ";
                    }
                }
            }
            result += " \t!!!specify the name of neigboring zone and contact area" + Br;

            // Adjacent Ceiling Zone
            result += "Adjacent Ceiling Zone Name and Contact Area: ";
            if (brep.AdjacentCeilingList.Count == 0)
            {
                result += "-";
            }
            else
            {
                for (int i = 0; i < brep.AdjacentCeilingList.Count; i++)
                {
                    var adjacent = brep.AdjacentCeilingList[i];
                    result += $"{adjacent.SuperBrep.Name}, {Converter.DoubleToString(adjacent.ContactArea)}";
                    if (i != brep.AdjacentCeilingList.Count - 1)
                    {
                        result += "; ";
                    }
                }
            }
            result += "\t!!!specify the name of neigboring zone and contact area" + Br;

            // Adjacent Floor Zone
            result += "Adjacent Floor Zone Name and Contact Area: ";
            if (brep.AdjacentGroundList.Count == 0 && brep.AdjacentFloorList.Count == 0)
            {
                result += "-";
            }
            else
            {
                for (int i = 0; i < brep.AdjacentGroundList.Count; i++)
                {
                    var adjacent = brep.AdjacentGroundList[i];
                    result += $"ground, {Converter.DoubleToString(adjacent.ContactArea)}";
                }
                for (int i = 0; i < brep.AdjacentFloorList.Count; i++)
                {
                    var adjacent = brep.AdjacentFloorList[i];
                    result += $"{adjacent.SuperBrep.Name}, {Converter.DoubleToString(adjacent.ContactArea)}";
                    if (i != brep.AdjacentFloorList.Count - 1)
                    {
                        result += "; ";
                    }
                }
            }
            result += " \t!!!specify the name of neigboring zone and contact area" + Br;
            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"ground amount{brep.AdjacentGroundList.Count}");
            return result;
        }

        int c = 0;
        //a=superBreps[i].Floor//b=superBreps[j].Ceiling \\state=0,floor to ceiling; state=1,ceiling to floor; state=2,wall to wall;
        public void Assign(SuperBrep aBrep,SuperBrep bBrep,List<SuperSurface> a, List<SuperSurface> b, Modules.Material interMaterial, Modules.Material exterMaterialA, Modules.Material exterMaterialB,int adjacent = 0)
        {       
           // AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, ($"运算开始{c}"));
            for (int k = 0; k < a.Count; k++)
            {
                for (int g = 0; g < b.Count; g++)
                {                    
                    if (IsSurfaceAdjacent(a[k], b[g], out int state))//找到了相邻的面
                    {
                        List<SuperSurface> iSurface = new List<SuperSurface> { };
                        List<SuperSurface> jSurface = new List<SuperSurface> { };
                        //AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, ($"Surface  {k} and {g} are 相邻.{c}"));
                        c++;
                        if (state == 0)
                        {
                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ("完全重合"));
                            a[k].Material = interMaterial;
                            b[g].Material = interMaterial;
                            a[k].Name = b[g].Name;
                            if ((adjacent == 0))// floor to ceiling
                            {
                                aBrep.AdjacentFloorList.Add(new AdjacentBrepAreaPare() { SuperBrep = bBrep, ContactArea = b[g].Area });
                                bBrep.AdjacentCeilingList.Add(new AdjacentBrepAreaPare() { SuperBrep = aBrep, ContactArea = a[k].Area });
                            }
                            else if ((adjacent == 1))//ceiling to floor
                            {
                                aBrep.AdjacentCeilingList.Add(new AdjacentBrepAreaPare() { SuperBrep = bBrep, ContactArea = b[g].Area });
                                bBrep.AdjacentFloorList.Add(new AdjacentBrepAreaPare() { SuperBrep = aBrep, ContactArea = a[k].Area });
                            }
                            else if (adjacent == 2)//wall to wall
                            {
                                aBrep.AdjacentWallList.Add(new AdjacentBrepAreaPare() { SuperBrep = bBrep, ContactArea = b[g].Area });
                                bBrep.AdjacentWallList.Add(new AdjacentBrepAreaPare() { SuperBrep = aBrep, ContactArea = a[k].Area });
                            }
                            else
                            {
                               // AddRuntimeMessage(GH_RuntimeMessageLevel.Error, ("adjacent can only == 0、1、2"));
                                return;
                            }

                           // AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, ($"重合运算结束{g}"));
                        }
                        else
                        {
                            _ = Intersection.BrepBrep(a[k].GH_Surface.Value, b[g].GH_Surface.Value, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance, out Curve[] intersectionCurves, out _);
                            if (intersectionCurves == null || intersectionCurves.Count() < 1)
                            {
                                break;
                            }
                            Curve[] joinedCurves = Curve.JoinCurves(intersectionCurves, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                            Curve intersectionCurve = joinedCurves[0]; // 取第一个交集曲线
                            if (intersectionCurve.IsClosed==false)
                            {
                                break;
                            }
                            
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
                           // AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"裁剪完成{g}{c}");
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
                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"交错判断结束{g}{c}");
                            if ((adjacent == 0))//ceiling to floor
                            {
                                aBrep.AdjacentFloorList.Add(new AdjacentBrepAreaPare() { SuperBrep = bBrep, ContactArea = b[g].Area });
                                bBrep.AdjacentCeilingList.Add(new AdjacentBrepAreaPare() { SuperBrep = aBrep, ContactArea = a[k].Area });

                            }
                            else if ((adjacent == 1))//ceiling to floor
                            {
                                aBrep.AdjacentCeilingList.Add(new AdjacentBrepAreaPare() { SuperBrep = bBrep, ContactArea = b[g].Area });
                                bBrep.AdjacentFloorList.Add(new AdjacentBrepAreaPare() { SuperBrep = aBrep, ContactArea = a[k].Area });
                            }
                            else if (adjacent == 2)//wall to wall
                            {
                                aBrep.AdjacentWallList.Add(new AdjacentBrepAreaPare() { SuperBrep = bBrep, ContactArea = b[g].Area });
                                bBrep.AdjacentWallList.Add(new AdjacentBrepAreaPare() { SuperBrep = aBrep, ContactArea = a[k].Area });
                            }
                            else
                            {
                                //AddRuntimeMessage(GH_RuntimeMessageLevel.Error, ("adjacent can only == 0、1、2"));
                                return;
                            }
                            a.AddRange(iSurface);
                            b.AddRange(jSurface);
                            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, $"相邻信息存储结束{g}{c}");
                        }  
                    }                                     
                }
            }            
        }
    }
}










