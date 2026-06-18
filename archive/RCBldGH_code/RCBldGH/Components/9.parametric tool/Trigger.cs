using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Parameters;
using Grasshopper.Kernel.Types;
using Rhino;
using RCBldGH.Modules;

namespace RCBldGH.Components
{

    public class TriggerComp : GH_Component
    {
        double number = 1;
        int a = -1;
        List<double> doubles = new List<double>();
        public TriggerComp() : base("Trigger", "TE", "Create a Trigger", "RCBldGH", "ParametricTool") { }

        public override GH_Exposure Exposure => GH_Exposure.primary;
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.trigger;

        public override Guid ComponentGuid => new Guid("{d2963bbc-436c-4e6a-84a6-a33ce24939b3}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddNumberParameter("Strat", "S", "Start value.", GH_ParamAccess.item, 0);
            pManager.AddNumberParameter("End", "E", "End value.", GH_ParamAccess.item, 100);
            pManager.AddNumberParameter("Step", "S", "Step value.", GH_ParamAccess.item, 1);
            pManager.AddBooleanParameter("Reset", "R", "Reset value.", GH_ParamAccess.item);
            pManager.AddBooleanParameter("Auto update or not", "A", "Auto update or not.", GH_ParamAccess.item);
            pManager.AddIntegerParameter("UpdateInterval", "Interval", "Update Interval in milliseconds", GH_ParamAccess.item,1000);
            pManager[5].Optional = true;
            pManager[3].Optional = true;
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {

            pManager.AddNumberParameter("Value", "V", "Value", GH_ParamAccess.item);
            pManager.AddNumberParameter("Value List", "V", "Value", GH_ParamAccess.list);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            bool reset = false;
            bool auto = false;
            int millsec = 1000;
            double step = 1;

            double start = 0;
            double end = 0;
            DA.GetData("Strat", ref start);
            DA.GetData("End", ref end);
            DA.GetData("Reset", ref reset);
            if (!DA.GetData("Auto update or not", ref auto)) return;
            DA.GetData("Step", ref step);            
            DA.GetData("UpdateInterval", ref millsec);
            
            number += step;
            if (reset)
            {
              number = start;
              a = 0;
              doubles.Clear();
            }     
            doubles.Add(number);
            DA.SetDataList(1, doubles);
            DA.SetData(0, number);
            if (number >= end)
            {
                a = -1;
            }
            if (a == 0)
            {
                if (auto)
                {
                    this.OnPingDocument().ScheduleSolution(millsec, doc => { this.ExpireSolution(false); });

                }
            }

        }

    }
}
