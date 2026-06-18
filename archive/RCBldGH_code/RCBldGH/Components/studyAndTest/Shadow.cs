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
using Grasshopper.Kernel.Data;
///该电池可以被淘汰
namespace RCBldGH.Components.other.studyAndTest
{
    public class Shadow : GH_Component
    {
        /// <summary>
        /// Initializes a new instance of the MyComponent1 class.
        /// </summary>
        public Shadow()
          : base("MyComponent1", "Nickname", "Description", "RCBldGH", "Subcategory")
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
            get { return new Guid("4F2C86AD-0995-44DD-95D2-BFEFCAC894DD"); }
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
            pManager.AddSurfaceParameter("Surface", "occupants", "occupants", GH_ParamAccess.item);
            //pManager.AddPlaneParameter("Plane", "occupants", "occupants", GH_ParamAccess.item);
            pManager.AddCurveParameter("GH_Surface", "occupants", "occupants", GH_ParamAccess.list);
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
            //double result = 0;
            double sF = 0;
            //try
            //{
            //result = Calculate(occludingSurface, sunVector, targetSurface, beams);
            //double[] result = new double[8760];   
            Surface shadowface = null;
            sF += CalculateSF(targetSurface, occludingSurface, sunVector, out shadowface,out Curve[] interCurve);



            //return result;
            //}

            //catch
            //{
            //    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "输入参数有误");
            //    return;
            //}
            DA.SetData(0, sF);
            DA.SetData(1, shadowface);
            DA.SetDataList(2, interCurve);
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
        public double CalculateSF(GH_Surface targetSurface, GH_Surface occludingSurface, Vector3d sunVector, out Surface shadowface,out Curve[] intersectionCurves)
        {
            BoundingBox targetBoundingBox = targetSurface.Value.GetBoundingBox(true);
            Point3d targetMidPoint = targetBoundingBox.Center;

            //BoundingBox occludingBoundingBox = occludingSurface.GetBoundingBox(true);

            // 计算目标面所在平面
            Vector3d targetNormal = targetSurface.Face.NormalAt(targetBoundingBox.Center.X, targetBoundingBox.Center.Y);
            Rhino.Geometry.Plane targetPlane = new Rhino.Geometry.Plane(targetBoundingBox.Center, targetNormal);
            //Surface transformedSurface = (Surface)occludingSurface.Duplicate();
            GH_Surface occluding = occludingSurface.DuplicateSurface();
            occluding.Transform(Transform.ProjectAlong(targetPlane, sunVector));
            shadowface = occluding.Face.ToNurbsSurface();

            GH_Surface gH_Surface = new GH_Surface(targetSurface);
            Brep brep = gH_Surface.Value;


            bool isIntersect = Intersection.BrepSurface(brep, shadowface, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance, out intersectionCurves, out Point3d[] intersectionPoints);
            bool isPointInside = IsPointInsideSurface(shadowface, targetMidPoint);//target是否在shadow内

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
                //Curve[] polyCurves = Curve.JoinCurves(intersectionCurves, 0.001);
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
        // 计算遮挡系数
        public double CalculateSF(GH_Surface targetSurface, GH_Surface occludingSurface, Vector3d sunVector)
        {
            BoundingBox targetBoundingBox = targetSurface.Value.GetBoundingBox(true);
            Point3d targetMidPoint = targetBoundingBox.Center;

            //BoundingBox occludingBoundingBox = occludingSurface.GetBoundingBox(true);

            // 计算目标面所在平面
            Vector3d targetNormal = targetSurface.Face.NormalAt(targetBoundingBox.Center.X, targetBoundingBox.Center.Y);
            Rhino.Geometry.Plane targetPlane = new Rhino.Geometry.Plane(targetBoundingBox.Center, targetNormal);
            //Surface transformedSurface = (Surface)occludingSurface.Duplicate();
            GH_Surface occluding = occludingSurface.DuplicateSurface();
            occluding.Transform(Transform.ProjectAlong(targetPlane, sunVector));
            Surface shadowface = occluding.Face.ToNurbsSurface();

            GH_Surface gH_Surface = new GH_Surface(targetSurface);
            Brep brep = gH_Surface.Value;


            bool isIntersect = Intersection.BrepSurface(brep, shadowface, 0.1, out Curve[] intersectionCurves, out Point3d[] intersectionPoints);
            bool isPointInside = IsPointInsideSurface(shadowface, targetMidPoint);//target是否在shadow内

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
                Curve[] polyCurves = Curve.JoinCurves(intersectionCurves, 0.001);
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

     
        public double CalculateShadowFactor(Surface targetSurface, GH_Surface occludingSurface, double azimuth, Vector3d sunVector)
        {
            // 获取目标面和遮挡面的边界框
            BoundingBox targetBoundingBox = targetSurface.GetBoundingBox(true);
            BoundingBox occludingBoundingBox = occludingSurface.Face.GetBoundingBox(true);

            // 计算从目标面最左侧点到遮挡面最右侧点的向量
            Vector3d leftToRightVector = occludingBoundingBox.Corner(true, false, false) - targetBoundingBox.Corner(false, true, false);
            Vector3d rightToLeftVector = occludingBoundingBox.Corner(true, true, false) - targetBoundingBox.Corner(false, false, false);

            // 检查太阳向量的方位角是否位于这两个向量之间，如果是，则存在遮挡
            if (azimuth > Vector3d.VectorAngle(leftToRightVector, Vector3d.YAxis, Rhino.Geometry.Plane.WorldXY) - Math.PI &&
                azimuth < Vector3d.VectorAngle(rightToLeftVector, Vector3d.YAxis, Rhino.Geometry.Plane.WorldXY) - Math.PI)
            {
                // 计算目标面所在平面
                Vector3d targetNormal = targetSurface.NormalAt(targetBoundingBox.Center.X, targetBoundingBox.Center.Y);
                Rhino.Geometry.Plane targetPlane = new Rhino.Geometry.Plane(targetBoundingBox.Center, targetNormal);

                // 将遮挡面投影到目标面平面
                GH_Surface occluding = occludingSurface.DuplicateSurface();
                occluding.Transform(Transform.ProjectAlong(targetPlane, sunVector));

                // 计算阴影面与目标面的交点
                Point3d targetMidPoint = targetBoundingBox.Center;

                bool isIntersect = Rhino.Geometry.Intersect.Intersection.BrepSurface(occluding.Value, targetSurface.ToNurbsSurface(), 0.01, out Curve[] intersectionCurves, out Point3d[] intersectionPoints);
                bool isPointInside = occluding.Value.IsPointInside(targetMidPoint, 0.01, false);
                Curve[] polyCurves = Curve.JoinCurves(intersectionCurves, 0.001);
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
                    double overlapArea = AreaMassProperties.Compute(polyCurves).Area;
                    double targetArea = AreaMassProperties.Compute(targetSurface.ToNurbsSurface()).Area;

                    // 计算遮挡系数
                    double shadowFactor = overlapArea / targetArea;
                    // 计算遮挡系数
                    //double shadowFactor = overlapArea / targetArea;
                    return shadowFactor;

                    //// 计算目标面的面积
                }

            }
            else
            {
                return 0;
            }
        }
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
