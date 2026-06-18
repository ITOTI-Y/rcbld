using Grasshopper.Kernel.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class SlabGoo : GH_Goo<Slab>
    {
        public override bool IsValid => this.Value != null;

        public override string TypeName => "Slab";

        public override string TypeDescription => "Slab.";

        public override IGH_Goo Duplicate()
        {
            return this.m_value.GeometrySurface.Duplicate();
        }

        public override string ToString()
        {
            return "Slab: " + this.Value.Name;
        }
    }
}