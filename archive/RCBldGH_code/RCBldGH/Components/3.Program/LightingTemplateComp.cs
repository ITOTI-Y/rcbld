using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Rhino.Geometry;
using RCBldGH.Domains;
using RCBldGH.Modules;

namespace RCBldGH.Components
{
    public class LightingTemplateComp:GH_Component
    {
        public LightingTemplateComp()
            : base("Lighting Templates", "LightingTemplates",
                "Lighting Templates.",
                "RCBldGH", "3.Program")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.lighting_setting;
        public override GH_Exposure Exposure => GH_Exposure.tertiary;
        public override Guid ComponentGuid => new Guid("{5FA208A4-C429-4EBA-9196-2403AB5D4D99}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Lighting Name", "N", "Lighting template name", GH_ParamAccess.item);
            pManager.AddNumberParameter("Lighting Load", "L", "Lighting Load. unit: W/m2", GH_ParamAccess.item);
            pManager.AddNumberParameter("Parasitic Lighting Energy", "E", "Parasitic Lighting Energy. unit: kWh/m2/yr", GH_ParamAccess.item);
            pManager.AddNumberParameter("Daylighting Factor", "DF", "Daylighting Factor. No Control: 1, Range (0=< factor =<1)", GH_ParamAccess.item);
            pManager.AddNumberParameter("Lighting Occupancy Factor", "OF", "Lighting Occupancy Factor. No Control: 1, Range (0=< factor =<1)", GH_ParamAccess.item);
            pManager.AddNumberParameter("Lighting Illumination Control Factor", "ICF", "Lighting Illumination Control Factor. No Control: 1, Range (0=< factor =<1)", GH_ParamAccess.item);
            pManager[2].Optional = true;
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Lighting Setting", "S", "Lighting Setting", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Lighting Template text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;
            double load = double.NaN;
            double energy = double.NaN;
            double daylightingFactor = double.NaN;
            double occupancyFactor = double.NaN;
            double illuminationFactor = double.NaN;


            if (!DA.GetData(0, ref name) || !DA.GetData(1, ref load) || !DA.GetData(3, ref daylightingFactor)
                || !DA.GetData(4, ref occupancyFactor) || !DA.GetData(5, ref illuminationFactor)
            )
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error,
                    "Failed to obtain one or more data.");
                return;
            }

            LightingSetting setting = new LightingSetting
            {
                LightingName = name,
                DayLightingFactor = daylightingFactor,
                LightingIlluminationControlFactor = illuminationFactor,
                LightingLoad = load,
                LightingOccupancyFactor = occupancyFactor
            };

            if (DA.GetData(2,ref energy)|| !double.IsNaN(energy))
            {
                setting.ParasiticLightingEnergy = energy;
            }
            DA.SetData(0, setting);
            DA.SetData(1, setting.ToCen());
        }
    }
}