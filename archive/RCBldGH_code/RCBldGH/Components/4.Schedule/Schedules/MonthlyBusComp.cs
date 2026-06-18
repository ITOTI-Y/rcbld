using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Domains;
using RCBldGH.Modules;

namespace RCBldGH.Components.Schedules
{
    public class MonthlyBusComp:GH_Component
    {
        public MonthlyBusComp()
            : base("Monthly BUS", "MonthlyBUS",
                "Monthly Building Use Schedule. ",
                "RCBldGH", "4.Schedules")
        {
        }

        public override Guid ComponentGuid => new Guid("{087E071D-5263-47FB-89B8-72E4330E420E}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.Schedule_bus;
        public override GH_Exposure Exposure => GH_Exposure.secondary;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Schedule Name", "N", "Schedule Name", GH_ParamAccess.item);
            pManager.AddIntervalParameter("Timespans", "T", "Timespans", GH_ParamAccess.list);
            pManager.AddGenericParameter("Building Use Schedules", "BUS", "Specify the Building Use Schedule for each month.", GH_ParamAccess.list);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Schedule", "S", "Monthly Building Use Schedule", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Building Use Schedule Text", GH_ParamAccess.item);
        }

       

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;
            List<Interval> timespans = new List<Interval>();
            List<object> scheduleList = new List<object>();

            if (!DA.GetData(0, ref name) || !DA.GetDataList(1, timespans) ||
                !DA.GetDataList(2, scheduleList))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error,
                    "Failed to obtain one or more data.");
                return;
            }

            if (timespans.Count != scheduleList.Count)
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error,
                    "The number of timespans does not match the number of data.");
                return;
            }

            List<TimespanSchedulePair> relatedSchedules = new List<TimespanSchedulePair>();
            for (int i = 0; i < timespans.Count; i++)
            {
                Schedule relatedSchedule = (Schedule)((GH_ObjectWrapper)scheduleList[i]).Value;
                if (relatedSchedule.ScheduleType!=ScheduleType.BuildingUse)
                {
                    this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "At least one schedule is not Building Use Schedule.");
                    return;
                }
                TimespanSchedulePair dataPair = new TimespanSchedulePair
                {
                    TimeSpan = timespans[i],
                    RelatedSchedule = relatedSchedule
                };
                relatedSchedules.Add(dataPair);
            }

            Schedule schedule = new Schedule
            {
                ScheduleType = ScheduleType.MonthlyBus,
                Name = name,
                RelatedSchedules = relatedSchedules,
            };
            DA.SetData(0, schedule);
            DA.SetData(1, schedule.ToCen());
        }
    }
}