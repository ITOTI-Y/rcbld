using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using RCBldGH.Utils;

namespace RCBldGH.Modules
{
    public enum BuildingType
    {
        Residential = 1,
        Commercial = 2,
        Industrial = 3
    }

    public enum TerrainClass
    {
        OpenTerrain = 1,
        Country = 2,
        UrbanCity = 3
    }

    public enum GroundType
    {
        ClayOrSilt = 1,
        SandOrGravel = 2,
        HomegeneousRock = 3
    }

    public class Basics
    {
        private const string Br = "\r\n";

        public string WeatherFile { get; set; }
        public string BuildingName { get; set; }
        public BuildingType BuildingType { get; set; }
        public TerrainClass TerrainClass { get; set; }
        public GroundType GroundType { get; set; }
        public string MonthlyGroundSurfaceTemperatureStr { get; set; }
        public int Floors { get; set; }
        public double BuildingHeight { get; set; }
        public double BuildingLength { get; set; }
        public double BuildingWidth { get; set; }
        public double BuildingArea { get; set; }

        /// <summary>
        /// 只能是 1 - 11 这几个整数
        /// </summary>
        public int EnvelopeHeatCapacityType { get; set; } = -1;

        private string EnvelopeHeatCapacityTypeStr
        {
            get
            {
                if (EnvelopeHeatCapacityType == -1)
                {
                    return "-";
                }

                return EnvelopeHeatCapacityType.ToString();
            }
        }

        public int EnvelopeHeatCapacity { get; set; }
        private string EnvelopeHeatCapacityStr
        {
            get
            {
                if (EnvelopeHeatCapacity == -1)
                {
                    return "-";
                }

                return EnvelopeHeatCapacity.ToString();
            }
        }

        public double EffectiveMassArea { get; set; } = double.NaN;

        private string EffectiveMassAreaStr
        {
            get
            {
                if (double.IsNaN(EffectiveMassArea))
                {
                    return "-";
                }

                return EffectiveMassArea.ToString("N");
            }
        }


        public string ToCen()
        {
            string result = "$Basics:" + Br + Br;
            result +=
                $"Weather File: {WeatherFile}\t!!! only supports .epw file, the file should be under \\\\Weather_Files\\\\" + Br;
            result +=
                $"Building Name: {BuildingName}\t!!! specify the building name" + Br;
            result +=
                $"Building Type: {(int)BuildingType} \t!!! 1. residential, 2. commercial, 3. industrial" + Br;
            result +=
                $"Terrain Class: {(int)TerrainClass} \t!!! 1. open terrain, 2. country 3. urban/city" + Br;
            result +=
                $"Ground Type: {(int)GroundType} \t!!! 1. clay or silt, 2. sand or gravel 3. homogeneous rock" + Br;
            result +=
                $"Monthly Ground Surface Temperature: {MonthlyGroundSurfaceTemperatureStr}" +
                Br;
            result +=
                $"Floors: {Floors}\t!!! number of floors" + Br;
            result +=
                $"Building Height: {Converter.DoubleToString(BuildingHeight)} !!! unit: m" + Br;
            result +=
                $"Building Length: {Converter.DoubleToString(BuildingLength)} \t!!! unit: m" + Br;
            result +=
                $"Building Width: {Converter.DoubleToString(BuildingWidth)} \t!!! unit: m" + Br;
            result +=
                $"Ground Floor Area: {Converter.DoubleToString(BuildingArea)}\t!!! unit: m" + Br;
            result +=
                $"Envelope Heat Capacity Type: {EnvelopeHeatCapacityTypeStr}  !!! Cm in unit (J/K m2), 1:10000, 2: 15000, 3: 25000, 4: 40000, 5: 60000, 6: 80000, 7: 115000, 8: 165000, 9: 260000, 10: 300000; 11. 370000, if '-' is used, envelope heat capacity should be given" +
                Br;
            result +=
                $"Envelope Heat Capacity: {EnvelopeHeatCapacityStr} \t!!! unit: J/K m2, if '-' is used in \"Envelope Heat Capacity Type\", then this parameter should be given" +
                Br;
            result +=
                $"Effective Mass Area: {EffectiveMassAreaStr}\t!!! Unit: area per floor area, if '-' is used in \"Envelope Heat Capacity Type\", then this parameter should be given" +
                Br;

            return result;
        }

        public override string ToString()
        {
            return $"Basics - Building Name: {BuildingName} ";
        }
    }


}
