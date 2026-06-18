using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class ZoneVentilationTypeComp: TypeList
    {
        public ZoneVentilationTypeComp() :base(new GH_InstanceDescription("Ventilation Type", "Type",
                "Ventilation Type",
                "RCBldGH", "3.Program"))
        {
        }

        public override GH_Exposure Exposure => GH_Exposure.secondary;

        public override Guid ComponentGuid => new Guid("{C7651B5F-7A2C-4930-9ABD-054E35257617}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.type_ven;
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Mechanical", VentilationType.MechanicalVentOnly),
            new TypeListItem("Mixed", VentilationType.MechanicalVentShared),
            new TypeListItem("Natural", VentilationType.NaturalVentOnly),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();
            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));
        }
    }
}