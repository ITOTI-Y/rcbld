using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class WindowShadingTypeComp : TypeList
    {
        public WindowShadingTypeComp() :
            base(new GH_InstanceDescription("Window shading type", "Type",
                "Window shading type, to be used with the Window componen",
                "RCBldGH", "2.Envelops"))
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.secondary;
        public override Guid ComponentGuid => new Guid("{0D95DFB7-BA0B-4CF5-B579-97DD43E5F61E}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.windowType;
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("White blinds", WindowShadingType.WhiteBlinds),
            new TypeListItem("White curtains", WindowShadingType.WhiteCurtains),
            new TypeListItem("Colored textures", WindowShadingType.ColoredTextures),
            new TypeListItem("Aluminum-coated texture", WindowShadingType.AluminumCoatedTexture)
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}