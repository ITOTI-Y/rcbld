using System.Collections.Generic;
using RCBldGH.Utils;

namespace RCBldGH.Modules
{
    public class CalibrationPara
    {
        public List<int> BuildingHeatCapacity { get; set; } = new List<int>();
        public List<double> EffectiveMassArea { get; set; } = new List<double>();
        public List<double> ExternalWallMaterialU { get; set; } = new List<double>();
        public List<double> ExternalWallMaterialA { get; set; } = new List<double>();
        public List<double> InternalWallMaterialU { get; set; } = new List<double>();
        public List<double> WindowMaterialU { get; set; } = new List<double>();
        public List<double> WindowMaterialE { get; set; } = new List<double>();
        public List<double> WindowMaterialShgc { get; set; } = new List<double>();
        public List<double> RoofMaterialU { get; set; } = new List<double>();
        public List<double> RoofMaterialA { get; set; } = new List<double>();
        public List<double> ExternalFloorMaterialU { get; set; } = new List<double>();
        public List<double> InternalFloorMaterialU { get; set; } = new List<double>();
        public List<double> AirInfiltrationRate { get; set; } = new List<double>();
        public List<double> AirInfiltrationStyle { get; set; } = new List<double>();
        public List<double> At { get; set; } = new List<double>();
        public List<double> LightingLoad { get; set; } = new List<double>();
        public List<double> PlugLoad { get; set; } = new List<double>();
        public List<double> HeatingCop { get; set; } = new List<double>();
        public List<double> CoolingCop { get; set; } = new List<double>();
        public List<double> HeatingSupplyAirTemperature { get; set; } = new List<double>();
        public List<double> CoolingSupplyAirTemperature { get; set; } = new List<double>();
        public List<double> HvacDistributionLossCoefficient { get; set; } = new List<double>();
        public double HeatingTemperatureSetPoint { get; set; } = double.NaN;
        public double CoolingTemperatureSetPoint { get; set; } = double.NaN;
        public List<double> MutationRate { get; set; } = new List<double>();
        public double RecombinationRate { get; set; } = double.NaN;
        public double PopulationMultiplier { get; set; } = double.NaN;
        public double MaximumIteration { get; set; } = double.NaN;
        public double ConvergenceTolerance { get; set; } = double.NaN;

