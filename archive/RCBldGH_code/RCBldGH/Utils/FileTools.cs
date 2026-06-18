using System;
using System.Collections.Generic;
using System.IO;
using Microsoft.VisualBasic.FileIO;

namespace RCBldGH.Utils
{
    public class FileTools
    {
        public static void SaveTextToFile(string path, string text)
        {
            File.WriteAllText(path,text);
        }

        /// <summary>
        /// 读取 CSV 文件，返回值为读取的
        /// </summary>
        /// <param name="path"></param>
        /// <param name="titles"></param>
        /// <returns></returns>
        public static List<List<string>> ReadCsv(string path,out List<string> titles)
        {
            List<List<string>> fieldsList = new List<List<string>>();
            titles = new List<string>();
            using (TextFieldParser parser = new TextFieldParser(path))
            {
                parser.TextFieldType = FieldType.Delimited;
                parser.SetDelimiters(",");
                int i = 0;
                while (!parser.EndOfData)
                {
                    string[] fields = parser.ReadFields();
                    if (i==0)
                    {
                        foreach (var field in fields)
                        {
                            titles.Add(field);
                        }

                        i++;
                        continue;
                    }

                    List<string> dataList = new List<string>();
                    foreach (var field in fields)
                    {
                        dataList.Add(field);
                    }
                    fieldsList.Add(dataList);
                    i++;
                }
            }
            List<List<string>> columnLists = new List<List<string>>();
            for (int i = 0; i < titles.Count; i++)
            {
                List<string> dataList = new List<string>();
                foreach (var rowList in fieldsList)
                {
                    dataList.Add(rowList[i]);
                }
                columnLists.Add(dataList);
            }

            return columnLists;
        }


    }


}