using System;
using System.Collections.Generic;
using System.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Geometry;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules;
using RCBldGH.Components.Envelope;
using System.Security.Policy;
using Rhino.Geometry.Intersect;
using Rhino.Commands;
using Rhino;
using Grasshopper.Kernel.Geometry.Delaunay;

namespace RCBldGH.Components.other.studyAndTest
{
    public class Shadow_new : GH_Component
    {
        /// <summary>
        /// Initializes a new instance of the MyComponent1 class.
        /// </summary>
        public Shadow_new()
          : base("shadow_new", "Nickname","Description","RCBldGH", "Subcategory")
        {
        }
        /// <summary>
        /// Provides an Icon for the component.
        /// </summary>
        protected override System.Drawing.Bitmap Icon
        {
            get
            {
                //You can add image files to your project resources and access them like this:
                // return Resources.IconForThisComponent;
                return null;
            }
        }

        /// <summary>
        /// Gets the unique ID for this component. Do not change this ID after release.
        /// </summary>
        public override Guid ComponentGuid
        {
            get { return new Guid("a31253d9-0a62-416a-9fb2-52b251493baf"); }
        }
        /// <summary>
        /// Registers all the input parameters for this component.
        /// </summary>
        protected override void RegisterInputParams(GH_Component.GH_InputParamManager pManager)
        {
            // surfaceParam = new EnvelopSurfaceParam();
            pManager.AddSurfaceParameter("targetSurface", "S", "Surfaces that can form a closed zone.", GH_ParamAccess.item);
            //EnvelopSurfaceParam surfaceParam = new EnvelopSurfaceParam();
            pManager.AddBrepParameter("occludingSurface", "S", "Surfaces that can form a closed zone.", GH_ParamAccess.item);
            pManager.AddVectorParameter("Vectors", "S", "Surfaces that can form a closed zone.", GH_ParamAccess.item);
           // pManager.AddNumberParameter("beams", "S", "Surfaces that can form a closed zone.", GH_ParamAccess.item);
        }
        /// <summary>
        /// Registers all the output parameters for this component.
        /// </summary>
        protected override void RegisterOutputParams(GH_Component.GH_OutputParamManager pManager)
        {
            pManager.AddNumberParameter("shadowbeam", "occupants", "occupants", GH_ParamAccess.item);
            //pManager.AddNumberParameter("sf", "occupants", "occupants", GH_ParamAccess.item);
            //pManager.AddCurveParameter("azim", "occupants", "occupants", GH_ParamAccess.list);
            pManager.AddSurfaceParameter("GH_Surface", "occupants", "occupants", GH_ParamAccess.item);
            pManager.AddCurveParameter("GH_Surface", "occupants", "occupants", GH_ParamAccess.list);
            //pManager.AddPlaneParameter("Plane", "occupants", "occupants", GH_ParamAccess.item);
        }

        /// <summary>
        /// This is the method that actually does the work.
        /// </summary>
        /// <param name="DA">The DA object is used to retrieve from inputs and store in outputs.</param>
        /// 

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            GH_Surface targetSurface = null;
            //GH_Surface occludingSurface = null;
            GH_Surface occludingSurface = new GH_Surface { };
            Vector3d sunVector = new Vector3d { };
            //double beam = 0;

            DA.GetData(0, ref targetSurface);
            DA.GetData(1, ref occludingSurface);
            DA.GetData(2, ref sunVector);
            //DA.GetData(3, ref beam);
            
            //double sF = CalculateShadowFactor(targetSurface, occludingSurface, sunVector, out Curve[] curves,out Surface surface,out Rhino.Geometry.Plane plane);
            
            double sF = 0;
            //try
            //{
            //result = Calculate(occludingSurface, sunVector, targetSurface, beams);
            //double[] result = new double[8760];   
            GH_Surface shadowface = null;
            //Surface surface = null;
            Curve[] targetBrep = null;
            sF += CalculateSF(targetSurface, occludingSurface, sunVector,out shadowface,out targetBrep);
            
                
            
