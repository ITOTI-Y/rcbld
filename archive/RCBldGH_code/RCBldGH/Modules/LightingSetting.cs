using System;
using System.ComponentModel;
using RCBldGH.Utils;

namespace RCBldGH.Modules
{
    public class LightingSetting
    {
        private const string Br = "\r\n";
        public string LightingName { get; set; }
        public double LightingLoad { get; set; } 
        public double ParasiticLightingEnergy { get; set; } = double.NaN;
        private string EnergyStr
        {
            get
            {
                if (double.IsNaN(ParasiticLightingEnergy))
                {
                    return "-";
                }

                return Converter.DoubleToString(ParasiticLightingEnergy);
            }
        }
        public double DayLightingFactor { get; set; }
        public double LightingOccupancyFactor { get; set; }
        public double LightingIlluminationControlFactor { get; set; }

        public string ToCen()
        {
            string result = $"Lighting Name: {LightingName} \t!!!specify the "+Br;
            result +=
                $"Lighting Load: {Converter.DoubleToString(LightingLoad)}\t\t!!! unit: W/m2" + Br;
            result +=
                $"Parasitic Lighting Energy: {EnergyStr}\t!!! unit: kWh/m2/yr, leave it '-' will use default value" + Br;
            result +=
                $"Daylighting Factor: {Converter.DoubleToString(DayLightingFactor)} \t!!! No Control: 1, Range (0=< factor =<1)" + Br;
            result +=
                $"Lighting Occupancy Factor: {Converter.DoubleToString(LightingOccupancyFactor)} \t!!! No Control: 1, Range (0=< factor =<1)" + Br;
            result +=
                $"Lighting Illumination Control Factor: {Converter.DoubleToString(LightingIlluminationControlFactor)} \t!!! No Control: 1, Range (0=< factor =<1)" + Br;
            return result;
        }

        public override string ToString()
        {
            return $"Lighting Template: {LightingName}";
        }

        public override bool Equals(object obj)
        {
            if (obj is LightingSetting other)
            {
                return this.LightingName.Equals(other.LightingName, StringComparison.OrdinalIgnoreCase);
            }
            return false;
        }
        public override int GetHashCode()
        {
            return this.LightingName.ToLower().GetHashCode();
        }
    }
}