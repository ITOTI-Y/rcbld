using System;
using System.CodeDom;
using Grasshopper.Kernel.Types;
using RCBldGH.Utils;
using Rhino.Geometry;

namespace RCBldGH.Modules
{
    public class Opaque
    {
        public Opaque()
        {
            Id = Guid.NewGuid().ToString();
        }
        public string Id { get; }

        public override string ToString()
        {
            return $"Opaque: {Name}";
        }
        public GH_Surface GeometrySurface { get; set; }
        public Material Material { get; set; }
        public string Name => Material.Name;

        public double Area => SurfaceTools.GetBrepArea(GeometrySurface.Value);
        public string AreaStr => Converter.DoubleToString(Area);
        public Point3d Centriod=> SurfaceTools.GetGH_SurfaceCentroid(GeometrySurface);
        public Slab ToSlab => new Slab { GeometrySurface = this.GeometrySurface, Material = this.Material };

    }
}