using Grasshopper.Kernel.Types;
using RCBldGH.Utils;

namespace RCBldGH.Modules
{
    public class Window
    {
        public GH_Surface GeometrySurface { get; set; }
        public Material Material { get; set; }
        public string Name => Material.Name;

        public double Area => SurfaceTools.GetGH_SurfaceArea(GeometrySurface);
        public string AreaStr => Converter.DoubleToString(Area);

        public double WindowOverhangAngle { get; set; } = -1;
        public string WindowOverhangAngleStr => WindowOverhangAngle< 0 ? "-" : Converter.DoubleToString(WindowOverhangAngle);
        public double WindowFinAngle { get; set; } = -1;
        public string WindowFinAngleStr => WindowFinAngle < 0 ? "-" : Converter.DoubleToString(WindowFinAngle);
        public double WindowHorizonAngle { get; set; } = -1;
        public string WindowHorizonAngleStr => WindowHorizonAngle< 0 ? "-" : Converter.DoubleToString(WindowHorizonAngle);

        public WindowShadingType WindowShadingType { get; set; }
        public string WindowShadingTypeStr => WindowShadingType == 0 ? "-" : ((int)WindowShadingType).ToString();
        public WindowShadingWhere WindowShadingWhere { get; set; }
        public string WindowShadingWhereStr => WindowShadingWhere == 0 ? "-" : ((int) WindowShadingWhere).ToString();
        public WindowShadingControl WindowShadingControl { get; set; }
        public string WindowShadingControlStr => WindowShadingControl == 0 ? "-" : ((int) WindowShadingControl).ToString();
    }
}