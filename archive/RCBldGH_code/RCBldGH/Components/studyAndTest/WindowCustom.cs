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
using Rhino.Render.ChangeQueue;

namespace RCBldGH.Components.other.studyAndTest
{
    public class WindowCustom : GH_Component
    {
        /// <summary>
        /// Initializes a new instance of the MyComponent1 class.
        /// </summary>
        public WindowCustom()
          : base("WindowCustom", "Nickname",
              "Description",
              "RCBldGH", "Other")
        {
        }

        /// <summary>
        /// Registers all the input parameters for this component.
        /// </summary>
        protected override void RegisterInputParams(GH_Component.GH_InputParamManager pManager)
        {
            pManager.AddSurfaceParameter("surface", "S", "Surfaces that can form a closed zone.", GH_ParamAccess.item);
            pManager.AddNumberParameter("width", "width", "width", GH_ParamAccess.item,1);
            pManager.AddNumberParameter("height", "height", "height", GH_ParamAccess.item,1);
        }


        /// <summary>
        /// Registers all the output parameters for this component.
        /// </summary>
        protected override void RegisterOutputParams(GH_Component.GH_OutputParamManager pManager)
        {
            pManager.AddGeometryParameter("Room", "S", "Surfaces that can form a closed zone.", GH_ParamAccess.list);
        }

      
        protected override void SolveInstance(IGH_DataAccess DA)
        {
            List<GeometryBase> result = new List<GeometryBase> { };
            Surface x=null;
            DA.GetData(0, ref x);
            double height=0;
            double width=0;
            DA.GetData("height",ref height);
            DA.GetData("width", ref width);
            x.SetDomain(0, new Interval(0, 1));
            x.SetDomain(1, new Interval(0, 1));

            Point3d corner1 = x.PointAt(0, 0);
            Point3d corner2 = x.PointAt(1, 1);

            double heightSurface = Math.Abs(corner1.Z - corner2.Z);
            double widthSurface = Math.Sqrt((corner1.X - corner2.X) * (corner1.X - corner2.X) + (corner1.Y - corner2.Y) * (corner1.Y - corner2.Y));

            int amountH = (int)(heightSurface / height);
            int amountW = (int)(widthSurface / width);
            double moH = (heightSurface % height);
            double moW = (widthSurface % width);

            double HL = moH / (amountH - 1) + height;
            double WL = moW / (amountW - 1) + width;

            Vector3d v = (x.PointAt(0, 1) - corner1);
            v.Unitize();
            Vector3d u = (x.PointAt(1, 0) - corner1);
            u.Unitize();

            Transform tHE;
            Transform tWE;

            Transform tH;
            Transform tW;


            if (u.Z == 0)
            {
                tHE = Transform.Translation(v * HL);
                tWE = Transform.Translation(u * WL);

                tH = Transform.Translation(v * height);
                tW = Transform.Translation(u * width);
            }
            else
            {
                tHE = Transform.Translation(u * HL);
                tWE = Transform.Translation(v * WL);

                tH = Transform.Translation(u * height);
                tW = Transform.Translation(v * width);
            }

            Point3d point2 = corner1;
            point2.Transform(tH);
            Point3d point3 = point2;
            point3.Transform(tW);
            Point3d point4 = corner1;
            point4.Transform(tW);
            
            Brep brep = Brep.CreateFromCornerPoints(corner1, point2, point3, point4, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
            Surface surface = brep.Faces[0].ToNurbsSurface();


            if (u.Z == 0)
            {
                for (int i = 0; i < amountH; i++)
                {
                    GeometryBase surface1 = surface.Duplicate();
                    result.Add(surface1.Duplicate());
                    for (int j = 0; j < amountW - 1; j++)
                    {
                        surface1.Transform(tWE);
                        result.Add(surface1.Duplicate());
                    }
                    surface.Transform(tHE);
                }
            }
            else 
            {

                for (int i = 0; i < amountH; i++)
                {
                    GeometryBase surface1 = surface.Duplicate();
                    result.Add(surface1.Duplicate());
                    for (int j = 0; j < amountW - 1; j++)
                    {
                        surface1.Transform(tHE);
                        result.Add(surface1.Duplicate());
                    }
                    surface.Transform(tWE);
                }
                
            }

            DA.SetDataList(0, result);

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
            get { return new Guid("f310d8f5-4f63-40bc-bba0-6c0711556d1a"); }
        }
        
       
    }
}