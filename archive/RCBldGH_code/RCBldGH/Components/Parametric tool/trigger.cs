using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using SimBldPyUI.Modules;
using SimBldPyUI.Utils;

namespace SimBldPyUI.Components.Envelope
{
    public class TriggerComp : GH_Component
    {
        int updates = 0;
        int a = -1;
        public TriggerComp(): base("Trigger", "TE", "Create a Trigger", "SimBldPy", "ParametricTool") { }

        public override GH_Exposure Exposure => GH_Exposure.primary;

        public override Guid ComponentGuid => new Guid("{d2963bbc-436c-4e6a-84a6-a33ce24939b3}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {            
            pManager.AddIntegerParameter( "Strat", "S", "Start value.", GH_ParamAccess.item,0);
            pManager.AddIntegerParameter("End", "E", "End value.", GH_ParamAccess.item,100);
            pManager.AddBooleanParameter("Reset", "R", "Reset value.", GH_ParamAccess.item);
            pManager.AddBooleanParameter("Auto update or not", "A", "Auto update or not.", GH_ParamAccess.item);
            pManager.AddIntegerParameter("UpdateInterval", "Interval", "Update Interval in milliseconds", GH_ParamAccess.item);

        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            
            pManager.AddNumberParameter( "Value", "V", "Value", GH_ParamAccess.item);
            
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            bool reset = false;
            bool auto = false;
            int millsec = 1000;
            
            int start = 0;
            int end = 0;
            
            if (!DA.GetData(2, ref reset)) return;
            if (!DA.GetData(3, ref auto)) return;
            DA.GetData(0, ref start);
            DA.GetData(1, ref end);
            DA.GetData(4, ref millsec);

            if (reset) 
            { 
                updates = start;
                a = 0;
            }
            updates++;


            DA.SetData(0, updates);
            if (updates >= end)
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
