using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Basics
{
    public class GroundTypeComp:TypeList
    {
        public GroundTypeComp() :
            base(new GH_InstanceDescription("Ground Type", "Type",
                "Ground Type",
                "RCBldGH", "5.Basics"))
        {
        }

        public override Guid ComponentGuid => new Guid("{9085BF54-E139-49DD-B7C5-00446E7BAB51}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.type_gro;
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Clay or silt", GroundType.ClayOrSilt),
            new TypeListItem("Sand or gravel", GroundType.SandOrGravel),
            new TypeListItem("Homogeneous rock", GroundType.HomegeneousRock),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}