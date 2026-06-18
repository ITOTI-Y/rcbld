using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;

namespace RCBldGH.Components.Dhw
{
    public class DhwGenerationSystemComp:TypeList
    {
        public DhwGenerationSystemComp() :
            base(new GH_InstanceDescription("DHW Generation System", "Type",
                "DHW Generation System",
                "RCBldGH", "6.Energy"))
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.DHW_type;
        public override GH_Exposure Exposure => GH_Exposure.primary;
        public override Guid ComponentGuid => new Guid("{F3819418-E1E6-4625-B4D2-BDE067AB9DB8}");

        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Electric generation", Modules.DhwGenerationSystem.ElectricGeneration),
            new TypeListItem("VR-boiler", Modules.DhwGenerationSystem.VrBoiler),
            new TypeListItem("Gas_boiler or HR-boiler", Modules.DhwGenerationSystem.GasOrHrBoiler),
            new TypeListItem("Co-generation", Modules.DhwGenerationSystem.CoGeneration),
            new TypeListItem("District heating", Modules.DhwGenerationSystem.DistrictHeating),
            new TypeListItem("Heat pump", Modules.DhwGenerationSystem.HeatPump),
            new TypeListItem("Steam", Modules.DhwGenerationSystem.Steam),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}