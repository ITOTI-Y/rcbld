using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Pumps
{
    public class PumpControlTypeComp:TypeList
    {
        public PumpControlTypeComp() :
            base(new GH_InstanceDescription("Pump Control Type", "Type",
                "Pump Control Type",
                "RCBldGH", "6.Energy"))
        {
        }

        public override Guid ComponentGuid => new Guid("{516B6170-D152-4616-9CB1-B54218E912AE}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.pump_type;
        public override GH_Exposure Exposure => GH_Exposure.secondary;
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("No pump used", PumpControlType.NoPumpUsed),
            new TypeListItem("Automatic control more than 50%", PumpControlType.AutoControlMoreThanHalf),
            new TypeListItem("All other case", PumpControlType.Other),

        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}