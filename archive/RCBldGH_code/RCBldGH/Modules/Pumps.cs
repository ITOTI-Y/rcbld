using RCBldGH.Utils;

namespace RCBldGH.Modules
{
    public enum PumpControlType
    {
        NoPumpUsed=1,
        AutoControlMoreThanHalf=2,
        Other=3
    }
    public class Pumps
    {
        private const string Br = "\r\n";
        public double HeatingUsePumpRate { get; set; }

        public string HeatingUsePumpRateStr
        {
            get
            {
                if (double.IsNaN(HeatingUsePumpRate))
                {
                    return "-";
                }

                return Converter.DoubleToString(HeatingUsePumpRate);
            }
        }

        public double CoolingUsePumpRate { get; set; }
        public string CoolingUsePumpRateStr
        {
            get
            {
                if (double.IsNaN(CoolingUsePumpRate))
                {
                    return "-";
                }

                return Converter.DoubleToString(CoolingUsePumpRate);
            }
        }
        public double DhwUsePumpPowerPerWaterFlowRate { get; set; }

        public string DhwUsePumpPowerPerWaterFlowRateStr
        {
            get
            {
                if (double.IsNaN(DhwUsePumpPowerPerWaterFlowRate))
                {
                    return "-";
                }

                return Converter.DoubleToString(DhwUsePumpPowerPerWaterFlowRate);
            }
        }
        public double DhwUsePeakFlowRate { get; set; }
        public string DhwUsePeakFlowRateStr
        {
            get
            {
                if (double.IsNaN(DhwUsePeakFlowRate))
                {
                    return "-";
                }

                return Converter.DoubleToString(DhwUsePeakFlowRate,9);
            }
        }
        public PumpControlType PumpControlType { get; set; }

        public string ToCen()
        {
            string result = "$Pumps: !!! pump use information" + Br + Br;
            result +=
                $"Heating Use Pump Power Per Water Flow Rate: {HeatingUsePumpRateStr} \t!!! unit: W-s/m3" + Br;
            result +=
                $"Cooling Use Pump Power Per Water Flow Rate: {CoolingUsePumpRateStr} \t!!! unit: W-s/m3" + Br;
            result +=
                $"DHW Use Pump Power Per Water Flow Rate: {DhwUsePumpPowerPerWaterFlowRateStr} \t!!! unit: W-s/m3" + Br;
            result +=
                $"DHW Use Peak Flow Rate: {DhwUsePeakFlowRateStr} \t!!! unit: m3/s" + Br;
            result +=
                $"Pump Control Type: {(int)PumpControlType} \t!!! 1. no pump used, 2. automatic control more than 50%, 3. all other case" + Br;
            return result;
        }

        public override string ToString()
        {
            return "Pumps";
        }
    }
}