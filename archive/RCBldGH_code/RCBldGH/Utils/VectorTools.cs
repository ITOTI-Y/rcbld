using System;
using Rhino;
using Rhino.Geometry;
using RCBldGH.Domains;

namespace RCBldGH.Utils
{
    public class VectorTools
    {
        /// <summary>
        /// 求向量在任意平面上的投影，投影的结果是长度为 1 的单位向量。
        /// </summary>
        /// <param name="vector3d">要投影的向量。</param>
        /// <param name="plane">参考平面。</param>
        /// <returns></returns>
        public static Vector3d Vector3dPorjectToPlane(Vector3d vector3d, Plane plane)
        {
            if (vector3d.Length == 0.0)
            {
                throw new Exception("Cannot straighten a plane with a zero-length guide vector.");
            }
            double angle;

            Plane newPlane;
            newPlane = AlignPlaneToVect(plane, vector3d, out angle);
            return newPlane.XAxis;
        }

        /// <summary>
        /// 对齐平面，将平面绕自身的 Z 轴旋转，旋转到平面的 X 轴与给定的向量夹角最小。
        /// </summary>
        /// <param name="plane">参考平面。</param>
        /// <param name="vector3d">对齐平面的目标向量。</param>
        /// <param name="angle">对齐后平面旋转的弧度值。</param>
        /// <returns></returns>
        public static Plane AlignPlaneToVect(Plane plane, Vector3d vector3d, out double angle)
        {
            if (vector3d.Length == 0.0)
            {
                throw new Exception("Cannot straighten a plane with a zero-length guide vector.");
            }
            double y;
            double x;
            plane.ClosestParameter(plane.Origin + vector3d, out y, out x);
            double num = Math.Atan2(y, x);
            plane.Rotate(-num + 1.5707963267948966, plane.ZAxis, plane.Origin);
            angle = 1.5707963267948966 - num;
            return plane;
        }

        /// <summary>
        /// 以参考平面的 Y 轴为北方，判断向量的朝向。
        /// </summary>
        /// <param name="basePlane">基准平面</param>
        /// <param name="direction">方向向量</param>
        /// <returns></returns>
        public static Domains.Orientation GetOrientation(Plane basePlane, Vector3d direction)
        {
            if (!basePlane.IsValid || !direction.IsValid || Math.Abs(direction.Length) <= 0.0)
            {
                return Orientation.InValid;
            }

            // 判断方向和平面是否垂直
            int paraResult = basePlane.ZAxis.IsParallelTo(direction, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
            // 平行平面Z
            if (paraResult == 1)
            {
                return Orientation.UP;
            }
            // 反向平行平面Z
            if (paraResult == -1)
            {
                return Orientation.DOWN;
            }

            // 不垂直可以求方向
            // 计算出四个基准向量。
            Vector3d projected = Vector3dPorjectToPlane(direction, basePlane);
            Vector3d dirE = basePlane.XAxis;
            Vector3d dirN = basePlane.YAxis;
            Vector3d dirNe = dirE + dirN;
            Vector3d dirSe = dirE - dirN;

            int toward = HasSameToward(projected, dirE);
            if (toward != 0 )
            {
                if (toward == 1)
                {
                    return Orientation.E;
                }

                return Orientation.W;
            }

            toward = HasSameToward(projected, dirN);
            if (toward != 0)
            {
                if (toward == 1)
                {
                    return Orientation.N;
                }

                return Orientation.S;
            }

            toward = HasSameToward(projected, dirNe);
            if (toward != 0)
            {
                if (toward == 1)
                {
                    return Orientation.NE;
                }

                return Orientation.SW;
            }

            toward = HasSameToward(projected, dirSe);
            if (toward != 0)
            {
                if (toward == 1)
                {
                    return Orientation.SE;
                }

                return Orientation.NW;
            }

            return Orientation.InValid;
        }

        /// <summary>
        /// 判断两个向量的朝向是否相同或相反。
        /// 如果两个向量的夹角小于等于 π/8，就认为两个向量的朝向相同。
        /// 如果两个向量的夹角介于 π 和 7π/8 之间，就认为两个向量朝向相反。
        /// </summary>
        /// <returns>
        /// 朝向相同返回 1。
        /// 朝向相反返回 -1。
        /// 朝向不相同也不相反返回 0。
        /// </returns>
        public static int HasSameToward(Vector3d a, Vector3d b)
        {
            double angle = Vector3d.VectorAngle(a, b);
            if (angle <= Math.PI / 8)
            {
                return 1;
            }
            else if (angle >= 7 * Math.PI / 8)
            {
                return -1;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// 计算一个世界XY坐标系的点，相对于给定的坐标系统的坐标。
        /// </summary>
        /// <param name="pt"></param>
        /// <param name="plane"></param>
        /// <returns></returns>
        public static Point3d GetPlaneCoordinates(Point3d pt, Plane plane)
        {
            plane.ClosestParameter(pt, out var x, out var y);
            double z = plane.DistanceTo(pt);
            return new Point3d(x, y, z);
        }

        /// <summary>
        /// 判断两个 Plane 是否共面。
        /// </summary>
        /// <param name="p1"></param>
        /// <param name="p2"></param>
        /// <returns></returns>
        public static bool IsPlanesCoplanar(Plane p1, Plane p2)
        {
            Random rd = new Random();
            double u = rd.Next(10, 100) * 0.1;
            double v = rd.Next(10, 100) * 0.1;
            Point3d ptOnP2 = p2.PointAt(u, v);
            Point3d coordinate=GetPlaneCoordinates(ptOnP2, p1);
            if (Math.Abs(coordinate.Z)<RhinoDoc.ActiveDoc.ModelAbsoluteTolerance)
            {
                return true;
            }

            return false;
        }
    }
}