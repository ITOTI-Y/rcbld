using System.Collections.Generic;
using Rhino.Geometry;
using RCBldGH.Modules;
using RCBldGH.Utils;

namespace RCBldGH.Domains
{
    /// <summary>
    /// 由时间区间和关联的 Schedule 组成。
    /// </summary>
    public class TimespanSchedulePair
    {
        private const string Br = "\r\n";
        public Interval TimeSpan { get; set; }
        public Schedule RelatedSchedule { get; set; }

        public string ToCen()
        {
            string result = $"From {(int)TimeSpan.Min} To {(int)TimeSpan.Max}: ";
            result += $"{RelatedSchedule.Name}" + Br;
            return result;
        }
    }
}