            //return result;
            //}

            //catch
            //{
            //    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "输入参数有误");
            //    return;
            //}
            DA.SetData(0, sF);
            DA.SetData(1, shadowface);
            DA.SetDataList(2, targetBrep);
            //DA.SetDataList(1, curves);
            //DA.SetData(2, new GH_Surface(surface));
            //DA.SetData(3, new GH_Plane(plane));

        }
        public bool IsPointInsideSurface(Surface surface, Point3d point)
        {
            surface.ClosestPoint(point, out double u, out double v);
            Point3d closestPoint = surface.PointAt(u, v);
            return closestPoint.DistanceTo(point) < 0.001;
        }

        /// <summary>
        /// 计算遮挡后的Beam
        /// </summary>
        /// <param name="normal"></param>
        /// <param name="azimuths"></param>
        /// <param name="Solardata"></param>
        /// <param name="candidateBrep"></param>
        /// <param name="sunVector"></param>
        /// <param name="surface"></param>
        /// <param name="beams"></param>
        /// <param name="candidateSurface"></param>
        /// <returns></returns>
        public double[] Calculate(List<Brep> candidateBrep, List<Vector3d> sunVector, GH_Surface surface, double[] beams)
        {
            double[] result = new double[8760];
            for (int h = 0; h < 8760; h++)
            {
                if (beams[h] > 0)
                {
                    var allOcluding = new List<GH_Surface> { };
                    foreach (Brep brep in candidateBrep)
                    {
                        var surfaces = SurfaceFromBrep(brep, sunVector[h]);
                        allOcluding.AddRange(surfaces);
                    }
                    //allOcluding.AddRange(candidateSurface);
                    double sF = 1;
                    for (int i = 0; i < allOcluding.Count; i++)
                    {
                        sF -= CalculateSF(surface, allOcluding[i], sunVector[h]);
                        //curveTree.Add(shadowFactor[0], path);
                    }
                    result[h] = beams[h] * sF;
                }
                else { result[h] = 0; }
            }
            return result;
        }

        /// <summary>
        /// 向量计算azimuth
        /// </summary>
        /// <param name="normal"></param>
        /// <returns></returns>
        public double AzimuthCalculate(Vector3d normal)
        {
            double gama = 0;
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
            return gama;
        }

        /// <summary>
        /// 计算遮挡系数
        /// </summary>
        /// <param name="targetSurface"></param>
        /// <param name="occludingSurface"></param>
        /// <param name="sunVector"></param>
        /// <param name="curves"></param>
        /// <param name="shadow"></param>
        /// <param name="plane"></param>
        /// <returns></returns>
        public double CalculateSF(GH_Surface targetSurface, GH_Surface occludingSurface, Vector3d sunVector, out GH_Surface shadowface,out Curve[] polyCurves)
        {
            BoundingBox targetBoundingBox = targetSurface.Value.GetBoundingBox(true);
            Point3d targetMidPoint = targetBoundingBox.Center;

            //BoundingBox occludingBoundingBox = occludingSurface.GetBoundingBox(true);

            // 计算目标面所在平面
            Vector3d targetNormal = targetSurface.Face.NormalAt(targetBoundingBox.Center.X, targetBoundingBox.Center.Y);
            Rhino.Geometry.Plane targetPlane = new Rhino.Geometry.Plane(targetBoundingBox.Center, targetNormal);
            //Surface transformedSurface = (Surface)occludingSurface.Duplicate();
            BrepFace occludingFace = occludingSurface.Face;
            GH_Surface occluding= new GH_Surface(occludingFace.DuplicateFace(false));                       
            occluding.Transform(Transform.ProjectAlong(targetPlane, sunVector));
            
            shadowface = occluding;  
                    
            Brep brep = targetSurface.Value;
            // brepUnion = Brep.CreateBooleanIntersection(shadowface.Value,brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
            


            bool isIntersect = Intersection.BrepBrep(brep, shadowface.Value, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance, out Curve[] intersectionCurves, out _);
            bool isPointInside = IsPointInsideSurface(shadowface.Value.Faces[0], targetMidPoint);//target是否在shadow内
            polyCurves = null;
            if (!isIntersect && isPointInside)
            {
                return 1; // 如果没有交点，点在目标面内部，遮挡系数为1
                
            }
            if (!isIntersect && !isPointInside)
            {
                return 0;                
            }
            else
            {                
                polyCurves = intersectionCurves;
                double overlapArea = 0;
                foreach (Curve sectionCurve in polyCurves)
                {
                    if (sectionCurve != null && sectionCurve.IsClosed)//筛选，仅仅保留闭合曲线的截面线
                    {
                        overlapArea += AreaMassProperties.Compute(sectionCurve).Area;//计算截面面积
                    }
                }
                double targetArea = AreaMassProperties.Compute(targetSurface.Face).Area;
                double shadowFactor = overlapArea / targetArea;
                return shadowFactor;
            }
        }
        

