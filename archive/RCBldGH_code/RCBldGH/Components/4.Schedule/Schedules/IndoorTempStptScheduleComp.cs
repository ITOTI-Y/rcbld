using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Rhino.Geometry;
using RCBldGH.Domains;
using RCBldGH.Modules;
using RCBldGH.Modules.Schedules;
using RCBldGH.Utils;

namespace RCBldGH.Components.Schedules
{
    public class IndoorTempStptScheduleComp:GH_Component
    {
        public IndoorTempStptScheduleComp()
            : base("Indoor Temperature Stpt Schedule", "ITSS",
                "Indoor Temperature Stpt Schedule.",
                "RCBldGH", "4.Schedules")
        {
        }

        public override Guid ComponentGuid => new Guid("{035D28E5-1727-4A51-B282-9A8427953E1F}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.Schedule_itss_d;
        public override GH_Exposure Exposure => GH_Exposure.tertiary;

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Schedule Name", "N", "Schedule Name", GH_ParamAccess.item);
            pManager.AddNumberParameter("WD Tset Heat", "WD_H", "Weekday heating stpt schedule", GH_ParamAccess.list);
            pManager.AddNumberParameter("WE Tset Heat", "WE_H", "Weekend heating stpt schedule", GH_ParamAccess.list);
            pManager.AddNumberParameter("WD Tset Cool", "WD_C", "Weekday cooling stpt schedule", GH_ParamAccess.list);
            pManager.AddNumberParameter("WE Tset Cool", "WE_C", "Weekend cooling stpt schedule", GH_ParamAccess.list);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Schedule", "S", "Indoor Temperature Setpoint Schedule", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Building Use Schedule Text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;
            List<double> dayH = new List<double>();
            List<double> dayC = new List<double>();
            List<double> endH = new List<double>();
            List<double> endC = new List<double>();
            if (!DA.GetData(0, ref name) || 
                !DA.GetDataList(1, dayH) || !DA.GetDataList(2, endH) ||
                !DA.GetDataList(3, dayC) || !DA.GetDataList(4, endC))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error,
                    "Failed to obtain one or more data.");
                return;
            }

            if (!IsBetween10To32(dayH) || !IsBetween10To32(endH) ||
                !IsBetween10To32(dayC) || !IsBetween10To32(endC))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Schedule value must be between 10 and 32.");
            }

            List<List<double>> dataListList = new List<List<double>>
            {
                dayH,endH,dayC,endC
            };
            List<TimespanDataPair> dataPairList = new List<TimespanDataPair>();
            bool isSuccess = TimespanTools.DoubleListToTimespanDataPairs(dataListList, 24, out dataPairList);

            if (!isSuccess)
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error,
                    "The number of input schedule data must be 24.");
                return;
            }

            Schedule schedule = new Schedule
            {
                ScheduleType = ScheduleType.Basic,
                Name = name,
                DataDetails = dataPairList
            };
            DA.SetData(0, schedule);
            DA.SetData(1, schedule.ToCen());
        }

        internal bool IsBetween10To32(List<double> data)
        {
            bool result = true;
            foreach (double d in data)
            {
                if (d < 10 || d > 32)
                {
                    result = false;
                    break;
                }
            }

            return result;
        }
    }
}