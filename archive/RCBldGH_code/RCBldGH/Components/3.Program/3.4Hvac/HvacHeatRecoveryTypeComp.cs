using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Hvac
{
    public class HvacHeatRecoveryTypeComp: TypeList
    {
        public HvacHeatRecoveryTypeComp() :
            base(new GH_InstanceDescription("Heat Recovery Type", "Type",
                "Heat Recovery Type",
                "RCBldGH", "3.Program"))
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.HAVC_rec;
        public override GH_Exposure Exposure => GH_Exposure.quarternary;
        public override Guid ComponentGuid => new Guid("{DAEA2DD5-0B20-4208-B36D-49E590CAE2D0}");

        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("No heat recovery", HeatRecoveryType.NoHeatRecovery),
            new TypeListItem("Heat change plates or pipes", HeatRecoveryType.HeatChangePlatesOrPipes),
            new TypeListItem("Two-element-system", HeatRecoveryType.TwoElementSystem),
            new TypeListItem("Loading cold with air-conditionin", HeatRecoveryType.LoadingColdWithAirConditioning),
            new TypeListItem("Heat pipes", HeatRecoveryType.HeatPipes),
            new TypeListItem("slow rotating or intermittent heat exchanger", HeatRecoveryType.SlowRotatingOrIntermittentHeatExchanger),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}