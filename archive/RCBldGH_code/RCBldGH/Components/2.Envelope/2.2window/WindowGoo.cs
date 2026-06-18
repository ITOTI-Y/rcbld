using Grasshopper.Kernel.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class WindowGoo : GH_Goo<Window>
    {
        public override bool IsValid => this.Value != null;

        public override string TypeName => "Window";

        public override string TypeDescription => "Window.";

        public override IGH_Goo Duplicate()
        {
            return this.m_value.GeometrySurface.Duplicate();
        }

        public override string ToString()
        {
            return "Window: " + this.Value.Name;
        }
    }
}