        public string ToText()
        {
            string result = "Building Heat Capacity: ";
            for (int i = 0; i < BuildingHeatCapacity.Count; i++)
            {
                var item = BuildingHeatCapacity[i];
                if (i==BuildingHeatCapacity.Count-1)
                {
                    result += item.ToString() + ";\n";
                }
                else
                {
                    result += item.ToString() + ", ";
                }
            }

            result += "Effective Mass Area: ";
            for (int i = 0; i < EffectiveMassArea.Count; i++)
            {
                var item = EffectiveMassArea[i];
                if (i == EffectiveMassArea.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "External Wall Material U-value: ";
            for (int i = 0; i < ExternalWallMaterialU.Count; i++)
            {
                var item = ExternalWallMaterialU[i];
                if (i == ExternalWallMaterialU.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "External Wall Material Absorpsivity: ";
            for (int i = 0; i < ExternalWallMaterialA.Count; i++)
            {
                var item = ExternalWallMaterialA[i];
                if (i == ExternalWallMaterialA.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Internal Wall Material U-value: ";
            for (int i = 0; i < InternalWallMaterialU.Count; i++)
            {
                var item = InternalWallMaterialU[i];
                if (i == InternalWallMaterialU.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Window Material U-value: ";
            for (int i = 0; i < WindowMaterialU.Count; i++)
            {
                var item = WindowMaterialU[i];
                if (i == WindowMaterialU.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Window Material Emissivity: ";
            for (int i = 0; i < WindowMaterialE.Count; i++)
            {
                var item = WindowMaterialE[i];
                if (i == WindowMaterialE.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Window Material SHGC: ";
            for (int i = 0; i < WindowMaterialShgc.Count; i++)
            {
                var item = WindowMaterialShgc[i];
                if (i == WindowMaterialShgc.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Roof Material U-value: ";
            for (int i = 0; i < RoofMaterialU.Count; i++)
            {
                var item = RoofMaterialU[i];
                if (i == RoofMaterialU.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Roof Material Absorptivity: ";
            for (int i = 0; i < RoofMaterialA.Count; i++)
            {
                var item = RoofMaterialA[i];
                if (i == RoofMaterialA.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "External Floor Material U-value: ";
            for (int i = 0; i < ExternalFloorMaterialU.Count; i++)
            {
                var item = ExternalFloorMaterialU[i];
                if (i == ExternalFloorMaterialU.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Internal Floor Material U-value: ";
            for (int i = 0; i < InternalFloorMaterialU.Count; i++)
            {
                var item = InternalFloorMaterialU[i];
                if (i == InternalFloorMaterialU.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Air Infiltration Rate: ";
            for (int i = 0; i < AirInfiltrationRate.Count; i++)
            {
                var item = AirInfiltrationRate[i];
                if (i == AirInfiltrationRate.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Air Infiltration Style: ";
            for (int i = 0; i < AirInfiltrationStyle.Count; i++)
            {
                var item = AirInfiltrationStyle[i];
                if (i == AirInfiltrationStyle.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "At: ";
            for (int i = 0; i < At.Count; i++)
            {
                var item = At[i];
                if (i == At.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Lighting Load: ";
            for (int i = 0; i < LightingLoad.Count; i++)
            {
                var item = LightingLoad[i];
                if (i == LightingLoad.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Plug Load: ";
            for (int i = 0; i < PlugLoad.Count; i++)
            {
                var item = PlugLoad[i];
                if (i == PlugLoad.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Heating COP: ";
            for (int i = 0; i < HeatingCop.Count; i++)
            {
                var item = HeatingCop[i];
                if (i == HeatingCop.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Cooling COP: ";
            for (int i = 0; i < CoolingCop.Count; i++)
            {
                var item = CoolingCop[i];
                if (i == CoolingCop.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Heating Supply Air Temperature: ";
            for (int i = 0; i < HeatingSupplyAirTemperature.Count; i++)
            {
                var item = HeatingSupplyAirTemperature[i];
                if (i == HeatingSupplyAirTemperature.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Cooling Supply Air Temperature: ";
            for (int i = 0; i < CoolingSupplyAirTemperature.Count; i++)
            {
                var item = CoolingSupplyAirTemperature[i];
                if (i == CoolingSupplyAirTemperature.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "HVAC Distribution Loss Coefficient: ";
            for (int i = 0; i < HvacDistributionLossCoefficient.Count; i++)
            {
                var item = HvacDistributionLossCoefficient[i];
                if (i == HvacDistributionLossCoefficient.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Heating Temperature Setpoint: ";
            result += Converter.DoubleToString(HeatingTemperatureSetPoint) + ";\n";

            result += "Cooling Temperature Setpoint: ";
            result += Converter.DoubleToString(CoolingTemperatureSetPoint) + ";\n";

            result += "\n";

            result += "Mutation Rate: ";
            for (int i = 0; i < MutationRate.Count; i++)
            {
                var item = MutationRate[i];
                if (i == MutationRate.Count - 1)
                {
                    result += Converter.DoubleToString(item) + ";\n";
                }
                else
                {
                    result += Converter.DoubleToString(item) + ", ";
                }
            }

            result += "Recombination Rate: ";
            result += Converter.DoubleToString(RecombinationRate)+ ";\n";

            result += "Population Multiplier: ";
            result += Converter.DoubleToString(PopulationMultiplier)+ ";\n";

            result += "Maximum Iteration: ";
            result += Converter.DoubleToString(MaximumIteration)+ ";\n";

            result += "Convergence Tolerance: ";
            result += Converter.DoubleToString(ConvergenceTolerance)+ ";\n";

            return result;
        }
    }
}