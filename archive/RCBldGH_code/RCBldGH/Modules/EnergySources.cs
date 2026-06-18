namespace RCBldGH.Modules
{
    public enum EnergySource
    {
        Electricity = 1,
        NaturalGas = 2,
        DistrictCooling = 3,
        DistrictHeating = 4,
        Steam = 5,
        Gasoline = 6,
        Diesel = 7,
        Coal = 8,
        FuelOil = 9,
        Propane = 10,
        Kerosene = 11,
        TraditionalBio = 12,
        Others = 13
    }

    public class EnergySources
    {
        private const string Br = "\r\n";
        public EnergySource HeatingEnergySource { get; set; }
        public EnergySource CoolingEnergySource { get; set; }
        public EnergySource DhwEnergySource { get; set; }

        public string ToCen()
        {
            string result = "$Energy Sources:" + Br + Br;
            result +=
                $"Heating Energy Source: {(int) HeatingEnergySource} \t!!! 1: 'electricity', 2:'natural gas', 3: 'district cooling', 4: 'district heating', 5: 'steam', 6: 'gasoline', 7: 'diesel', 8: 'coal', 9: 'fuel oil' , 10: 'propane', 11: 'kerosene', 12: 'traditional bio' , 13: 'others'" +
                Br;
            result +=
                $"Cooling Energy Source: {(int) CoolingEnergySource} \t!!! 1: 'electricity', 2:'natural gas', 3: 'district cooling', 4: 'district heating', 5: 'steam', 6: 'gasoline', 7: 'diesel', 8: 'coal', 9: 'fuel oil' , 10: 'propane', 11: 'kerosene', 12: 'traditional bio' , 13: 'others'" +
                Br;
            result +=
                $"DHW Energy Source: {(int) DhwEnergySource} \t!!! 1: 'electricity', 2:'natural gas', 3: 'district cooling', 4: 'district heating', 5: 'steam', 6: 'gasoline', 7: 'diesel', 8: 'coal', 9: 'fuel oil' , 10: 'propane', 11: 'kerosene', 12: 'traditional bio' , 13: 'others'" +
                Br;
            return result;
        }

        public override string ToString()
        {
            return "Energy Sources";
        }
    }
}