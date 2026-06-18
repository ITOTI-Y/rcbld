using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Parameters;
using Grasshopper.Kernel.Types;
using Rhino;
using RCBldGH.Modules;

namespace RCBldGH.Components
{
    public class NameCreator:GH_Component
    {
        public NameCreator()
            : base("Name Creator", "Names",
                "Create a set of names by a prefix and incremental indexes.",
                "RCBldGH", "Others")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.name;
        public override GH_Exposure Exposure => GH_Exposure.hidden;
        public override Guid ComponentGuid => new Guid("{CB2D6C70-043E-4107-8B66-991982A1B491}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Prefix", "P", "Name prefix", GH_ParamAccess.item);
            pManager.AddIntegerParameter("Count", "C", "Count", GH_ParamAccess.item,10);
            pManager.AddIntegerParameter("Start", "S", "Start index, default is 1", GH_ParamAccess.item, 1);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddTextParameter("Names", "N", "Names", GH_ParamAccess.list);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string prefix = string.Empty;
            int count = 0;
            int index = 1;
            if (!DA.GetData(0,ref prefix)||!DA.GetData(1,ref count)||!DA.GetData(2,ref index))
            {
                return;
            }
            List<string> names = new List<string>();
            for (int i = 0; i < count; i++)
            {
                string name = prefix + index;
                names.Add(name);
                index ++;
            }

            DA.SetDataList(0, names);

        }
    }
}