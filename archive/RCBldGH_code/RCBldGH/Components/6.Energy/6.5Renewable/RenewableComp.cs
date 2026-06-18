using System;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Renewable
{
    public class RenewableComp: GH_Component
    {
        public RenewableComp()
            : base("Building Renewable System", "Renewable",
                "Building Renewable System",
                "RCBldGH", "6.Energy")
        {
        }

        public override GH_Exposure Exposure => GH_Exposure.quinary;

        public override Guid ComponentGuid => new Guid("{80C92884-ED59-4B7E-A8E7-0784A9AA2017}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.renewable_energy;
        protected override void RegisterInputParams(GH_Component.GH_InputParamManager pManager)
        {
            pManager.AddGenericParameter("PV System", "PV", "Building integrated PV System", GH_ParamAccess.item);
            pManager.AddGenericParameter("Solar Water Heating System", "SWH", "Solar Water Heating System", GH_ParamAccess.item);
            pManager.AddGenericParameter("Wind Turbines", "WT", "Wind Turbines", GH_ParamAccess.item);

        }

        protected override void RegisterOutputParams(GH_Component.GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Renewable System", "R", "Building Renewable System", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Renewable System Text", GH_ParamAccess.item);
        }


        protected override void SolveInstance(IGH_DataAccess DA)
        {
            object pvObj = null;
            object swhObj = null;
            object wtObj = null;
            PV pv = null;
            SWH swh = null;
            WindTurbines wt = null;

            try
            {
                if (DA.GetData(0, ref pvObj) && pvObj != null)
                {
                    pv = (PV)((GH_ObjectWrapper)pvObj).Value;
                }
            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid PV");
            }

            try
            {
                if (DA.GetData(1, ref swhObj) && swhObj != null)
                {
                    swh = (SWH)((GH_ObjectWrapper)swhObj).Value;
                }

            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid DHW");
            }

            try
            {
                if (DA.GetData(2,ref wtObj)&&wtObj!=null)
                {
                    wt = (WindTurbines) ((GH_ObjectWrapper) wtObj).Value;
                }
            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Wind Turbines");
            }

            if (pv!=null&& swh!=null&& wt!=null)
            {
                Modules.Renewable r = new Modules.Renewable
                {
                    Pv = pv,
                    Swh = swh,
                    WindTurbines = wt
                };
                DA.SetData(0, r);
                DA.SetData(1, r.ToCen());
            }
        }
    }
}