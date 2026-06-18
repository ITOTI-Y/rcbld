using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.AccessControl;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Rhino;
using Rhino.Commands;
using Rhino.DocObjects;
using Rhino.Geometry;
using Rhino.Geometry.Collections;
using Rhino.Input.Custom;
using Rhino.Input;
using Rhino.UI;
using RCBldGH.Modules;
using RCBldGH.Utils;
using Grasshopper.Kernel.Types.Transforms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using Rhino.Render;
using System.Security.Cryptography.X509Certificates;

namespace RCBldGH.Components.Envelope
{
    public class WindowWallRate : GH_Component
    {
        public WindowWallRate()
            : base("WindowWallRate", "Window wall rate", "Using nWindow wall rate to generate windows,, to be used with the Window componen", "RCBldGH", "2.Envelops")
        {
        }

        public override Guid ComponentGuid => new Guid("{04ba6904-966b-43eb-a99b-daf637ea1a73}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.WWR;
        public override GH_Exposure Exposure => GH_Exposure.primary;

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddBrepParameter("Room", "R", "a Room need to", GH_ParamAccess.item);
            pManager.AddTextParameter("Toward", "T", "To describe which direction should generate the window.You can use a list of N,E,S,W", GH_ParamAccess.item);
            pManager.AddNumberParameter("window wall rate", "WWR", "a number to decribe window wall rate(0.00=>1.00)", GH_ParamAccess.item);
            //pManager.AddBooleanParameter("Central or rectangular window", "cOrR", "Boolean to note whether to generate a single window in the center of each Face (False) or to generate a series of rectangular windows using the other inputs below (True).", GH_ParamAccess.item, false);
            //pManager.AddNumberParameter("Window Height", "H", "A number for the target height of the output apertures", GH_ParamAccess.item);
           // pManager.AddNumberParameter("Sill Height", "sillH", "A number for the target height above the bottom edge of the face to start the apertures.", GH_ParamAccess.item);

            //pManager[3].Optional = true;
            //pManager[4].Optional = true;
            //pManager[5].Optional = true;

        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddSurfaceParameter("Surface", "S", "A surface representing the window", GH_ParamAccess.list);
            pManager[0].DataMapping = GH_DataMapping.Flatten;
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            GH_Brep Room = new GH_Brep();
            DA.GetData(0, ref Room);
            
            String towards = null;
            DA.GetData(1, ref towards);

            int direction = -1;//0=N,1=E,2=S,3=W
            if (towards.Contains("N") || towards.Contains("n"))
            { direction = 0; }
            if (towards.Contains("E") || towards.Contains("e"))
            { direction = 1; }
            if (towards.Contains("S") || towards.Contains("s"))
            { direction = 2; }
            if (towards.Contains("W") || towards.Contains("w"))
            { direction = 3; }


            double WWR = 0;
            DA.GetData(2, ref WWR);
            if (WWR < 0 || WWR > 1)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The range is 0 to 1");
                return;
            }
            List<Surface> windows = new List<Surface>();
            
            //bool cOrR = false;
            //DA.GetData(3, ref cOrR);            
            
            //if (cOrR == true)
            //{
            //    Surface a = roomface[direction];
            //    double wHeight = 0;
            //    double sHeight = 0;
            //    DA.GetData(4, ref wHeight);
            //    DA.GetData(5, ref sHeight);

                
            //    Surface window = createRecWindow(WWR, a, wHeight, sHeight);
                
            //    windows.Add(window);

            //}
            //else
            
                BrepFaceList roomface;//声明面列表
                roomface = Room.Value.Faces; //分解几何体
                Surface a = directionSurface(direction,Room);
                var ap = AreaMassProperties.Compute(a);
                var centroid = ap.Centroid;
                double scale = Math.Sqrt(WWR);
                Transform scaleTransform = Transform.Scale(centroid, scale);
                a.Transform(scaleTransform);                   
                windows.Add(a);
            
            
            DA.SetDataList(0, windows);
           


