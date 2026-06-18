using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class WindowShadingWhereComp:TypeList
    {
        public WindowShadingWhereComp() :
            base(new GH_InstanceDescription("Window Shading Where", "Type",
                "Window shading where. Inside: internal shading, Outside: external shading, to be used with the Window componen",
                "RCBldGH", "2.Envelops"))
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.secondary;
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.windowPosition;
        public override Guid ComponentGuid => new Guid("{66BB4153-96A3-4897-AE1A-A582164A9BC8}");

        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Inside", Modules.WindowShadingWhere.Inside),
            new TypeListItem("Outside", WindowShadingWhere.Outside),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}