using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Rhino.Geometry;
using RCBldGH.Utils;

namespace RCBldGH.Domains
{
    /// <summary>
    /// 由时间区间和数据组成，数据是 double 列表。
    /// </summary>
    public class TimespanDataPair
    {
        private const string Br = "\r\n";
        public Interval TimeSpan { get; set; }
        public List<double> Data { get; set; }

        public string ToCen()
        {
            string result = $"From {(int)TimeSpan.Min} To {(int)TimeSpan.Max}: ";
            result += $"{Converter.DoubleListToString(Data)}" + Br;
            return result;
        }

        public TimespanDataPair Duplicate()
        {
            TimespanDataPair newPair = new TimespanDataPair
            {
                TimeSpan = new Interval(TimeSpan.T0,TimeSpan.T1),
                Data = new List<double>(this.Data.ToArray()),
            };
            return newPair;
        }
    }
}
