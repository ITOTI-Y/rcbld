using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Hvac
{
    public class HvacExhaustAirRecirculationTypeComp : TypeList
    {
        public HvacExhaustAirRecirculationTypeComp() :
            base(new GH_InstanceDescription("Exhaust Air Recirculation Type", "Type",
                "Exhaust Air Recirculation Type",
                "RCBldGH", "3.Program"))
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.HAVC_ear;
        public override GH_Exposure Exposure => GH_Exposure.quarternary;
        public override Guid ComponentGuid => new Guid("{9AFDD39E-5386-4645-B02E-B4D5C0DF92E9}");

        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("None", ExhaustAirRecirculationType.No),
            new TypeListItem("20%", ExhaustAirRecirculationType.E20P),
            new TypeListItem("40%", ExhaustAirRecirculationType.E40P),
            new TypeListItem("60%", ExhaustAirRecirculationType.E60P),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}