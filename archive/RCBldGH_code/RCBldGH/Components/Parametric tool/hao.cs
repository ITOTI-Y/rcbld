using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using Rhino.Geometry.Collections;
using SimBldPyUI.Modules;
using SimBldPyUI.Utils;

namespace SimBldPyUI.Components.Envelope
{
    public class HaoComp : GH_Component
    {
        int time = 0;
        int day = 0;
        int month = 0;
        int a = -1;
        public HaoComp()
            : base("time", "Htime", "A gift for Zhanghao", "SimBldPy", "ParametricTool")
        {
        }

        public override GH_Exposure Exposure => GH_Exposure.primary;
        protected override System.Drawing.Bitmap Icon => SimBldPyUI.Properties.Resources.hao;

        public override Guid ComponentGuid => new Guid("{733b3d1d-db83-4a83-a6eb-2a85ce96f7bb}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddIntegerParameter("Strat", "S", "Start value.", GH_ParamAccess.list);
            pManager.AddIntegerParameter("End", "E", "End value.", GH_ParamAccess.list);
            pManager.AddBooleanParameter("Reset", "R", "Reset value.", GH_ParamAccess.item);
            pManager.AddBooleanParameter("Auto update or not", "A", "Auto update or not.", GH_ParamAccess.item);
            pManager.AddIntegerParameter("UpdateInterval", "Interval", "Update Interval in milliseconds", GH_ParamAccess.item);
            pManager.AddIntegerParameter("Time scale", "TScale", "To describe from what time to what time, unit hourly.", GH_ParamAccess.list);

        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {

            pManager.AddIntegerParameter("Hour", "H", "value.", GH_ParamAccess.item);
            pManager.AddIntegerParameter("Day", "D", "value.", GH_ParamAccess.item);
            pManager.AddIntegerParameter("Month", "M", "value.", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            var LargeMonths = new HashSet<int> { 1, 3, 5, 7, 8, 10, 12 };
            var LittleMonths = new HashSet<int> { 4, 6, 9, 11 };
            

            bool auto = true;            
            bool reset = false;

            
            int millsec = 1000;

           
            
            //重置
            List<int> startTime=new List<int>();
            List<int> endTime=new List<int>();
            List<int> timeScale = new List<int>();
            
            if (!DA.GetDataList(0, startTime)) { return; }
            if (!DA.GetDataList(1,  endTime)) { return; }
            if (!DA.GetData(2, ref reset)){ return; }
            if (!DA.GetData(3, ref auto)) return;
            DA.GetData(4, ref millsec);
            DA.GetDataList(5,  timeScale);


            if (reset)
            {
                month = startTime[0];
                day = startTime[1];
                time = startTime[2];
                a = 0;
            }
            if (month == endTime[0] && day == endTime[1] && time == endTime[2])
            {
                a = -1;
            }


            if (a == 0)
            {
                if (auto&&!reset)
                {
                    time++;
                    if (time == timeScale[1]+1)
                    {
                        time = timeScale[0] - 1;
                        day++;
                    }
                    else if (LargeMonths.Contains(month) && day == 32)//31天大月
                    {
                        time = timeScale[0] - 1;
                        day = 1;
                        month++;
                    }
                    else if (month == 2 && day == 29)
                    {
                        time = timeScale[0] - 1;
                        day = 1;
                        month++;
                    }
                    else if (LittleMonths.Contains(month) && day == 31)
                    {
                        time = timeScale[0] - 1;
                        day = 1;
                        month++;
                    }
                    
                    this.OnPingDocument().ScheduleSolution(millsec, doc => { this.ExpireSolution(false); });
                   
                }
            }
            DA.SetData(0, time);
            DA.SetData(1, day);
            DA.SetData(2, month);


















        }

      
    }
    }
