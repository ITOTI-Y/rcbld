using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class ZoneAirInfiltrationLevelComp: TypeList
    {
        public ZoneAirInfiltrationLevelComp() :
            base(new GH_InstanceDescription("Air Infiltration Level", "Type",
                "Air Infiltration Level",
                "RCBldGH", "3.Program"))
        {
        }

        public override GH_Exposure Exposure => GH_Exposure.secondary;

        public override Guid ComponentGuid => new Guid("{313D1FDB-E74C-4B46-9CD5-7E2D5CAFAE33}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.type_air;
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Low", AirInfiltrationLevel.Low),
            new TypeListItem("Medium", AirInfiltrationLevel.Medium),
            new TypeListItem("High", AirInfiltrationLevel.High),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}