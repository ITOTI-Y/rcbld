using System;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using RCBldGH.Domains;
using RCBldGH.Modules;

namespace RCBldGH.Components.Renewable
{
    public class WindTurbinesComp:GH_Component
    {
        public WindTurbinesComp()
            : base("Wind Turbine", "Wind Turbine",
                "Wind Turbine",
                "RCBldGH", "6.Energy")
        {
        }

        public override Guid ComponentGuid => new Guid("{71B884A1-550F-47D3-B51E-6D25875A89AD}");
        public override GH_Exposure Exposure => GH_Exposure.quinary;
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.wind;

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddIntegerParameter("Number", "N", "Wind Turbine Number", GH_ParamAccess.item,0); 
            pManager.AddNumberParameter("Diameter", "D", "unit: m", GH_ParamAccess.item);
            pManager.AddNumberParameter("Efficiency", "E", "Wind Turbine Efficiency", GH_ParamAccess.item);
            pManager[0].Optional = true;
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Wind Turbines", "W", "Wind Turbines", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Wind Turbines Text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            int number = 0;
            double diameter = double.NaN;
            double efficiency = double.NaN;
            if (!DA.GetData(0,ref number)||!DA.GetData(1,ref diameter)||!DA.GetData(2,ref efficiency))
            {
                return;
            }
            WindTurbines turbines = new WindTurbines
            {
                Number = number,
                Diameter = diameter,
                Efficiency = efficiency
            };

            DA.SetData(0, turbines);
            DA.SetData(1, turbines.ToCen());
        }
    }
}