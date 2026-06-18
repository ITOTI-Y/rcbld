using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Domains;

namespace RCBldGH.Components.Renewable
{
    public class OrientationComp:TypeList
    {
        public OrientationComp() :
            base(new GH_InstanceDescription("Orientation", "Orientation",
                "Orientation",
                "RCBldGH", "6.Energy"))
        {
        }

        public override Guid ComponentGuid => new Guid("{9CABBFCF-C8F3-49AA-A7BD-7B290DE7212D}");
        public override GH_Exposure Exposure => GH_Exposure.quinary;
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.type_ori;

        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("E", Orientation.E),
            new TypeListItem("S", Orientation.S),
            new TypeListItem("W", Orientation.W),
            new TypeListItem("N", Orientation.N),
            new TypeListItem("NE", Orientation.NE),
            new TypeListItem("SE", Orientation.SE),
            new TypeListItem("NW", Orientation.NW),
            new TypeListItem("SW", Orientation.SW),

        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}