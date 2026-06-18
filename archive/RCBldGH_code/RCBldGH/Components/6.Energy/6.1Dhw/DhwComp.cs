using System;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Dhw
{
    public class DhwComp : GH_Component
    {
        public DhwComp()
            : base("DHW", "DHW",
                "DHW",
                "RCBldGH", "6.Energy")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.primary;
        public override Guid ComponentGuid => new Guid("{C0407B9E-7673-4896-893D-2C5B5D1DAECB}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.DHW;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddGenericParameter("DHW Distribution System", "D", "1. taps within 3m from heat generation, 2. taps more than 3m from heat generation, 3. circulation system or unknown.",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("DHW Generation System", "G", "1. electric generation, 2. VR-boiler, 3. gas_boiler or HR-boiler, 4. co-generation, 5. district heating, 6. heat pump, 7. steam.", GH_ParamAccess.item);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("DHW", "D", "DHW", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "DHW Text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            object distributionObj = null;
            if (!DA.GetData(0,ref distributionObj))
            {
                return;
            }

            DhwDistributionSystem distribution;
            try
            {
                distribution = (DhwDistributionSystem) ((GH_ObjectWrapper) distributionObj).Value;
            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid DHW Distribution System");
                return;
            }

            object generationOjb = null;
            if (!DA.GetData(1,ref generationOjb))
            {
                return;
            }

            DhwGenerationSystem generation;
            try
            {
                generation = (DhwGenerationSystem) ((GH_ObjectWrapper) generationOjb).Value;
            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid DHW Generation System");
                return;
            }

            DHW dhw = new DHW
            {
                DhwDistributionSystem = distribution,
                DhwGenerationSystem = generation
            };

            DA.SetData(0, dhw);
            DA.SetData(1, dhw.ToCen());

        }
    }
}