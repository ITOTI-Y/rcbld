using System;
using System.Collections.Generic;
using Rhino;
using System.Text.RegularExpressions;

namespace RCBldGH.Utils
{
    public static class Converter
    {
        public static string DoubleListToString(List<double> input)
        {
            string result = "";
            for (int i = 0; i < input.Count; i++)
            {
                double item = input[i];
                result += item;
                if (i != input.Count - 1)
                {
                    result += ", ";
                }
            }

            return result;
        }

        public static List<double> StringListToDoubleList(List<string> strings)
        {
            List<double> result = new List<double>();
            try
            {
                for (int i = 0; i < strings.Count; i++)
                {
                    string s = strings[i];
                    var r = Convert.ToDouble(s);
                    result.Add(r);
                }
            }
            catch (Exception )
            {
                throw;
            }

            return result;
        }

        public static int BoolToCenNum(bool value)
        {
            if (value)
            {
                return 1;
            }

            return 2;
        }

        public static double ToMeters(double currentModelUnitNumber)
        {
            double scale = Rhino.RhinoMath.UnitScale(Rhino.RhinoDoc.ActiveDoc.ModelUnitSystem, UnitSystem.Meters);
            return currentModelUnitNumber * scale;
        }

        /// <summary>
        /// 数字转为字符串
        /// </summary>
        /// <param name="number">要转成字符串的数字</param>
        /// <param name="keepDecimals">保留几位小数</param>
        /// <param name="removeEndZero">是否移除末尾的0</param>
        /// <returns></returns>
        public static string DoubleToString(double number, int keepDecimals=2,bool removeEndZero=true)
        {
            if (keepDecimals<0)
            {
                return number.ToString("N");
            }

            if (keepDecimals==0)
            {
                return number.ToString("####");
            }

            if (removeEndZero)
            {
                string replace = "";
                for (int i = 0; i < keepDecimals; i++)
                {
                    replace += "#";
                }
                string format = $"{{0:0.{replace}}}";
                return string.Format(format, number);
            }
             
            return number.ToString("F"+keepDecimals);
        }
    }
}