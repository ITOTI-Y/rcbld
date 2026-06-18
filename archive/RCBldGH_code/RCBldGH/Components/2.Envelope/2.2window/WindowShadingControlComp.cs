using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class WindowShadingControlComp: TypeList
    {
        public WindowShadingControlComp() :
            base(new GH_InstanceDescription("Window Shading Control", "Type",
                "Window shading control, to be used with the Window componen",
                "RCBldGH", "2.Envelops"))
        {
        }

        public override GH_Exposure Exposure => GH_Exposure.secondary;
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.windowControl;

        public override Guid ComponentGuid => new Guid("{B8C9FE52-A3CE-43C8-9B21-F83A46DCFD94}");

        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Manual", WindowShadingControl.Manual),
            new TypeListItem("Auto", WindowShadingControl.Auto),
            new TypeListItem("Others", WindowShadingControl.Others),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}