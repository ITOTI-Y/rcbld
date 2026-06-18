using RCBldGH.Utils;

namespace RCBldGH.Modules
{
    public class WindTurbines
    {
        private const string Br = "\r\n";
        public int Number { get; set; }
        public double Diameter { get; set; }
        public string DiameterStr
        {
            get
            {
                if (double.IsNaN(Diameter))
                {
                    return "-";
                }

                return Converter.DoubleToString(Diameter,2);
            }
        }
        public double Efficiency { get; set; }
        public string EfficiencyStr
        {
            get
            {
                if (double.IsNaN(Efficiency))
                {
                    return "-";
                }

                return Converter.DoubleToString(Efficiency, 2);
            }
        }

        public string ToCen()
        {
            string result = "$Wind Turbines:" + Br + Br;
            result +=
                $"Wind Turbine Number: {Number}" + Br;
            result +=
                $"Wind Turbine Diameter: {DiameterStr} \t!!! unit: m" + Br;
            result +=
                $"Wind Turbine Efficiency: {EfficiencyStr} \t!!! " + Br;
            return result;
        }
    }
}