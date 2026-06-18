using Grasshopper.Kernel.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class OpaqueGoo : GH_Goo<Opaque>
    {
        public override bool IsValid => this.Value != null;

        public override string TypeName => "Opaque";

        public override string TypeDescription => "Opaque.";

        public override IGH_Goo Duplicate()
        {
            return this;
        }

        public override string ToString()
        {
            return "Opaque: " + this.Value.Name;
        }

    }
}