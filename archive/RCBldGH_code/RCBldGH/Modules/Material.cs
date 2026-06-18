using RCBldGH.Utils;

namespace RCBldGH.Modules
{
    public enum MaterialType
    {
        InternalFloor,
        ExternalFloor,
        InternalWall,
        ExternalWall,
        Ground,
        Roof,
        Window
    }

    public class MaterialSetting
    {
        public  Material RoofMaterial { get; set; }
        public  Material GroundMaterial { get; set; }
        public  Material InternalWallMaterial { get; set; }
        public Material ExternalWallMaterial { get; set; }
        public Material InternalFloorMaterial { get; set; }
        public Material ExternalFloorMaterial { get; set; }
        //public string Name { get; set; }
    }

    public class Material
    {
        private const string Br = "\r\n";
        private string uvStr = "-";
        private string acStr = "-";
        private string eStr = "-";

        public string Name { get; set; }
        public MaterialType MaterialType { get; set; }
        public double UValue { get; set; }
        public double AbsorptionCoefficient { get; set; }
        public double Emissivity { get; set; }
        public double SHGC { get; set; }

        internal string ToCen()
        {
            if (MaterialType == MaterialType.InternalFloor||MaterialType==MaterialType.Ground||MaterialType==MaterialType.ExternalFloor)
            {
                return FloorToCen();
            }

            if (MaterialType == MaterialType.Roof||MaterialType==MaterialType.InternalWall || MaterialType == MaterialType.ExternalWall)
            {
                return RoofToCen();
            }

            if (MaterialType==MaterialType.Window)
            {
                return WindowToCen();
            }

            return string.Empty;
        }
        public override string ToString()
        {
            return ToCen();
        }

        private string FloorToCen()
        {
            return $"{Name}: {Converter.DoubleToString(UValue)}\r\n";
        }

        private string RoofToCen()
        {
            if (UValue >= 0)
            {
                uvStr = $"{Converter.DoubleToString(UValue)}";
            }

            if (AbsorptionCoefficient >= 0)
            {
                acStr = $"{Converter.DoubleToString(AbsorptionCoefficient)}";
            }

            if (Emissivity >= 0)
            {
                eStr = $"{Converter.DoubleToString(Emissivity)}";
            }
            return $"{Name}: {uvStr}, {acStr}, {eStr}" + Br;
        }

        private string WindowToCen()
        {
            return $"{Name}: {UValue}, {Converter.DoubleToString(Emissivity)}, {Converter.DoubleToString(SHGC)}" + Br;
        }

    }
}