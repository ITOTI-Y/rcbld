//using Grasshopper.Kernel.Types;
//using RCBldGH.Modules;

//namespace RCBldGH.Components.Envelope
//{
//    public class EnvelopeSettingGoo : GH_Goo<EnvelopeSetting>
//    {
//        public override bool IsValid => this.Value!=null;

//        public override string TypeName => "EnvelopeSurface";

//        public override string TypeDescription => "Envelop surface.";

//        public override IGH_Goo Duplicate()
//        {
//            return this;
//        }

//        public override string ToString()
//        {
//            return "Envelop Surface: " + this.Value.Name;
//        }
//    }
//}
using Grasshopper.Kernel.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class EnvelopeSettingGoo : GH_Goo<EnvelopeSetting>
    {
        // 默认构造函数
        public EnvelopeSettingGoo()
        {
            this.Value = new EnvelopeSetting();
        }

        // 带参数的构造函数
        public EnvelopeSettingGoo(EnvelopeSetting setting)
        {
            this.Value = setting;
        }

        // 确认数据有效性
        public override bool IsValid => this.Value != null;

        // 数据类型名称
        public override string TypeName => "EnvelopeSurface";

        // 数据类型描述
        public override string TypeDescription => "Envelope surface.";

        // 复制当前对象
        public override IGH_Goo Duplicate()
        {
            return new EnvelopeSettingGoo(this.Value); // 创建新实例而不是返回this
        }

        // 对象的字符串表示
        public override string ToString()
        {
            return this.Value != null ? "Envelope Surface: " + this.Value.Name : "Invalid EnvelopeSurface";
        }

        // 隐式转换操作符
        public static implicit operator EnvelopeSettingGoo(EnvelopeSetting setting)
        {
            return new EnvelopeSettingGoo(setting);
        }
    }
}