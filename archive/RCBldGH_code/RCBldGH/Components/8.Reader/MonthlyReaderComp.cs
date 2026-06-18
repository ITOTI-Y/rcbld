using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Grasshopper;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using Grasshopper.Kernel.Parameters;
using RCBldGH.Utils;

namespace RCBldGH.Components.Reader
{
    public class MonthlyReaderComp:GH_Component
    {
        public MonthlyReaderComp()
            : base("Monthly CSV Reader", "Monthly CSV Reader",
                "Monthly CSV Reader",
                "RCBldGH", "8.Reader")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.monthly_reader;
        public override Guid ComponentGuid => new Guid("{B3FBA52D-600F-468C-B751-992D6928AAAD}");

        protected override void RegisterInputParams(GH_Component.GH_InputParamManager pManager)
        {
            Param_FilePath path = new Param_FilePath();
            pManager.AddParameter(path, "CSV File", "F", " .csv file.",
                GH_ParamAccess.item);
        }

        protected override void RegisterOutputParams(GH_Component.GH_OutputParamManager pManager)
        {
            pManager.AddTextParameter("outdoor temperature", "T", "outdoor temperature", GH_ParamAccess.list);
            pManager.AddTextParameter("heat transfer window", "heat transfer window", "heat transfer window", GH_ParamAccess.list);
            pManager.AddTextParameter("heat_transfer_wall", "T", "titles", GH_ParamAccess.list);
            pManager.AddTextParameter("heat_transfer_infiltration", "T", "titles", GH_ParamAccess.list);
            pManager.AddTextParameter("heat_transfer_natural_vent", "T", "titles", GH_ParamAccess.list);
            pManager.AddTextParameter("heating_load", "T", "titles", GH_ParamAccess.list);
            pManager.AddTextParameter("cooling_load", "T", "titles", GH_ParamAccess.list);
            pManager.AddTextParameter("lighting_energy", "T", "titles", GH_ParamAccess.list);
            pManager.AddTextParameter("equipment_energy", "T", "titles", GH_ParamAccess.list);
            pManager.AddTextParameter("heat_energy", "T", "titles", GH_ParamAccess.list);
            pManager.AddTextParameter("cool_energy", "T", "titles", GH_ParamAccess.list);
            pManager.AddTextParameter("DHW_energy", "T", "Data", GH_ParamAccess.list);
            pManager.AddTextParameter("pump_energy", "T", "Data", GH_ParamAccess.list);
            pManager.AddTextParameter("fan_energy", "T", "Data", GH_ParamAccess.list);
            pManager.AddTextParameter("total_electricity", "T", "Data", GH_ParamAccess.list);
            pManager.AddTextParameter("total_district_cooling", "T", "Data", GH_ParamAccess.list);
            pManager.AddTextParameter("total_district_heating", "T", "Data", GH_ParamAccess.list);
            pManager.AddTextParameter("SWH_production", "T", "Data", GH_ParamAccess.list);
            pManager.AddTextParameter("PV_production", "T", "Data", GH_ParamAccess.list);
            pManager.AddTextParameter("wind_production", "T", "Data", GH_ParamAccess.list);
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
            var colDataLists = FileTools.ReadCsv(path, out titles);

            try
            {
                DataTree<string> tree =new DataTree<string>();
                for (int i = 0; i < colDataLists.Count; i++)
                {
                    GH_Path p = new GH_Path(i);
                    foreach (string s in colDataLists[i])
                    {
                        tree.Add(s,p);
                    }
                }
                for (int i = 1; i < colDataLists.Count; i++)
                {
                    GH_Path p = tree.Path(i);
                    DA.SetDataList(i-1, tree.Branch(p));
                }
                    
                
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "No data was read.");
                return;
            }

        }
    }
}