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
using System.Threading.Tasks;
using Rhino.Geometry.Collections;
using System.Xml.Linq;
using Rhino.Collections;
using Rhino.Commands;
using Rhino;
using System.Numerics;
using System.Collections.Concurrent;
using Rhino.Geometry.Intersect;
using System.Security.Cryptography.X509Certificates;
using System.Security.Cryptography;
//double winterZenith = zeniths[8532];//冬至日
//double summerZenith = zeniths[4140];//夏至日
namespace RCBldGH.Components.Reader
{
    public class SolarCalculateDiffuse : GH_Component
    {
        public SolarCalculateDiffuse() : base("Shadow1.1", "SolarData", "SolarData", "RCBldGH", "Subcategory") { }

        public override Guid ComponentGuid => new Guid("{966c2673-1bd0-46f9-b55c-73a376c5cc83}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddGenericParameter("SolarData", "S", " SolarData form SolarDataFromEPW Component", GH_ParamAccess.item);
            pManager.AddSurfaceParameter("TargetSurface", "S", " surface", GH_ParamAccess.item);
            pManager.AddSurfaceParameter("Occluder", "S", " surface", GH_ParamAccess.list);            
            pManager.AddVectorParameter("SolarVector", "S", "sunVector ", GH_ParamAccess.list);
            //pManager.AddNumberParameter("Azimuth", "S", "sunVector ", GH_ParamAccess.item);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("data", "D", "data", GH_ParamAccess.list);
            //pManager.AddBrepParameter("shadow", "D", "data", GH_ParamAccess.list);
            
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

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            
            Dictionary <string, double[]> Solardata = new Dictionary<string, double[]> { };
            DA.GetData(0, ref Solardata);   
            GH_Surface surface = new GH_Surface();
            DA.GetData(1, ref surface);
            List<GH_Surface> occluder = new List<GH_Surface>();
            DA.GetDataList(2, occluder);
            List<Vector3d> solarVector = new List<Vector3d> { };
            DA.GetDataList(3, solarVector);     
            // List<GH_Surface> ContextsSurface = ContextsBrep.Where(num => num.Value.Faces.Count == 1).Select(num => new GH_Surface(num.Value.Faces[0].ToNurbsSurface())).ToList();
            //ContextsBrep.RemoveAll(item => item.Value.Faces.Count < 2);

            //double[] sFs = SFCaculate(surface, occluder, Solardata, solarVector,out List<Brep> shadowBrep,0);
            double[] sFs = SFCaculateYear(surface, occluder, Solardata, solarVector, 20);
            DA.SetDataList(0, sFs);
            //DA.SetDataList(1, shadowBrep);
        }

        public double[] SFCaculateYear(GH_Surface supersurface, List<GH_Surface> occluder, Dictionary<string, double[]> Solardata, List<Vector3d> solarVector, int interval = 1)
        {
            int totalDays = 365;
            int count= totalDays/interval+1;
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
                for (int h =0; h <  24 ; h++)
                {
                    if ((Solardata["zenith"][hour+h] > 1.57) || (normal * solarVector[hour+h] > 0))
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

        //是否需要进行遮挡计算

        /// <summary>
        /// 计算两个面的阴影系数
        /// </summary>
        /// <param name="targetSurface"></param>
        /// <param name="occludingSurface"></param>
        /// <param name="azimuth"></param>
        /// <param name="zenith"></param>
        /// <returns></returns>
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
        /// 通过两个面和一个向量计算两个面之间的遮挡系数
        /// </summary>
        /// <param name="targetSurface"></param>
        /// <param name="occludingSurface"></param>
        /// <param name="sunVector"></param>
        /// <returns></returns>
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
        public bool IsPointInsideSurface(Surface surface, Point3d point)
        {
            surface.ClosestPoint(point, out double u, out double v);
            Point3d closestPoint = surface.PointAt(u, v);
            return closestPoint.DistanceTo(point) < 0.001;
        }
    }

//    BoundingBox targetBoundingBox = surface.GetBoundingBox(false); // 使用false以提高性能
//    BoundingBox occludingBoundingBox = candidateSurface[i].Face.GetBoundingBox(false); // 使用false

//    // 计算从目标面最左侧点到遮挡面最右侧点的向量
//    Vector3d leftToRightVector = occludingBoundingBox.Corner(true, false, false) - targetBoundingBox.Corner(false, true, false);
//    Vector3d rightToLeftVector = occludingBoundingBox.Corner(true, true, false) - targetBoundingBox.Corner(false, false, false);

//    Vector3d d = rightToLeftVector - leftToRightVector;
//    Vector3d dd = -solarVector[h] - leftToRightVector;
//    double t = (dd * d) / (d * d);

//                        if (t > 1 || t< 0)
//                        {
//                            AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, $"t = {t}，leftToRightVector={leftToRightVector} ，rightToLeftVector={rightToLeftVector}");
//                            continue; // 排除没有交点的情况
//                        }
//                        else
//{
    //var contextTure =candidateSurface.Where(n => (Math.Max(n.Value.Vertices[0].Location.Z, n.Value.Vertices[2].Location.Z) - Math.Min(surface.Value.Vertices[0].Location.Z, surface.Value.Vertices[2].Location.Z)>0));

    //BrepVertexList surfacePoints = surface.Value.Vertices;
    //for (int j = 0; j < surfacePoints.Count; j++)
    //{
    //    //surfacePoints[j].
    //}

    //public class SunShadingCalculator
    //{
    //    public List<double> CalculateShadingRatio(List<Brep> breps, Surface targetSurface, Vector3d sunDirection)
    //    {
    //        List<double> shadingRatios = new List<double>();

    //        // Preprocess breps and filter surfaces
    //        List<Surface> candidateSurfaces = new List<Surface>();
    //        foreach (Brep brep in breps)
    //        {
    //            foreach (BrepFace face in brep.Faces)
    //            {
    //                // Check if face normal aligns with sun direction
    //                Vector3d faceNormal = face.NormalAt(face.PointAtNormalizedParameters(0.5, 0.5));
    //                if (Vector3d.VectorAngle(faceNormal, sunDirection) < Math.PI / 2)
    //                {
    //                    candidateSurfaces.Add(face.ToNurbsSurface());
    //                }
    //            }
    //        }

    //        // Calculate shading ratio for each candidate surface
    //        foreach (Surface surface in candidateSurfaces)
    //        {
    //            // Intersect sun rays with surface
    //            List<Curve> intersectionCurves = new List<Curve>();
    //            Rhino.Geometry.Intersect.Intersection.SurfaceSurface(targetSurface, surface, 0.001, out intersectionCurves);

    //            // Calculate shaded area
    //            double shadedArea = 0.0;
    //            foreach (Curve curve in intersectionCurves)
    //            {
    //                shadedArea += Rhino.Geometry.AreaMassProperties.Compute(curve).Area;
    //            }

    //            // Calculate total area of the surface
    //            double totalArea = Rhino.Geometry.AreaMassProperties.Compute(surface).Area;

    //            // Calculate shading ratio
    //            double shadingRatio = shadedArea / totalArea;
    //            shadingRatios.Add(shadingRatio);
    //        }

    //        return shadingRatios;
    //    }
}


