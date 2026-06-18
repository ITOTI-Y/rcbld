using RCBldGH.Domains;
using RCBldGH.Utils;

namespace RCBldGH.Modules
{
    public enum PvType
    {
        MonoCrystalline = 1,
        MultiCrystalline=2,
        ThinFilmAmorphous=3,
        OtherThinFilmLayers=4,
        ThinFilmCopperIndiumGalliumDiselenide=5,
        ThinFilmCadmiumTelloride=6
    }

    public enum PvVentilationType
    {
        Unventilated=1,
        ModeratelyVentilated=2,
        StronglyVentilated=3
    }

    public class PV
    {
        private const string Br = "\r\n";
        public double SurfaceArea { get; set; }

        public string SurfaceAreaStr
        {
            get
            {
                if (double.IsNaN(SurfaceArea))
                {
                    return "-";
                }

                return Converter.DoubleToString(SurfaceArea);
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
        public PvType Type { get; set; }
        public PvVentilationType VentilationType { get; set; }

        public string ToCen()
        {
            string result = "$PV: !!! Building Integrated PV System" + Br + Br;
            result +=
                $"PV Surface Area: {SurfaceAreaStr} \t!!! unit: m2" + Br;
            result +=
                $"PV Orientation: {Orientation} \t!!! specify the orientation: S, SE, E, NE, N, NW, W, SW" + Br;
            result +=
                $"PV Angle: {AngleStr} \t!!! unit: degree" + Br;
            result +=
                $"PV Type: {(int)Type} \t!!! 1. mono crystalline silicona, 2. multi crystalline silicona, 3. thin film amorphous silicon, 4. other thin film layers, 5. thin film copper-indium-gallium-diselenide, 6. thin film cadmium-telloride" + Br;
            result +=
                $"PV Ventilation Type: {(int)VentilationType} \t!!! 1. unventilated modules, 2. moderately ventilated modules, 3. strongly ventilated modules" + Br;
            return result;
        }

        public override string ToString()
        {
            return "PV";
        }
    }
}