        public double CalculateSF(GH_Surface targetSurface, GH_Surface occludingSurface, Vector3d sunVector)
        {
            BoundingBox targetBoundingBox = targetSurface.Value.GetBoundingBox(true);
            Point3d targetMidPoint = targetBoundingBox.Center;

            //BoundingBox occludingBoundingBox = occludingSurface.GetBoundingBox(true);

            // 计算目标面所在平面
            Vector3d targetNormal = targetSurface.Face.NormalAt(targetBoundingBox.Center.X, targetBoundingBox.Center.Y);
            Rhino.Geometry.Plane targetPlane = new Rhino.Geometry.Plane(targetBoundingBox.Center, targetNormal);
            //Surface transformedSurface = (Surface)occludingSurface.Duplicate();
            BrepFace occludingFace = occludingSurface.Face;
            GH_Surface occluding = new GH_Surface(occludingFace.DuplicateFace(false));
            occluding.Transform(Transform.ProjectAlong(targetPlane, sunVector));

            GH_Surface shadowface = occluding;

            Brep brep = targetSurface.Value;
            // brepUnion = Brep.CreateBooleanIntersection(shadowface.Value,brep, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);



            bool isIntersect = Intersection.BrepBrep(brep, shadowface.Value, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance, out Curve[] intersectionCurves, out _);
            bool isPointInside = IsPointInsideSurface(shadowface.Value.Faces[0], targetMidPoint);//target是否在shadow内
            if (!isIntersect && isPointInside)
            {
                return 1; // 如果没有交点，点在目标面内部，遮挡系数为1

            }
            if (!isIntersect && !isPointInside)
            {
                return 0;
            }
            else
            {
                Curve[] polyCurves = intersectionCurves;
                Curve[] joinedCurves = Curve.JoinCurves(polyCurves);
                double overlapArea = 0;
                foreach (Curve sectionCurve in joinedCurves)
                {
                    if (sectionCurve != null && sectionCurve.IsClosed)//筛选，仅仅保留闭合曲线的截面线
                    {
                        overlapArea += AreaMassProperties.Compute(sectionCurve).Area;//计算截面面积
                    }
                }
                double targetArea = AreaMassProperties.Compute(targetSurface.Face).Area;
                double shadowFactor = overlapArea / targetArea;
                return shadowFactor;
            }
        }
        // 计算遮挡系数



        //Curve[] polyCurves = Curve.JoinCurves(intersectionCurves, 0.001);
        //if (!isIntersect && isPointInside)
        //{
        //    return 1; // 如果没有交点，点在目标面内部，遮挡系数为1
        //}
        //if (!isIntersect && !isPointInside)
        //{
        //    return 0;
        //}
        //else
        //{
        //    double overlapArea = AreaMassProperties.Compute(polyCurves).Area;
        //    double targetArea = AreaMassProperties.Compute(targetSurface.ToNurbsSurface()).Area;

