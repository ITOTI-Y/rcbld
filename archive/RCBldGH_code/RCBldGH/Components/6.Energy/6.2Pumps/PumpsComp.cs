using System;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Pumps
{
    public class PumpsComp:GH_Component
    {
        public PumpsComp()
            : base("Pump", "Pump",
                "Pump use information",
                "RCBldGH", "6.Energy")
        {
        }

        public override Guid ComponentGuid => new Guid("{093978D5-552F-4077-9437-D22347B11228}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.pump;
        public override GH_Exposure Exposure => GH_Exposure.secondary;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddNumberParameter("Heating Use Pump Power Per Water Flow Rate", "H",
                "unit: W-s/m3", GH_ParamAccess.item);
            pManager.AddNumberParameter("Cooling Use Pump Power Per Water Flow Rate", "C",
                "unit: W-s/m3", GH_ParamAccess.item);
            pManager.AddNumberParameter("DHW Use Pump Power Per Water Flow Rate", "P",
                "unit: W-s/m3", GH_ParamAccess.item);
            pManager.AddNumberParameter("DHW Use Peak Flow Rate", "F",
                "unit: m3/s", GH_ParamAccess.item);
            pManager.AddGenericParameter("Pump Control Type", "T", "1. no pump used, 2. automatic control more than 50%, 3. all other case.", GH_ParamAccess.item);
            pManager[1].Optional = true;
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Pumps", "P", "Pumps", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Pumps text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            double h = double.NaN;
            if (!DA.GetData(0,ref h))
            {
                return;
            }

            double c = double.NaN;
            DA.GetData(1, ref c);

            double p = double.NaN;
            if (!DA.GetData(2,ref p))
            {
                return;
            }

            double f = double.NaN;
            if (!DA.GetData(3, ref f))
            {
                return;
            }

            object typeObj = null;
            if (!DA.GetData(4,ref typeObj))
            {
                return;
            }

            PumpControlType type;
            try
            {
                type = (PumpControlType)((GH_ObjectWrapper)typeObj).Value;
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Pump Control Type");
                return;
            }

            Modules.Pumps pumps = new Modules.Pumps
            {
                HeatingUsePumpRate = h,
                CoolingUsePumpRate = c,
                DhwUsePumpPowerPerWaterFlowRate = p,
                DhwUsePeakFlowRate = f,
                PumpControlType = type
            };

            DA.SetData(0, pumps);
            DA.SetData(1, pumps.ToCen());
        }
    }
}