using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Grasshopper.Kernel.Types.Transforms;
using RCBldGH.Modules;
using Rhino;
using Rhino.Commands;
using Rhino.Geometry;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace RCBldGH.Components
{

    public class BakeComp : GH_Component
    {
       
        public BakeComp() : base("Bake", "DataRecord", "DataRecord", "RCBldGH", "ParametricTool") { }

        public override GH_Exposure Exposure => GH_Exposure.primary;

        public override Guid ComponentGuid => new Guid("{7c862259-6a9e-4537-9c9e-90b9fe5e91a8}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.bake;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddBrepParameter("Data", "D", "Data.", GH_ParamAccess.item);
            pManager.AddIntegerParameter("length", "L", "bake interval", GH_ParamAccess.item);
            pManager.AddIntegerParameter("column number", "C", "column number", GH_ParamAccess.item);
            pManager.AddBooleanParameter("reset", "R", "reset", GH_ParamAccess.item);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddBrepParameter("Result", "Result", "Result", GH_ParamAccess.list);
        }
        public override bool IsBakeCapable => true;

        List<Brep> brep =new List<Brep>();
        int a = 0;
        int b = 0;  
        public override void BakeGeometry(RhinoDoc doc, List<Guid> obj_ids)
        {            
            foreach (var breps in brep) 
            {
                Guid id = doc.Objects.AddBrep(breps);
                obj_ids.Add(id);
            }
        }


        protected override void SolveInstance(IGH_DataAccess DA)
        {
            Brep room = null;
            int length = 0;
            int column = 0;
            DA.GetData(0, ref room);
            DA.GetData(1, ref length);
            DA.GetData(2, ref column);
            
            Transform move= Transform.Translation(a, b, 0);
            room.Transform(move);
            brep.Add(room);
            a += length;
            if (brep.Count > 0)
            {
                if (brep.Count % column == 0)
                {
                    b += length;
                    a = 0;
                }
            }
            bool reset = false;
            DA.GetData(3, ref reset);
            if (reset)
            { 
                brep.Clear();
                a = 0; b = 0;
            }
            List<Brep> breps = brep;
            DA.SetDataList(0, breps);

        }
    
             
       
    }
}

