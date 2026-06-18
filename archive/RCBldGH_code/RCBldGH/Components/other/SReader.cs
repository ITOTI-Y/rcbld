using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Parameters;
using Grasshopper.Kernel.Types;
using Rhino;
using RCBldGH.Modules;
using Grasshopper;
using Grasshopper.Kernel.Data;

namespace RCBldGH.Components
{
    public class SReader:GH_Component
    {
        public SReader()
            : base("Name Creator", "Names",
                "Create a set of names by a prefix and incremental indexes.",
                "RCBldGH", "Others")
        {
        }
        
        public override Guid ComponentGuid => new Guid("{b56da4d5-8d4f-4154-bc4c-212a6cc0735a}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddGenericParameter("Datas", "D", "Data", GH_ParamAccess.tree);
            pManager.AddNumberParameter("Roomnumber", "n", "n", GH_ParamAccess.item);
            pManager.AddNumberParameter("Facenumber", "n", "n", GH_ParamAccess.item);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddNumberParameter("data", "D", "datas", GH_ParamAccess.list);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            DataTree<List<double>> data = new DataTree<List<double>> { };
            
          

        }
    }
}