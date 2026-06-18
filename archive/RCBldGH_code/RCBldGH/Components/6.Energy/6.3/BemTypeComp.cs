using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Energy
{
    public class BemTypeComp:TypeList
    {
        public BemTypeComp() :
            base(new GH_InstanceDescription("BEM Type", "BEM Type",
                "BEM Type, 1. Class D: No building automation function,  2. Class C: adapting the operation of the building and technical systems to users needs, 3. Class B: optimizing the operation by the tuning of the different controllers and standard alarming and monitoring functions, 4. Class A: detecting faults of building and technical systems and providing support to the diagnosis of these faults, Reporting information regarding energy consumption, indoor conditions, and possibilities for improvement.",
                "RCBldGH", "6.Energy"))
        {
        }
        public override Guid ComponentGuid => new Guid("{3FEA6F93-9005-4399-9F63-B78A3DEA4361}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.Bem_type;
        public override GH_Exposure Exposure => GH_Exposure.quarternary;
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Class D", BemType.D),
            new TypeListItem("Class C", BemType.C),
            new TypeListItem("Class B", BemType.B),
            new TypeListItem("Class A", BemType.A),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}