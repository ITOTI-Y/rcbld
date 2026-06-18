using Grasshopper.Kernel.Types;
using RCBldGH.Utils;

namespace RCBldGH.Modules
{
    public class Slab
    {
        public GH_Surface GeometrySurface { get; set; }
        public Material Material { get; set; }
        public string Name => Material.Name;

        public double Area => SurfaceTools.GetBrepArea(GeometrySurface.Value);
        public string AreaStr => Converter.DoubleToString(Area);
        public Opaque ToOpaque=> new Opaque {GeometrySurface=this.GeometrySurface, Material =this.Material};
    }
}