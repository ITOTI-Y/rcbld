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
    public class IsSurfaceOnComp : GH_Component
    {
        public IsSurfaceOnComp() : base("IsSurfaceOn", "Material to Brep", "Assignment MaterialSetting to breps", "RCBldGH", "2.Envelops")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.primary;
        public override Guid ComponentGuid => new Guid("{95c51d43-16f8-4445-b926-8c815dc3b164}");
        
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddSurfaceParameter("a", "MaterialSetting", "set the room material set,using roof material/externalfl", GH_ParamAccess.item);
            pManager.AddSurfaceParameter("b", "MaterialSetting", "set the room material set,using roof material/externalfl", GH_ParamAccess.item);
        }
        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {            
            pManager.AddBooleanParameter("is", "setting", "Envelope setting", GH_ParamAccess.item);
            pManager.AddPointParameter("apoint", "setting", "Envelope setting", GH_ParamAccess.item);
            pManager.AddPointParameter("Bpoint", "setting", "Envelope setting", GH_ParamAccess.item);
            pManager.AddPointParameter("boundingPoint", "setting", "Envelope setting", GH_ParamAccess.item);
            pManager.AddNumberParameter("distance", "setting", "Envelope setting", GH_ParamAccess.item);
        }


        protected override void SolveInstance(IGH_DataAccess DA)
        {
            Surface a = null;
            Surface b = null;
            DA.GetData(0, ref a);
            DA.GetData(1, ref b);
            bool isOnSurface = false;


            AreaMassProperties ampA = AreaMassProperties.Compute(a);
            Point3d centroidA = ampA.Centroid;
            var areaA = ampA.Area;
            var normalA = a.NormalAt(0, 0);

            AreaMassProperties ampB = AreaMassProperties.Compute(b);
            Point3d centroidB = ampB.Centroid;
            var areaB = ampB.Area;
            var normalB = b.NormalAt(0, 0);



            b.ClosestPoint(centroidA, out double u, out double v);
            Point3d bPoint = b.PointAt(u, v);//b距离a的中点最近的点
            a.ClosestPoint(bPoint, out double q, out double e);
            Point3d aPoint = a.PointAt(q, e);//a距离b的中点最近的点
            var bounding = (aPoint - centroidB);
            if (bounding.Length > 1)
            { bounding.Unitize(); }
            var aBoundingPoint = aPoint - 0.1 * bounding;
            a.ClosestPoint(aBoundingPoint, out double r, out double t);
            Point3d bBoundingPoint = a.PointAt(r, t);//b距离a的中点最近的点
            if (aBoundingPoint.DistanceTo(bBoundingPoint) < 0.001)
                
            {
                isOnSurface = true;
                //1、完全重合
                if ((centroidA.DistanceTo(centroidB) < 0.01) && (areaA == areaB))
                {
                    //state = 0;
                }
                else//2、不完全重合
                {
                    //state = 1;
                }
                // }
            }
            DA.SetData(0, isOnSurface);
            DA.SetData(1, aPoint);
            DA.SetData(2, bPoint);
            DA.SetData(3, aBoundingPoint);
            DA.SetData(4, aBoundingPoint.DistanceTo(bBoundingPoint));

        }
    }
}
