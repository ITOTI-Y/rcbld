using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Basics
{
    public class TerrainClassComp:TypeList
    {
        public TerrainClassComp() :
            base(new GH_InstanceDescription("Terrain Class", "Type",
                "Terrain Class",
                "RCBldGH", "5.Basics"))
        {
        }

        public override Guid ComponentGuid => new Guid("{D49A2DB0-954C-4CCF-A46C-67BB3BC0A4D5}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.type_ter;
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Open terrain", TerrainClass.OpenTerrain),
            new TypeListItem("Country", TerrainClass.Country),
            new TypeListItem("Urban/City", TerrainClass.UrbanCity),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}