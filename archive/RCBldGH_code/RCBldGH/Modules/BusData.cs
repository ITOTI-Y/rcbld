
using System.Collections.Generic;

using RCBldGH.Modules;

namespace RCBldGH.Components
{
    public class BusData
    {
        internal Rhino.Geometry.Plane Plane { get; set; }
        internal Modules.Basics Basics { get; set; }
        internal Modules.DHW Dhw { get; set; }
        internal Modules.Pumps Pumps { get; set; }
        internal Modules.BEM Bem { get; set; }
        internal Modules.Renewable Renewable { get; set; }
        internal Modules.EnergySources EnergySources { get; set; }

        internal List<Modules.Schedule> Itss { get; set; }
        internal List<Modules.Schedule> BuildingUseSchedules { get; set; }
        internal List<Modules.Schedule> MonthlySchedules { get; set; }

        internal List<Modules.Material> ExternalWallMaterials { get; set; }
        internal List<Modules.Material> InternalWallMaterials { get; set; }
        internal List<Modules.Material> WindowMaterials { get; set; }
        internal List<Modules.Material> RoofMaterials { get; set; }
        internal List<Modules.Material> ExternalFloorMaterials { get; set; }
        internal List<Modules.Material> InternalFloorMaterials { get; set; }
        internal List<EnvelopeSetting> Surfaces { get; set; }
        internal List<HVAC> HvacList { get; set; }

        internal List<LightingSetting> LightingSettings { get; set; }
        internal List<Zone> Zones { get; set; }
        internal Modules.CalibrationPara Calibration { get; set; }
    }
    public class Data
    {
        internal Rhino.Geometry.Plane Plane { get; set; }
        internal Modules.Basics Basics { get; set; }
        internal Modules.DHW Dhw { get; set; }
        internal Modules.Pumps Pumps { get; set; }
        internal Modules.BEM Bem { get; set; }
        internal Modules.Renewable Renewable { get; set; }
        internal Modules.EnergySources EnergySources { get; set; }

        internal List<Modules.Schedule> Itss { get; set; }
        internal List<Modules.Schedule> BuildingUseSchedules { get; set; }
        internal List<Modules.Schedule> MonthlySchedules { get; set; }

        internal List<Modules.Material> ExternalWallMaterials { get; set; }
        internal List<Modules.Material> InternalWallMaterials { get; set; }
        internal List<Modules.Material> WindowMaterials { get; set; }
        internal List<Modules.Material> RoofMaterials { get; set; }
        internal List<Modules.Material> ExternalFloorMaterials { get; set; }
        internal List<Modules.Material> InternalFloorMaterials { get; set; }
        internal List<Modules.Material> GroundMaterials { get; set; }
        internal List<RCBldGH.Modules.Envelope> Surfaces { get; set; }
        internal List<HVAC> HvacList { get; set; }

        internal List<LightingSetting> LightingSettings { get; set; }
        internal List<SuperBrep> SuperBreps { get; set; }
    }
}