using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules.Schedules;
using RCBldGH.Utils;

namespace RCBldGH.Components.Schedules
{
    public class DayScheduleComp:GH_Component
    {        
        DayScheduleComp()
            : base("Day schedule", "DaySchedule",
                "Each timespan corresponds to a single data. The number of data must be the same as the number of timespans.",
                "RCBldGH", "4.Schedules")
        {
        }

        public override Guid ComponentGuid => new Guid("{C84D6EE8-794C-4638-992F-798C09245725}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddIntervalParameter("TimeSpans", "T", "Time spans(Hours)", GH_ParamAccess.list);
            pManager.AddNumberParameter("Data", "D",
                "Data list. Each data corresponds to a timespan. ",
                GH_ParamAccess.list);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Day Schedule", "S", "Day Schedule", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            List<Interval> timespans = new List<Interval>();
            List<double> dataList = new List<double>();
            if (DA.GetDataList(0, timespans)&& DA.GetDataList(1,dataList) && timespans.Count > 0 && timespans.Count>0)
            {
                DaySchedule schedule = new DaySchedule(timespans,dataList);

                if (!schedule.IsValid)
                {
                    this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, schedule.ErrorMessage);
                    return;
                }

                DA.SetData(0, schedule);
            }
        }
    }
}