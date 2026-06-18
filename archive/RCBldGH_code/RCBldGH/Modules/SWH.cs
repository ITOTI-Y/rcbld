using RCBldGH.Domains;
using RCBldGH.Utils;

namespace RCBldGH.Modules
{
    public class SWH
    {
        private const string Br = "\r\n";
        public double Area { get; set; }
        public string AreaStr
        {
            get
            {
                if (double.IsNaN(Area))
                {
                    return "-";
                }

                return Converter.DoubleToString(Area);
            }
        }
        public Orientation Orientation { get; set; }
        public double Angle { get; set; }
        public string AngleStr
        {
            get
            {
                if (double.IsNaN(Angle))
                {
                    return "-";
                }

                return Converter.DoubleToString(Angle);
            }
        }

        public string ToCen()
        {
            string result = "$SWH: \t!!! Solar Water Heating System:" + Br + Br;
            result +=
                $"SWH Area: {AreaStr} \t!!! unit: m2" + Br;
            result +=
                $"SWH Orientation: {Orientation} \t!!! specify the orientation: S, SE, E, NE, N, NW, W, SW" + Br;
            result +=
                $"SWH Angle: {AngleStr} \t!!! unit: degree" + Br;
            return result;
        }

        public override string ToString()
        {
            return $"SWH - Area: {AreaStr}, Orientation: {Orientation}, Angle: {AngleStr}";
        }
    }
}