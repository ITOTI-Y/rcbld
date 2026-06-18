using Grasshopper.Kernel.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class ZoneGoo : GH_Goo<Zone>
    {
        public override bool IsValid => this.Value != null;

        public override string TypeName => "Zone";

        public override string TypeDescription => "Zone";

        public override IGH_Goo Duplicate()
        {
            return this;
        }

        public override string ToString()
        {
            return "Zone: " + this.Value.Name;
        }
    }
}