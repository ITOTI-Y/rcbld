using Grasshopper.Kernel.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components
{
    public class SuperSurfaceGoo : GH_Goo<SuperSurface>
    {
        public SuperSurfaceGoo()
        {
            this.Value = new SuperSurface();
        }

        public SuperSurfaceGoo(SuperSurface surface)
        {
            this.Value = surface;
        }

        public override bool IsValid => this.Value != null;

        public override string TypeName => "SuperSurface";

        public override string TypeDescription => "A custom surface type.";

        public override IGH_Goo Duplicate()
        {
            return new SuperSurfaceGoo(this.Value);
        }

        public override string ToString()
        {
            return "SuperSurface: " + (this.Value != null ? "Defined" : "Undefined");
        }

        // 可选的转换操作符，如果需要的话
        public static implicit operator SuperSurfaceGoo(SuperSurface surface)
        {
            return new SuperSurfaceGoo(surface);
        }
    }
}