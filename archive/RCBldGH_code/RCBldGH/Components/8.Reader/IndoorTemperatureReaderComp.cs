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
    public class IndoorTemperatureReaderComp:GH_Component
    {
        public IndoorTemperatureReaderComp()
            : base("Indoor Temperature CSV Reader", "Indoor Temperature CSV Reader",
                "Indoor Temperature CSV Reader",
                "RCBldGH", "8.Reader")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.indoor_temperature_reader;
        public override Guid ComponentGuid => new Guid("{f46363da-53a4-4ff2-8885-80eefc32c549}");

        protected override void RegisterInputParams(GH_Component.GH_InputParamManager pManager)
        {
            Param_FilePath path = new Param_FilePath();
            pManager.AddParameter(path, "CSV File", "F", " .csv file.",
                GH_ParamAccess.item);
        }

        protected override void RegisterOutputParams(GH_Component.GH_OutputParamManager pManager)
        {
         pManager.AddTextParameter("heat transfer window", "heat transfer window", "heat transfer window", GH_ParamAccess.tree);
            
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
                for (int i = 1; i < colDataLists.Count; i++)
                {
                    GH_Path p = new GH_Path(i-1);
                    foreach (string s in colDataLists[i])
                    {
                        tree.Add(s,p);
                    }
                }
                DA.SetDataTree(0, tree);




            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "No data was read.");
                return;
            }

        }
    }
}