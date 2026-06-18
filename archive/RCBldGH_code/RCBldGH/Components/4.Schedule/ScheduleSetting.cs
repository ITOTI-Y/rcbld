using System;
using System.Collections.Generic;
using System.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Geometry;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules;
using static RCBldGH.Modules.Schedule;

namespace RCBldGH.Components.Envelope
{
    public class ScheduleSettingComp : GH_Component
    {
        public ScheduleSettingComp()
            : base("ScheduleSetting", "S", "ScheduleSetting to be used with the ZoneCreator component.", "RCBldGH", "4.Schedules")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.primary;
        public override Guid ComponentGuid => new Guid("{de0a5500-9e51-47bd-ab8f-4037b2c0ac4f}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.zone_schedule;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {  
            pManager.AddGenericParameter("Air Infiltration Schedule", "AIS",
                "Specify a predefined monthly air infiltration schedule", GH_ParamAccess.item); 
            pManager.AddGenericParameter("Monthly ITSS", "ITSS",
                "Specify a predefined indoor temperature setpoint schedule.",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("Monthly BUS", "BUS", "Specify a predefined building use schedule.",GH_ParamAccess.item);
            
            for (int i = 0; i < pManager.ParamCount; i++)
            {
                pManager[i].Optional = true;
            }
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
           pManager.AddGenericParameter("ScheduleSetting", "S", "ScheduleSetting to be used with the ZoneCreator component.", GH_ParamAccess.item);
        }

        

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            ScheduleSetting scheduleSetting = new ScheduleSetting();
            object airSchedule = null;
            if (DA.GetData("Air Infiltration Schedule", ref airSchedule))
            {
                try
                {
                    Schedule schedule = (Schedule) ((GH_ObjectWrapper)airSchedule).Value;
                    if (schedule.ScheduleType != ScheduleType.MonthlyCoefficient)
                    {
                        AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Air Infiltration Schedule is Invalid.");
                    }
                    else
                    {
                        scheduleSetting.AirInfiltrationSchedule = schedule;
                    }

                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Air Infiltration Schedule is Invalid.");
                }
            }

            
           
            object itss = null;
            if (DA.GetData("Monthly ITSS", ref itss))
            {
                try
                {
                    Schedule schedule = (Schedule)((GH_ObjectWrapper)itss).Value;
                    if (schedule.ScheduleType != ScheduleType.MonthlyItss)
                    {
                        AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Monthly ITSS is Invalid.");
                    }
                    else
                    {
                        scheduleSetting.IndoorTemperatureSetPointSchedule = schedule;
                    }

                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Monthly ITSS is Invalid.");
                }
            }
            // 获取 Monthly BUS
            object bus = null;
            if (DA.GetData("Monthly BUS", ref bus))
            {
                try
                {
                    Schedule schedule = (Schedule)((GH_ObjectWrapper)bus).Value;
                    if (schedule.ScheduleType != ScheduleType.MonthlyBus)
                    {
                        AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Monthly BUS is Invalid.");
                    }
                    else
                    {
                        scheduleSetting.BuildingUseSchedule = schedule;
                    }
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Monthly BUS is Invalid.");
                }
            }

            
            // 输出 Zone 
            var result = scheduleSetting;
            DA.SetData(0, result);            
        }      
    }
}