using System.Collections.Generic;
using Rhino.Geometry;
using RCBldGH.Utils;

namespace RCBldGH.Modules.Schedules
{
    public class DaySchedule
    {
        public DaySchedule(List<Interval> timeSpans, List<double>data)
        {
            // 如果时间段数量和数据数量不匹配，无效。
            if (timeSpans.Count!=data.Count)
            {
                IsValid = false;
                ErrorMessage = "The number of timespans does not match the number of data.";
                return;
            }
            
            // 如果时间段并非是 0 到 24 小时，无效。
            if (!TimespanTools.IsTotal24Hours(timeSpans))
            {
                IsValid = false;
                ErrorMessage = "The total timespan is not 0 to 24.";
                return;
            }

            // 如果时间段 From To 不为整数，无效。
            foreach (var span in timeSpans)
            {
                if (!TimespanTools.IsIntegerTimespan(span))
                {
                    IsValid = false;
                    ErrorMessage = "The timespan must consist of integers.";
                    return;
                }
            }

            TimeSpans = timeSpans;
            Data = data;
            IsValid = true;
        }
        public bool IsValid { get; }
        public string ErrorMessage { get; }
        public List<Interval> TimeSpans { get;}
        public List<double> Data { get; }
        public override string ToString()
        {
            string temp = "";
            for (int i = 0; i < TimeSpans.Count; i++)
            {
                var span = TimeSpans[i];
                temp += $"From {(int) span.Min} To {(int) span.Max}: {Data[i]}";
                if (i!=TimeSpans.Count-1)
                {
                    temp += "\r\n";
                }
            }

            return temp;
        }
    }
}