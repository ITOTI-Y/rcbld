using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Basics
{
    public class BuildingTypeComp:TypeList
    {
        public BuildingTypeComp() :
            base(new GH_InstanceDescription("Building Type", "Type",
                "Building Type",
                "RCBldGH", "5.Basics"))
        {
        }

        public override Guid ComponentGuid => new Guid("{D725AEFF-53E8-459A-AD35-9B5A2B9AC936}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.type_bld;
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Residential", BuildingType.Residential),
            new TypeListItem("Commercial", BuildingType.Commercial),
            new TypeListItem("Industrial", BuildingType.Industrial),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}