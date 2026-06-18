using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.AccessControl;
using RCBldGH.Domains;
using RCBldGH.Utils;

namespace RCBldGH.Modules
{
    public enum HeatRecoveryType
    {
        NoHeatRecovery = 1,
        HeatChangePlatesOrPipes = 2,
        TwoElementSystem = 3,
        LoadingColdWithAirConditioning = 4,
        HeatPipes = 5,
        SlowRotatingOrIntermittentHeatExchanger = 6
    }

    public enum ExhaustAirRecirculationType
    {
        No = 1,
        E20P = 2,
        E40P = 3,
        E60P = 4,
    }

    public class HVAC
    {
        private const string Br = "\r\n";
        public string Name { get; set; }
        public bool ReheatUsedInSummer { get; set; }

        private string ReheatUsedInSummerStr => ReheatUsedInSummer ? "1" : "2";

        public double ReheatTemperatureDelta { get; set; }

        private string ReheatTemperatureDeltaStr => Converter.DoubleToString(ReheatTemperatureDelta);

        public bool ReheatUsedInWinter { get; set; }
        private string ReheatUsedInWinterStr => ReheatUsedInWinter ? "1" : "2";
        public double HeatingNominalEfficiency { get; set; }
        private string HeatingNominalEfficiencyStr => Converter.DoubleToString(HeatingNominalEfficiency);
        public CopPairGroup HeatingCops { get; set; }
        public double CoolingNominalCop { get; set; }
        private string CoolingNominalCopStr => Converter.DoubleToString(CoolingNominalCop);
        public CopPairGroup CoolingCops { get; set; }
        public int HvacSystemType { get; set; }
        public HeatRecoveryType HeatRecoveryType { get; set; }
        public ExhaustAirRecirculationType ExhaustAirRecirculationType { get; set; }
        public double DesignHeatingSupplyAirTemperature { get; set; } = double.NaN;

        private string DesignHeatingSupplyAirTemperatureStr=> double.IsNaN(DesignHeatingSupplyAirTemperature)
            ? "-"
            : Converter.DoubleToString(DesignHeatingSupplyAirTemperature);

        public double DesignCoolingSupplyAirTemperature { get; set; } = double.NaN;
        private string DesignCoolingSupplyAirTemperatureStr => double.IsNaN(DesignCoolingSupplyAirTemperature)
            ? "-"
            : Converter.DoubleToString(DesignCoolingSupplyAirTemperature);
        public double DesignHeatingHotWaterSupplyTemperature { get; set; } = double.NaN;
        private string DesignHeatingHotWaterSupplyTemperatureStr => double.IsNaN(DesignHeatingHotWaterSupplyTemperature)
            ? "-"
            : Converter.DoubleToString(DesignHeatingHotWaterSupplyTemperature);
        public double DesignHeatingHotWaterReturnTemperature { get; set; } = double.NaN;
        private string DesignHeatingHotWaterReturnTemperatureStr => double.IsNaN(DesignHeatingHotWaterReturnTemperature)
            ? "-"
            : Converter.DoubleToString(DesignHeatingHotWaterReturnTemperature);
        public double DesignCoolingChilledWaterSupplyTemperature { get; set; } = double.NaN;
        private string DesignCoolingChilledWaterSupplyTemperatureStr => double.IsNaN(DesignCoolingChilledWaterSupplyTemperature)
            ? "-"
            : Converter.DoubleToString(DesignCoolingChilledWaterSupplyTemperature);
        public double DesignCoolingChilledWaterReturnTemperature { get; set; } = double.NaN;
        private string DesignCoolingChilledWaterReturnTemperatureStr => double.IsNaN(DesignCoolingChilledWaterReturnTemperature)
            ? "-"
            : Converter.DoubleToString(DesignCoolingChilledWaterReturnTemperature);
        public double SpecificFanPower { get; set; }
        private string SpecificFanPowerStr => Converter.DoubleToString(SpecificFanPower);
        public double FanFlowControlFactor { get; set; }
        private string FanFlowControlFactorStr => Converter.DoubleToString(FanFlowControlFactor);

        public double HeatingCapacity { get; set; } = double.NaN;