        //    // 计算遮挡系数
        //    double shadowFactor = overlapArea / targetArea;
        //    // 计算遮挡系数
        //    //double shadowFactor = overlapArea / targetArea;
        //    return shadowFactor;

        //    //// 计算目标面的面积
        //}

        /// <summary>
        /// 根据方位角，获取candidateBrep中 的 candidateSurface
        /// </summary>
        /// <param name="brep"></param>
        /// <param name="azimuth"></param>
        /// <returns></returns>
        public static List<GH_Surface> SurfaceFromBrep(Brep brep, Vector3d sunVector)
        {
            var preResult = brep.Faces.Where(i => i.NormalAt(0.1, 0.1).Z == 0).Select(i => new GH_Surface(i.UnderlyingSurface())).ToList();
            var result = preResult.Where(i => i.Face.NormalAt(0.1, 0.1) * sunVector > 0).ToList();
            return result;
        }

        //public List<Surface> OccSurfaceScreen(List<Brep> breps, Brep build,double lat)
        //{
        //    List<Surface> result = new List<Surface>();
            
        //    ///根据纬度筛选candidateOccSurface
        //    if (lat > 23.26)//北半球只考虑冬至日
        //    {
        //        for (int i = 8525; i < 14; i++)
        //        {
        //            if (zeniths[i] > 1.57)//1.57 ≈ Pi/2
        //            { continue; }

        //            foreach (Brep brep in candidateBrep)
        //            {
        //                //brep.Vertices[0].X
        //                //if (brep.GetBoundingBox(true).Center.Y < center.Y &&)
        //                { }
        //            }

        //        }

        //    }//只计算冬至日//计算背阴面
        //    if (lat < -23.26)
        //    { }//只计算夏至日
        //    else
        //    { }//都要计算 

        //    foreach (Brep brep in breps)
        //    {
                

        //    }
        //    return result;



        //}
    }
}
//public double CalculateShadowFactor(GH_Surface targetSurface, GH_Surface occludingSurface, Vector3d sunVector, out Curve[] curves, out Surface shadow, out Rhino.Geometry.Plane plane)
//{
//    // 获取目标面和遮挡面的边界框
//    BoundingBox targetBoundingBox = targetSurface.Value.GetBoundingBox(true);
//    //BoundingBox occludingBoundingBox = occludingSurface.GetBoundingBox(true);

//    // 计算目标面所在平面
//    Vector3d targetNormal = targetSurface.Face.NormalAt(targetBoundingBox.Center.X, targetBoundingBox.Center.Y);
//    Rhino.Geometry.Plane targetPlane = new Rhino.Geometry.Plane(targetBoundingBox.Center, targetNormal);
//    //Surface transformedSurface = (Surface)occludingSurface.Duplicate();
//    GH_Surface occluding = occludingSurface.DuplicateSurface();
//    occluding.Transform(Transform.ProjectAlong(targetPlane, sunVector));
//    Surface shadowface = occluding.Face.ToNurbsSurface();


//    GH_Surface gH_Surface = new GH_Surface(targetSurface);
//    Brep brep = gH_Surface.Value;

//    Intersection.BrepSurface(brep, shadowface, 0.1, out Curve[] intersectionCurves, out Point3d[] intersectionPoints);
//    Curve[] polyCurves = Curve.JoinCurves(intersectionCurves, 0.001);
//    curves = polyCurves;
//    shadow = shadowface;
//    plane = targetPlane;
//    double overlapArea = AreaMassProperties.Compute(polyCurves).Area;
//    double targetArea = AreaMassProperties.Compute(targetSurface.Face).Area;

//    // 计算遮挡系数
//    double shadowFactor = overlapArea / targetArea;
//    return shadowFactor;

//}