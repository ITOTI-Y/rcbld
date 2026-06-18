using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Renewable
{
    public class PvTypeComp:TypeList
    {
        public PvTypeComp() :
            base(new GH_InstanceDescription("PV Type", "Type",
                "PV Type",
                "RCBldGH", "6.Energy"))
        {
        }

        public override Guid ComponentGuid => new Guid("{0707B09E-2A21-415F-9CFF-8773585EFD12}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.type_pv;
        public override GH_Exposure Exposure => GH_Exposure.senary;
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Mono crystalline silicona", PvType.MonoCrystalline),
            new TypeListItem("Multi crystalline silicona", PvType.MultiCrystalline),
            new TypeListItem("Thin film amorphous silicon", PvType.ThinFilmAmorphous),
            new TypeListItem("Other thin film layers", PvType.OtherThinFilmLayers),
            new TypeListItem("Thin film copper-indium-gallium-diselenide", PvType.ThinFilmCopperIndiumGalliumDiselenide),
            new TypeListItem("Thin film cadmium-telloride", PvType.ThinFilmCadmiumTelloride),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}