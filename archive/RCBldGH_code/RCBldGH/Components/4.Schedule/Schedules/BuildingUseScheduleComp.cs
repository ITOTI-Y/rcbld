using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Rhino.Geometry;
using RCBldGH.Domains;
using RCBldGH.Modules;
using RCBldGH.Utils;

namespace RCBldGH.Components.Schedules
{
    public class BuildingUseScheduleComp:GH_Component
    {
        public BuildingUseScheduleComp()
            : base("Building Use Schedule", "BudingUseSchedule",
                "Building Use Schedule.",
                "RCBldGH", "4.Schedules")
        {
        }

        public override Guid ComponentGuid => new Guid("{36AA52B9-E0C2-4509-9F96-2B9C9899C88E}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.Schedule_bus_d;
        public override GH_Exposure Exposure => GH_Exposure.tertiary;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Schedule Name", "N", "Schedule Name", GH_ParamAccess.item);
            pManager.AddNumberParameter("Occ_WD", "OD", "Weekday occupancy schedule, value must be between 0 and 1.", GH_ParamAccess.list);
            pManager.AddNumberParameter("Occ_WE", "OE", "Weekend occupancy schedule, value must be between 0 and 1.", GH_ParamAccess.list);
            pManager.AddNumberParameter("App_WD", "AD", "Weekday appliance schedule, value must be between 0 and 1.", GH_ParamAccess.list);
            pManager.AddNumberParameter("App_WE", "AE", "Weekend appliance schedule, value must be between 0 and 1.", GH_ParamAccess.list);
            pManager.AddNumberParameter("Light_WD", "LD", "Weekday lighting schedule, value must be between 0 and 1.", GH_ParamAccess.list);
            pManager.AddNumberParameter("Light_WE", "LE", "Weekend lighting schedule, value must be between 0 and 1.", GH_ParamAccess.list);
            pManager.AddNumberParameter("HVAC_WD", "HD", "Weekday HVAC schedule, value must be between 0 and 1.", GH_ParamAccess.list);
            pManager.AddNumberParameter("HVAC_WE", "HE", "Weekend HVAC schedule, value must be between 0 and 1.", GH_ParamAccess.list);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Schedule", "S", "Building Use Schedule", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Building Use Schedule Text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;
            List<double> occWdList = new List<double>();
            List<double> occWeList = new List<double>();
            List<double> appWdList = new List<double>();
            List<double> appWeList = new List<double>();
            List<double> lightWdList = new List<double>();
            List<double> lightWeList = new List<double>();
            List<double> hvacWdList = new List<double>();
            List<double> hvacWeList = new List<double>();

            if (!DA.GetData(0, ref name) || 
                !DA.GetDataList(1, occWdList) || !DA.GetDataList(2, occWeList) ||
                !DA.GetDataList(3, appWdList) || !DA.GetDataList(4, appWeList) ||
                !DA.GetDataList(5, lightWdList) || !DA.GetDataList(6, lightWeList) ||
                !DA.GetDataList(7, hvacWdList) || !DA.GetDataList(8, hvacWeList) 
                )
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error,
                    "Failed to obtain one or more data.");
                return;
            }

            if (!IsBetween0To1(occWdList)||!IsBetween0To1(occWeList)||
                !IsBetween0To1(appWdList)||!IsBetween0To1(appWeList)||
                !IsBetween0To1(lightWdList)||!IsBetween0To1(lightWeList)||
                !IsBetween0To1(hvacWdList)||!IsBetween0To1(hvacWeList))
            {
             AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Schedule value must be between 0 and 1.");   
            }

            List<double> inflWdList = new List<double>{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
            List<double> inflWeList = new List<double>{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};

            List<List<double>> dataListList = new List<List<double>>
            {
                occWdList,
                occWeList,
                appWdList,
                appWeList,
                lightWdList,
                lightWeList,
                hvacWdList,
                hvacWeList,
                inflWdList,
                inflWeList
            };
            List<TimespanDataPair> dataPairList = new List<TimespanDataPair>();
            bool isSuccess=TimespanTools.DoubleListToTimespanDataPairs(dataListList, 24, out dataPairList);

            if (!isSuccess)
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error,
                    "The number of input schedule data must be 24.");
                return;
            }

            Schedule schedule = new Schedule
            {
                ScheduleType = ScheduleType.BuildingUse,
                Name = name,
                DataDetails = dataPairList
            };
            DA.SetData(0, schedule);
            DA.SetData(1, schedule.ToCen());
        }

        internal bool IsBetween0To1(List<double> data)
        {
            bool result = true;
            foreach (double d in data)
            {
                if (d<0||d>1)
                {
                    result = false;
                    break;
                }
            }

            return result;
        }
    }
}