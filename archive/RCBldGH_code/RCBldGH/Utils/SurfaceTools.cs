using System;
using System.Collections.Generic;
using Grasshopper.Kernel.Types;
using Rhino;
using Rhino.Geometry;

namespace RCBldGH.Utils
{
    public class SurfaceTools
    {
        /// <summary>
        /// 计算 GH_Surface 的面积，未计算成功返回 -1
        /// </summary>
        /// <param name="ghSurface"></param>
        /// <returns></returns>
        public static double GetGH_SurfaceArea(GH_Surface ghSurface)
        {
            if (ghSurface==null)
            {
                return -1;
            }

            

            var brep = ghSurface.Value;
            if (brep==null)
            {
                return -1;
            }

            AreaMassProperties areaMassProperties = AreaMassProperties.Compute(brep.Faces[0]); 

            if (areaMassProperties==null)
            {
                return -1;
            }

            return Math.Abs(areaMassProperties.Area);
        }

        public static double GetBrepArea(Brep ghSurface)
        {
            if (ghSurface == null)
            {
                return -1;
            }
            AreaMassProperties areaMassProperties = AreaMassProperties.Compute(ghSurface.Faces[0]);

            if (areaMassProperties == null)
            {
                return -1;
            }

            return Math.Abs(areaMassProperties.Area);
        }

        public static Point3d GetGH_SurfaceCentroid(GH_Surface ghSurface)
        {
            var brep = ghSurface.Value;
            AreaMassProperties areaMassProperties = AreaMassProperties.Compute(brep);
            return areaMassProperties.Centroid;
        }

        /// <summary>
        /// 判断 GH_Surface 是否为平面曲面。
        /// </summary>
        /// <param name="ghSurface"></param>
        /// <returns></returns>
        public static bool IsGhSurfacePlaner(GH_Surface ghSurface)
        {
            BrepFace opaque1Face = ghSurface.Face;
            bool isPlanar = opaque1Face.TryGetPlane(out _, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
            return isPlanar;
        }

        /// <summary>
        /// 判断两个 GH_Surface 是否共面。
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns></returns>
        public static bool IsTwoGhSurfacesCoplanar(GH_Surface a, GH_Surface b)
        {
            try
            {
                a.Face.TryGetPlane(out var planeA, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                b.Face.TryGetPlane(out var planeB, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                bool isCoplanar = VectorTools.IsPlanesCoplanar(planeA, planeB);
                return isCoplanar;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// 判断一个 GH_Surface 是否和一个 Plane 共面。
        /// </summary>
        /// <param name="ghSurface"></param>
        /// <param name="plane"></param>
        /// <returns></returns>
        public static bool IsPlaneGhSurfaceCoplanar(GH_Surface ghSurface, Plane plane)
        {
            try
            {
                ghSurface.Face.TryGetPlane(out var plane2, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                return VectorTools.IsPlanesCoplanar(plane, plane2);
            }
            catch (Exception)
            {
                return false;
            }
        }


        /// <summary>
        /// 判断多个 GH_Surface 是否共面。
        /// </summary>
        /// <param name="ghSurfaces"></param>
        /// <returns></returns>
        public static bool IsGhSurfacesCoplanar(List<GH_Surface> ghSurfaces)
        {
            bool isCoplanar = false;
            if (ghSurfaces.Count<=1)
            {
                return false;
            }
            try
            {
                ghSurfaces[0].Face.TryGetPlane(out var planeA, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                for (int i = 1; i < ghSurfaces.Count; i++)
                {
                    ghSurfaces[i].Face.TryGetPlane(out var planeB, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                    isCoplanar = VectorTools.IsPlanesCoplanar(planeA, planeB);
                    if (!isCoplanar)
                    {
                        return false;
                    }
                }

                return isCoplanar;
            }
            catch (Exception )
            {
                return false;
            }
        }
    }
}