        private string HeatingCapacityStr => double.IsNaN(HeatingCapacity)
            ? "-"
            : Converter.DoubleToString(HeatingCapacity);
        public double CoolingCapacity { get; set; } = double.NaN;
        private string CoolingCapacityStr => double.IsNaN(CoolingCapacity)
            ? "-"
            : Converter.DoubleToString(CoolingCapacity);
        public override bool Equals(object obj)
        {
            if (obj is HVAC other)
            {
                return this.Name.Equals(other.Name, StringComparison.OrdinalIgnoreCase);
            }
            return false;
        }
        public override int GetHashCode()
        {
            return this.Name.ToLower().GetHashCode();
        }
        public string ToCen()
        {
            string result = $"HVAC Name: {Name}" + Br;
            result += $"Reheat Used in Summer: {ReheatUsedInSummerStr} \t!!! 1. yes, 2. no" + Br;
            result += $"Reheat Temperature Delta: {ReheatTemperatureDeltaStr} " + Br;
            result += $"Reheat Used in Winter: {ReheatUsedInWinterStr} \t!!! 1. yes, 2. no" + Br;
            result += $"Heating Nominal Efficiency: {HeatingNominalEfficiencyStr}" + Br;

            // 先排序
            var heatingCops = CopPairGroup.DictionarySort(HeatingCops.Dictionary);
            foreach (var pair in heatingCops)
            {
                result +=
                    $"Heating COP{pair.Key}: {pair.Value} \t!!! Relative efficiency for {pair.Key}% load" +
                    Br;
            }

            result += $"Cooling Nominal COP: {CoolingNominalCopStr}" + Br;
            var coolingCops = CopPairGroup.DictionarySort(CoolingCops.Dictionary);
            foreach (var pair in coolingCops)
            {
                result += $"Cooling COP{pair.Key}: {pair.Value} \t!!! Relative COP for 100% load" + Br;
            }

            result += $"HVAC System Type: {HvacSystemType}\t!!! Refer to HVAC system type table" + Br;
            result +=
                $"Heat Recovery Type: {((int)HeatRecoveryType).ToString()} \t!!! 1. no heat recovery, 2. heat change plates or pipes, 3. two-element-system, 4. loading cold with air-conditioning, 5. heat pipes, 6. slow rotating or intermittent heat exchanger" +
                Br;
            result += $"Exhaust Air Recirculation Type: {((int)ExhaustAirRecirculationType).ToString()} \t!!! 1. no exhaust air recirculation, 2. exhaust air recirculation 20%, 3. exhaust air recirculation 40%, 4. exhaust air recirculation 60%" + Br;
            result += $"Heating Capacity: {HeatingCapacityStr}      !!! Define the heating capacity of the HVAC system, in kW, if '-' used then, the capacity if unlimited." + Br;
            result += $"Cooling Capacity: {CoolingCapacityStr}      !!! Define the cooling capacity of the HVAC system, in kW, if '-' used then, the capacity if unlimited." + Br;
            result += $"Design Heating Supply Air Temperature: {DesignHeatingSupplyAirTemperatureStr}\t!!! determine the heating supply air temperature in Celsius, if left '-', default value will be used, unit: Celsius" + Br;
            result +=
                $"Design Cooling Supply Air Temperature: {DesignCoolingSupplyAirTemperatureStr}\t!!! determine the heating supply air temperature in Celsius, if left '-', default value will be used, unit: Celsius" +
                Br;
            result += $"Design Heating Hot Water Supply Temperature: {DesignHeatingHotWaterSupplyTemperatureStr} \t!!! unit: Celsius" + Br;
            result += $"Design Heating Hot Water Return Temperature: {DesignHeatingHotWaterReturnTemperatureStr} \t!!! unit: Celsius" + Br;
            result += $"Design Cooling Chilled Water Supply Temperature: {DesignCoolingChilledWaterSupplyTemperatureStr} \t!!! unit: Celsius" + Br;
            result += $"Design Cooling Chilled Water Return Temperature: {DesignCoolingChilledWaterReturnTemperatureStr} \t!!! unit: Celsius" + Br;
            result += $"Specific Fan Power: {SpecificFanPowerStr}\t!!! average electro-motor efficiency, unit: W/(m3/s)" + Br;
            result += $"Fan Flow Control Factor: {FanFlowControlFactorStr} \t!!! average control reduction factor" + Br;
            return result;
        }

        public override string ToString()
        {
            return $"HVAC - Name: {this.Name}";
        }
    }
}