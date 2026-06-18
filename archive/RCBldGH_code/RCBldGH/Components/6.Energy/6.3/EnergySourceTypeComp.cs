using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Energy
{
    public class EnergySourceTypeComp:TypeList
    {
        public EnergySourceTypeComp() :
            base(new GH_InstanceDescription("Energy Source type", "Type",
                "Energy Source type",
                "RCBldGH", "6.Energy"))
        {
        }
        public override Guid ComponentGuid => new Guid("{3E4530C8-341A-4B0F-8734-4423E793C453}");
        public override GH_Exposure Exposure => GH_Exposure.tertiary;
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.ES_type;
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("Electricity", EnergySource.Electricity),
            new TypeListItem("Natural gas", EnergySource.NaturalGas),
            new TypeListItem("District cooling", EnergySource.DistrictCooling),
            new TypeListItem("District heating", EnergySource.DistrictHeating),
            new TypeListItem("Steam", EnergySource.Steam),
            new TypeListItem("Gasoline", EnergySource.Gasoline),
            new TypeListItem("Diesel", EnergySource.Diesel),
            new TypeListItem("Coal", EnergySource.Coal),
            new TypeListItem("Fuel oil", EnergySource.FuelOil),
            new TypeListItem("Propane", EnergySource.Propane),
            new TypeListItem("Kerosene", EnergySource.Kerosene),
            new TypeListItem("Traditional bio", EnergySource.TraditionalBio),
            new TypeListItem("Others", EnergySource.Others),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
    }
}