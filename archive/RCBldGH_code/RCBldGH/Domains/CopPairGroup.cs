using System.Collections.Generic;
using System.Linq;

namespace RCBldGH.Domains
{
    public class CopPairGroup
    {
        public Dictionary<int ,double> Dictionary { get; set; }
        public static IOrderedEnumerable<KeyValuePair<int, double>> DictionarySort(Dictionary<int, double> dic)
        {
            var dicSort = from objDic in dic orderby objDic.Key descending select objDic;
            return dicSort;
        }

        public override string ToString()
        {
            var data = DictionarySort(Dictionary);
            string result = "";
            foreach (var pair in data)
            {
                result += $"COP{pair.Key}: {pair.Value}\r\n";
            }

            return result;
        }
    }
}