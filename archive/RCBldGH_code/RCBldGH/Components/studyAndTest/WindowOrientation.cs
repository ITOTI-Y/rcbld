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
using Rhino;
using Rhino.Geometry.Collections;

namespace RCBldGH.Components.other.studyAndTest
{
    public class WindowOrientation : GH_Component
    {
        /// <summary>
        /// Initializes a new instance of the MyComponent1 class.
        /// </summary>
        public WindowOrientation()
          : base("WindowCustom", "Nickname",
              "Description",
              "RCBldGH", "Subcategory")
        {
        }

        /// <summary>
        /// Registers all the input parameters for this component.
        /// </summary>
        protected override void RegisterInputParams(GH_Component.GH_InputParamManager pManager)
        {
            pManager.AddBrepParameter("Room", "S", "Surfaces that can form a closed zone.", GH_ParamAccess.item);
            pManager.AddTextParameter("Toward", "T", "To describe which direction should generate the window.You can use a list of N,E,S,W", GH_ParamAccess.item);
        }


        /// <summary>
        /// Registers all the output parameters for this component.
        /// </summary>
        protected override void RegisterOutputParams(GH_Component.GH_OutputParamManager pManager)
        {
            pManager.AddSurfaceParameter("Room", "S", "Surfaces that can form a closed zone.", GH_ParamAccess.list);
        }

      
        protected override void SolveInstance(IGH_DataAccess DA)
        {
            Brep brep=null;
            DA.GetData(0, ref brep);

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

            BrepFaceList _roomface;//声明面列表
            _roomface = brep.Faces; //分解几何体

            List<Surface> north = new List<Surface> { };
            List<Surface> west = new List<Surface> { };
            List<Surface> south = new List<Surface> { };
            List<Surface> east = new List<Surface> { };

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
                if (normal.Y > 0 && normal.Y > Math.Abs(normal.X))
                {
                    north.Add(face);
                }
                if (normal.X < 0 && -normal.X > Math.Abs(normal.Y))
                {
                    west.Add(face);
                }
                if (normal.Y < 0 && -normal.Y > Math.Abs(normal.X))
                {
                    south.Add(face);
                }
                if (normal.X > 0 && normal.X > Math.Abs(normal.Y))
                {
                    east.Add(face);
                }
            }
            List<List<Surface>> lists = new List<List<Surface>> { north, east, south, west };
            DA.SetDataList(0, lists[direction]);

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
            get { return new Guid("cef36367-4de9-42c2-ab60-69f7283aa7eb"); }
        }
        
       
    }
}