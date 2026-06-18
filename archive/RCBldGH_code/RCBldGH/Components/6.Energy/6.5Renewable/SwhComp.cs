using System;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using RCBldGH.Domains;
using RCBldGH.Modules;

namespace RCBldGH.Components.Renewable
{
    public class SwhComp:GH_Component
    {
        public SwhComp()
            : base("SWH", "SWH",
                "Solar Water Heating System",
                "RCBldGH", "6.Energy")
        {
        }

        public override Guid ComponentGuid => new Guid("{FB8D39E5-FBBA-469E-91AF-8F7E12785381}");
        public override GH_Exposure Exposure => GH_Exposure.quinary;
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.swh;

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddNumberParameter("SWH Area", "Area", "unit: m2", GH_ParamAccess.item);
            pManager.AddGenericParameter("SWH Orientation", "Orientation", "specify the orientation: S, SE, E, NE, N, NW, W, SW", GH_ParamAccess.item);
            pManager.AddNumberParameter("SWH Angle", "Angle", "unit: degree", GH_ParamAccess.item);
            pManager[0].Optional = true;
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("SWH", "SWH", "Solar Water Heating System", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "SWH text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            double area = 0;
            DA.GetData(0, ref area);

            object orientationObj = null;
            if (!DA.GetData(1, ref orientationObj))
            {
                return;
            }

            Orientation orientation;
            try
            {
                orientation = (Orientation)((GH_ObjectWrapper)orientationObj).Value;
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Orientation");
                return;
            }

            double angle = double.NaN;
            if (!DA.GetData(2, ref angle))
            {
                return;
            }
            if (!double.IsNaN(angle))
            {
                bool isOk = false;
                double[] list = { 15, 30, 45, 60, 75, 90 };
                foreach (double d in list)
                {
                    if (angle == d)
                    {
                        isOk = true;
                        break;
                    }
                }
                if (!isOk)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "SWH Angle must be 15, 30, 45, 60, 75, 90.");
                    return;
                }
            }

            SWH swh =new SWH
            {
                Angle =  angle,
                Area = area,
                Orientation = orientation
            };

            DA.SetData(0, swh);
            DA.SetData(1, swh.ToCen());
        }
    }
}