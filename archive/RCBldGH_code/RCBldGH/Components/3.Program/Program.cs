using System;
using System.Collections.Generic;
using System.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Geometry;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class ProgramComp : GH_Component
    {
        public ProgramComp()
            : base("ZoneProgram", "P", "ZoneProgram to be used with the ZoneCreator component.", "RCBldGH", "3.Program")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.primary;
        public override Guid ComponentGuid => new Guid("{05dbd7bc-a9e4-43af-8f9c-af5604045d11}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.zone_program;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {            
            pManager.AddNumberParameter("Occupancy Rate", "OR", "Unit: m2/person.", GH_ParamAccess.item);
            pManager.AddNumberParameter("Metabolic Rate", "MR", "Unit: W/person.", GH_ParamAccess.item);
            pManager.AddNumberParameter("Appliance Intensity", "A", "Unit: W/m2.", GH_ParamAccess.item);            
            pManager.AddNumberParameter("Outdoor Air Rate", "OAR",
                "Outdoor Air(liter/s/person).If ignored, then minimum outdoor air default will be used", GH_ParamAccess.item);
            pManager.AddNumberParameter("Air Infiltration Rate", "AIR",
                "Air Infiltration Rate. Leave blank if air infiltration level is used, unit: /h air change rate at Q4Pa",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("Window Area Open Percentage", "WP",
                "Window Area Open Percentage. If natural ventilation is used, specify the opened area percentage of total window area, unit: %",
                GH_ParamAccess.item);
            pManager.AddAngleParameter("Angle of Opening", "AO",
                "Unit: degree. If natural ventilation is used, specify the angle of opening for bottom hung windows",GH_ParamAccess.item);
            pManager.AddGenericParameter("Air Infiltration Level", "AIL", "specify a predefined lighting system.",GH_ParamAccess.item);
            pManager.AddGenericParameter("Ventilation Type", "V",
                "Ventilation Type,Note: zones that don't have external structures can't apply natural ventilation.",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("DHW", "DHW", "DHW. unit: liter/m2/month", GH_ParamAccess.item);   
            pManager.AddBooleanParameter("Night Flushing", "NF", "Night Flushing", GH_ParamAccess.item);            
            pManager.AddGenericParameter("Lighting Template", "L", "Specify a predefined lighting system.",GH_ParamAccess.item);
            pManager.AddGenericParameter("HAVC Template", "HAVC", "Specify a predefined HVAC system",GH_ParamAccess.item);
            

            for (int i = 0; i < pManager.ParamCount; i++)
            {
                pManager[i].Optional = true;
            }
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
           pManager.AddGenericParameter("Program", "P", "Building usage conditions for a zone", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            RCBldGH.Modules.Program program = new RCBldGH.Modules.Program();
            double occupancy = 0;
            if (DA.GetData("Occupancy Rate", ref occupancy))
            {
                program.Occupancy = occupancy;
            }

            // 获取 Metabolic Rate
            double metabolic = 0;
            if (DA.GetData("Metabolic Rate", ref metabolic))
            {
                program.MetabolicRate = metabolic;
            }

            // 获取 Appliance Intensity
            double appliance = 0;
            if (DA.GetData("Appliance Intensity", ref appliance))
            {
                program.Appliance = appliance;
            }

            // 获取 Lighting Template
            object lightingObj = null;
            if (DA.GetData("Lighting Template", ref lightingObj))
            {
                try
                {
                    LightingSetting lighting = (LightingSetting) ((GH_ObjectWrapper) lightingObj).Value;
                    program.LightingTemplate = lighting;
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Lighting Template is Invalid.");
                }
            }

            // 获取 Outdoor Air Rate
            double outdoorAirRate = 0;
            if (DA.GetData("Outdoor Air Rate", ref outdoorAirRate))
            {
                program.OutdoorAir = outdoorAirRate;
            }

            // 获取 Air Infiltration Rate
            double airInfiltrationRate = double.NaN;
            if (DA.GetData("Air Infiltration Rate", ref airInfiltrationRate))
            {
                program.AirInfiltrationRate = airInfiltrationRate;
            }

            // 获取 Air Infiltration Level
            object levelObj = null;
            if (DA.GetData("Air Infiltration Level", ref levelObj))
            {
                try
                {
                    AirInfiltrationLevel level = (AirInfiltrationLevel) ((GH_ObjectWrapper) levelObj).Value;
                    program.AirInfiltrationLevel = level;
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Air Infiltration Level is Invalid.");
                }
            }

            if (!double.IsNaN(airInfiltrationRate) && levelObj!=null)
            {
                program.AirInfiltrationRate = double.NaN;
                AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Air Infiltration Level and Air Infiltration Rate cannot coexist, Air Infiltration Rate has been ignored");
            }

           

            // 获取 Ventilation Type
            object ventilationObj = null;
            if (DA.GetData("Ventilation Type", ref ventilationObj))
            {
                try
                {
                    VentilationType ventilationType = (VentilationType) ((GH_ObjectWrapper)ventilationObj).Value;
                    program.VentilationType = ventilationType;
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Ventilation Type is Invalid.");
                }
            }

            // 获取 Night Flushing
            bool nf = false;
            if (DA.GetData("Night Flushing", ref nf))
            {
                program.NightFlushing = nf;
            }

            // 获取 Window Area Open Percentage
            double waop = 0;
            if (DA.GetData("Window Area Open Percentage", ref waop))
            {
                if (waop < 0 || waop > 100)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning,
                        "The Window Area Open Percentage must be between 0 and 100.");
                }
                else
                {
                    program.WindowAreaOpenPercentage = waop;
                }
            }
            // 获取 Angle of Opening
            double angeleOfOpening = 0;
            if (DA.GetData("Angle of Opening",ref angeleOfOpening))
            {
                program.AngleOfOpening = angeleOfOpening;
            }
            // 获取 DHW
            double dhw = 0;
            if (DA.GetData("DHW",ref dhw))
            {
                program.DHW = dhw;
            }
           
            // 获取 HAVC Template
            object hvacObj = null;
            if (DA.GetData("HAVC Template",ref hvacObj))
            {
                try
                {
                    HVAC hvac = (HVAC) ((GH_ObjectWrapper) hvacObj).Value;
                    program.HvacTemplate = hvac;
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The HAVC Template is Invalid.");
                }
            }
            // 输出 Zone 
            var result = program;
            DA.SetData(0, result);            
        }      
    }
}