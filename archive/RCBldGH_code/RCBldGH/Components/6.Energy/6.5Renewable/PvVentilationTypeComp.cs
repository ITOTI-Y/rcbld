using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Domains;
using RCBldGH.Modules;

namespace RCBldGH.Components.Renewable
{
    public class PvVentilationTypeComp : TypeList
    {
        public PvVentilationTypeComp() :
            base(new GH_InstanceDescription("Ventilation Type", "Type",
                "Ventilation Type",
                "RCBldGH", "6.Energy"))
        {
        }

        public override Guid ComponentGuid => new Guid("{338E069E-1320-4840-A94F-5123703ED466}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.type_pvv;
        public override GH_Exposure Exposure => GH_Exposure.senary;
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Unventilated modules", PvVentilationType.Unventilated),
            new TypeListItem("Moderately ventilated modules", PvVentilationType.ModeratelyVentilated),
            new TypeListItem("Strongly ventilated modules", PvVentilationType.StronglyVentilated),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}