            Surface directionSurface(int direct, GH_Brep room)
            {
                BrepFaceList _roomface;//声明面列表
                _roomface = room.Value.Faces; //分解几何体
                int[] dir=new int[4] { 0, 0, 0, 0 };
                for (int i = 0; i < _roomface.Count; i++)
                {
                    Surface face = _roomface[i].ToNurbsSurface();
                    var _ap = AreaMassProperties.Compute(face);
                    var _centroid = _ap.Centroid;
                    face.ClosestPoint(_centroid, out double u, out double v);
                    Vector3d normal = face.NormalAt(u, v);
                    if (normal.Z != 0 && (normal.X == 0 && normal.Y == 0))
                    {
                        continue;
                    }
                    if (normal.X > normal.Y)
                    {
                        if (normal.X > 0.707) { dir[1] = i; }
                        else { dir[2] = i; }
                    }
                    else 
                    {
                        if (normal.X >-0.707) { dir[0] = i; }//北侧的面的序号
                        else { dir[3] = i; }
                    }
                }

                Surface result = roomface[dir[direct]].ToNurbsSurface();
                return result;
            }

            //Surface createRecWindow(double wwr, Surface objectFace, double wHeight, double sillHeight)
            //{

            //    var ap = AreaMassProperties.Compute(objectFace);
            //    var centroid = ap.Centroid;
            //    objectFace.ClosestPoint(centroid, out double u, out double v);
            //    Vector3d normal = objectFace.NormalAt(u, v);
            //    Plane plane = new Plane(centroid, normal);
            //    Circle circle = new Circle(plane, centroid, 5);
            //    Curve curve = circle.ToNurbsCurve();

            //    BoundingBox bbx = objectFace.GetBoundingBox(true);
            //    Point3d[] corners = bbx.GetCorners();

            //    Point3d[] cornersSort = SortAlongCurve(curve, corners);

            //    Point3d vertice1 = cornersSort[0];
            //    Point3d vertice2 = cornersSort[2];
            //    Point3d vertice3 = cornersSort[4];
            //    Point3d vertice4 = cornersSort[6];


            //    Vector3d v1 = vertice2 - vertice1;//向下
            //    Vector3d v2 = vertice4 - vertice1;//向右
            //    GH_Surface gH_Surface = new GH_Surface(objectFace);
            //    double area = SurfaceTools.GetGH_SurfaceArea(gH_Surface);
            //    double windowArea = area * wwr;
            //    double wWidth = windowArea / wHeight;

            //    double sHeight = v1.Z;
            //    double Hstretch = 1 - (wHeight / sHeight);
            //    double sWidth = area / sHeight;
            //    double Wstretch = 1 - (wWidth / sWidth);

            //    Transform t1 = Transform.Translation(v1 * Wstretch / 2);
            //    Transform t2 = Transform.Translation(v1 * (-1) * Wstretch / 2);
            //    Transform t3 = Transform.Translation(v2 * Hstretch / 2);
            //    Transform t4 = Transform.Translation(v2 * (-1) * Hstretch / 2);
            //    Point3d p1 = vertice1;
            //    Point3d p2 = vertice2;
            //    Point3d p3 = vertice3;
            //    Point3d p4 = vertice4;

            //    p1.Transform(t1);
            //    p2.Transform(t2);
            //    p3.Transform(t2);
            //    p4.Transform(t1);//上下

            //    p1.Transform(t3);//左右
            //    p2.Transform(t3);
            //    p3.Transform(t4);
            //    p4.Transform(t4);


            //    Brep brep = Brep.CreateFromCornerPoints(p1, p2, p3, p4, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
            //    BrepFace brepFace = brep.Faces[0];
            //    Surface window = brepFace;
            //    return window;
            //}
        }



        class PointParam
        {
            public Point3d Point { get; set; }
            public double Param { get; set; }

            public PointParam(Point3d point, double param)
            {
                Point = point;
                Param = param;
            }
        }
        class PointParamComparer : IComparer<PointParam>
        {
            public int Compare(PointParam x, PointParam y)
            {
                return x.Param.CompareTo(y.Param);
            }
        }
        Point3d[] SortAlongCurve(Curve curve, Point3d[] points)
        {
            // 创建一个PointParam数组，用于存储点和它们在curve上的参数
            PointParam[] pointParams = new PointParam[points.Length];
            for (int i = 0; i < points.Length; i++)
            {
                curve.ClosestPoint(points[i], out double param);
                pointParams[i] = new PointParam(points[i], param);
            }
            PointParamComparer comparer = new PointParamComparer();

            Array.Sort(pointParams, comparer);

            Point3d[] sortedPoints = new Point3d[points.Length];
            for (int i = 0; i < points.Length; i++)
            {
                sortedPoints[i] = pointParams[i].Point;
            }

            return sortedPoints;
        }



    }

}