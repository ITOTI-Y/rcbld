using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Parameters;
using Grasshopper.Kernel.Types;
using Microsoft.VisualBasic;
using SimBldPyUI.Modules;
using SimBldPyUI.Utils;

namespace SimBldPyUI.Components.Reader
{
    public class HourDataReaderComp:GH_Component
    {
        public HourDataReaderComp()
            : base("Hours Data Reader", "Hours Data Reader",
                "Hours Data Reader",
                "SimBldPy", "Reader")
        {
        }
        protected override System.Drawing.Bitmap Icon => SimBldPyUI.Properties.Resources.csv;
        public override Guid ComponentGuid => new Guid("{812A3BF8-F72C-48E8-8B25-D2FAAF6B8176}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            Param_FilePath path = new Param_FilePath();
            pManager.AddParameter(path, "CSV File", "F", " .csv file.",
                GH_ParamAccess.item);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddTextParameter("Time range", "T", "Time range", GH_ParamAccess.item);
            pManager.AddNumberParameter("Outdoor Temperature", "OT", "Outdoor Temperature", GH_ParamAccess.list);
            pManager.AddNumberParameter("Lighting Energy", "LE", "Lighting Energy", GH_ParamAccess.list);
            pManager.AddNumberParameter("Equipment Energy", "EE", "Equipment Energy", GH_ParamAccess.list);
            pManager.AddNumberParameter("q_sol_w", "q_sol_w", "q_sol_w", GH_ParamAccess.list);
            pManager.AddNumberParameter("q_sol", "q_sol", "q_sol", GH_ParamAccess.list);
            pManager.AddNumberParameter("q_H_nd", "q_H_nd", "q_H_nd", GH_ParamAccess.list);
            pManager.AddNumberParameter("q_C_nd", "q_C_nd", "q_C_nd", GH_ParamAccess.list);
            pManager.AddNumberParameter("heat_energy", "heat_energy", "heat_energy", GH_ParamAccess.list);
            pManager.AddNumberParameter("cool_energy", "cool_energy", "cool_energy", GH_ParamAccess.list);
            pManager.AddNumberParameter("DHW_energy", "DHW_energy", "DHW_energy", GH_ParamAccess.list);
            pManager.AddNumberParameter("pump_energy", "pump_energy", "pump_energy", GH_ParamAccess.list);
            pManager.AddNumberParameter("fan_energy", "fan_energy", "fan_energy", GH_ParamAccess.list);
            pManager.AddNumberParameter("total_electricity", "total_electricity", "total_electricity", GH_ParamAccess.list);
            pManager.AddNumberParameter("total_gas", "total_gas", "total_gas", GH_ParamAccess.list);
            pManager.AddNumberParameter("SWH_production", "SWH_production", "SWH_production", GH_ParamAccess.list);
            pManager.AddNumberParameter("PV_production", "PV_production", "PV_production", GH_ParamAccess.list);
            pManager.AddNumberParameter("wind_production", "wind_production", "wind_production", GH_ParamAccess.list);
            pManager.AddNumberParameter("PMV", "PMV", "PMV", GH_ParamAccess.list);
            pManager.AddNumberParameter("occupants", "occupants", "occupants", GH_ParamAccess.list);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string path = string.Empty;
            if (!DA.GetData(0, ref path))
            {
                return;
            }

            if (!File.Exists(path))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "File is not a existed file. ");
                return;
            }

            string extension = Path.GetExtension(path);
            if (extension.ToLower() != ".csv")
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "File is not a *.csv file.");
                return;
            }

            List<string> titles = new List<string>();
            var colDataLists =  FileTools.ReadCsv(path, out titles);

            if (titles.Count!=24|| titles[4]!="hour"||titles[3]!="day"||titles[2]!= "month"||titles[1]!="year")
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "The .csv file is not a supported file.");
                return;
            }

            try
            {
                int startYear = Convert.ToInt32(colDataLists[1][0]);
                int startMonth = Convert.ToInt32(colDataLists[2][0]);
                int startDay = Convert.ToInt32(colDataLists[3][0]);
                int startHour = Convert.ToInt32(colDataLists[4][0]);
                DateTime start = new DateTime(startYear, startMonth, startDay, startHour, 0, 0);
                int endYear = Convert.ToInt32(colDataLists[1].Last());
                int endMonth = Convert.ToInt32(colDataLists[2].Last());
                int endDay = Convert.ToInt32(colDataLists[3].Last());
                int endHour = Convert.ToInt32(colDataLists[4].Last());
                DateTime end = new DateTime(endYear, endMonth, endDay, endHour, 0, 0);

                string rangeStr = $"From: {start} \nTo: {end}";

                DA.SetData(0, rangeStr);
                DA.SetDataList(1, Converter.StringListToDoubleList(colDataLists[5]));
                DA.SetDataList(2, Converter.StringListToDoubleList(colDataLists[6]));
                DA.SetDataList(3, Converter.StringListToDoubleList(colDataLists[7]));
                DA.SetDataList(4, Converter.StringListToDoubleList(colDataLists[8]));
                DA.SetDataList(5, Converter.StringListToDoubleList(colDataLists[9]));
                DA.SetDataList(6, Converter.StringListToDoubleList(colDataLists[10]));
                DA.SetDataList(7, Converter.StringListToDoubleList(colDataLists[11]));
                DA.SetDataList(8, Converter.StringListToDoubleList(colDataLists[12]));
                DA.SetDataList(9, Converter.StringListToDoubleList(colDataLists[13]));
                DA.SetDataList(10, Converter.StringListToDoubleList(colDataLists[14]));
                DA.SetDataList(11, Converter.StringListToDoubleList(colDataLists[15]));
                DA.SetDataList(12, Converter.StringListToDoubleList(colDataLists[16]));
                DA.SetDataList(13, Converter.StringListToDoubleList(colDataLists[17]));
                DA.SetDataList(14, Converter.StringListToDoubleList(colDataLists[18]));
                DA.SetDataList(15, Converter.StringListToDoubleList(colDataLists[19]));
                DA.SetDataList(16, Converter.StringListToDoubleList(colDataLists[20]));
                DA.SetDataList(17, Converter.StringListToDoubleList(colDataLists[21]));
                DA.SetDataList(18, Converter.StringListToDoubleList(colDataLists[22]));
                DA.SetDataList(19, Converter.StringListToDoubleList(colDataLists[23]));
            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "No data was read.");
                return;
            }

        }
    }
}