using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Domains;

namespace RCBldGH.Utils
{
    public class TimespanTools
    {
        public static bool IsTotal24Hours(List<Interval> timeSpans)
        {
            double total = 0;
            foreach (var span in timeSpans)
            {
                if (span.Min<0 || span.Max>24 )
                {
                    return false;
                }
                total += span.Length;
            }

            if (Math.Abs(total - 24) > 0)
            {
                return false;
            }

            return true;
        }

        public static bool IsIntegerTimespan(Interval timespan)
        {
            if (HasFractionalPart(timespan.Min)&&HasFractionalPart(timespan.Max))
            {
                return false;
            }

            return true;
        }

        private static bool HasFractionalPart(double num)
        {
            if (Math.Abs((int)num-num) >0)
            {
                return true;
            }

            return false;
        }

        public static bool DoubleListToTimespanDataPairs(List<List<double>> dataListList,int count,out List<TimespanDataPair> pairs)
        {
            pairs = new List<TimespanDataPair>();

            if (dataListList.Count==0)
            {
                return false;
            }

            // 先前一组数据
            List<double> prevDataList = new List<double>();
            TimespanDataPair prevPair = null;

            int tempStart = -1;

            for (int i = 0; i < count; i++)
            {
                bool isSame = true;
                // 临时对照数据
                List<double> tempDataList = new List<double>();
                if (i==0)
                {
                    foreach (List<double> dataList in dataListList)
                    {
                        if (count != dataList.Count)
                        {
                            return false;
                        }
                        prevDataList.Add(dataList[i]);
                    }
                    prevPair = new TimespanDataPair
                    {
                        TimeSpan = new Interval(0, 1),
                        Data = new List<double>(prevDataList.ToArray())
                    };
                    tempStart = 0;
                }
                else
                {
                    for (int j = 0; j < dataListList.Count; j++)
                    {
                        List<double> dataList = dataListList[j];
                        if (prevDataList[j]!=dataList[i])
                        {
                            isSame = false;
                        }
                        tempDataList.Add(dataList[i]);
                    }
                }

                if (isSame)
                {
                    prevPair.TimeSpan = new Interval(tempStart,i+1);
                }
                else
                {
                    pairs.Add(prevPair.Duplicate());
                    prevPair = new TimespanDataPair
                    {
                        TimeSpan = new Interval(i,i+1),
                        Data = new List<double>(tempDataList.ToArray())
                    };
                    tempStart = i;
                    prevDataList = new List<double>(tempDataList.ToArray());
                }

                if (i==count-1)
                {
                    pairs.Add(prevPair.Duplicate());
                }
            }

            return true;
        }
    }
}