using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using RCBldGH.Domains;

namespace RCBldGH.Components.Hvac
{
    public class CopPairGroupComp: GH_Component
    {
        public CopPairGroupComp()
            : base("Cop Pair Group", "Cop Pair Group",
                "Cop Pair Group",
                "RCBldGH", "3.Program")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.HAVC_cop;
        public override GH_Exposure Exposure => GH_Exposure.quarternary;
        public override Guid ComponentGuid
        {
            get { return new Guid("{6B8B512E-B2ED-4FBA-ABC0-98B05D64D878}"); }
        }

        protected override void RegisterInputParams(GH_Component.GH_InputParamManager pManager)
        {
            pManager.AddIntegerParameter("Load percentage", "P", "Between 0 and 100.", GH_ParamAccess.list);
            pManager.AddNumberParameter("Relative efficiency", "E", "Relative efficiency", GH_ParamAccess.list);
        }

        protected override void RegisterOutputParams(GH_Component.GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Cop Group", "Cop Group", "Cop Group", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            List<int> cops = new List<int>();
            if (!DA.GetDataList(0, cops))
            {
                return;
            }
            List<double> efficiencyList = new List<double>();
            if (!DA.GetDataList(1,efficiencyList))
            {
                return;
            }

            if (cops.Count!=efficiencyList.Count)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "The number of Load percentage data must be the same as the number of Relative efficiency data.");
                return;
            }
            Dictionary<int,double> dictionary = new Dictionary<int, double>();
            for (int i = 0; i < cops.Count; i++)
            {
                dictionary[cops[i]] = efficiencyList[i];
            }
            CopPairGroup group = new CopPairGroup{Dictionary = dictionary};
            DA.SetData(0, group);
        }
    }
}