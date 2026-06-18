using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Dhw
{
    public class DhwDistributionSystemComp : TypeList
    {
        public DhwDistributionSystemComp() :
            base(new GH_InstanceDescription("DHW Distribution System", "Type",
                "DHW Distribution System",
                "RCBldGH", "6.Energy"))
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.DHW_form;
        public override GH_Exposure Exposure => GH_Exposure.primary;
        public override Guid ComponentGuid => new Guid("{2BA5BFB5-CE49-499A-BA0F-4F2B39A14851}");

        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Taps within 3m from heat generation", DhwDistributionSystem.TapsWithin3M),
            new TypeListItem("Taps more than 3m from heat generation", DhwDistributionSystem.TapsMoreThan3M),
            new TypeListItem("Circulation system or unknown", DhwDistributionSystem.CirculationSysOrUnknown),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}