using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Rhino.Geometry;
using RCBldGH.Domains;
using RCBldGH.Modules;
using RCBldGH.Utils;

namespace RCBldGH.Components.Schedules
{
    public class AirInfiltrationScheduleComp:GH_Component
    {
        public AirInfiltrationScheduleComp()
            : base("Infiltration Monthly Schedule", "InfiltrationMonthlySchedule",
                "Air Infiltration Monthly Schedule. ",
                "RCBldGH", "4.Schedules")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.Schedule_infi;
        public override GH_Exposure Exposure => GH_Exposure.secondary;

        public override Guid ComponentGuid => new Guid("{7B5C9DC4-CF75-47FE-97CC-5B7E1D782235}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Schedule Name", "N", "Schedule Name", GH_ParamAccess.item);
            pManager.AddNumberParameter("Coefficient", "C", "Specify the coefficient of air infiltration for each month.", GH_ParamAccess.list);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Schedule", "S", "Air Infiltration Schedule", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Building Use Schedule Text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;
            List<double> numList = new List<double>();

            if (!DA.GetData(0, ref name) || !DA.GetDataList(1, numList))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error,
                    "Failed to obtain one or more data.");
                return;
            }

            List<List<double>> dataListList = new List<List<double>>
            {
                numList,
            };
            List<TimespanDataPair> dataPairList = new List<TimespanDataPair>();
            bool isSuccess = TimespanTools.DoubleListToTimespanDataPairs(dataListList, 12, out dataPairList);

            if (!isSuccess)
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error,
                    "The number of input schedule data must be 12.");
                return;
            }

            Schedule schedule = new Schedule
            {
                ScheduleType = ScheduleType.MonthlyCoefficient,
                Name = name,
                DataDetails = dataPairList
            };
            DA.SetData(0, schedule);
            DA.SetData(1, schedule.ToCen());
        }
    }
}