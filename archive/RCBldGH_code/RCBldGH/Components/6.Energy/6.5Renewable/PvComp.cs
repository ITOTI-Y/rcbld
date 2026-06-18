using System;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using RCBldGH.Domains;
using RCBldGH.Modules;

namespace RCBldGH.Components.Renewable
{
    public class PvComp:GH_Component
    {
        public PvComp()
            : base("PV", "PV",
                "Building Integrated PV System",
                "RCBldGH", "6.Energy")
        {
        }
        
        public override Guid ComponentGuid => new Guid("{E7C923B0-88D0-4F55-97DB-0CB71F176288}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.pv;
        public override GH_Exposure Exposure => GH_Exposure.senary;


        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddNumberParameter("PV Surface Area", "Area", "unit: m2", GH_ParamAccess.item);
            pManager.AddGenericParameter("PV Orientation", "Orientation", "specify the orientation: S, SE, E, NE, N, NW, W, SW", GH_ParamAccess.item);
            pManager.AddNumberParameter("PV Angle", "Angel", "Degree, must choose from 15, 30, 45, 60, 75, 90", GH_ParamAccess.item);
            pManager.AddGenericParameter("PV Type", "Type", "1. mono crystalline silicona, 2. multi crystalline silicona, 3. thin film amorphous silicon, 4. other thin film layers, 5. thin film copper-indium-gallium-diselenide, 6. thin film cadmium-telloride.", GH_ParamAccess.item);
            pManager.AddGenericParameter("PV Ventilation Type", "Ventilation Type", "1. unventilated modules, 2. moderately ventilated modules, 3. strongly ventilated modules.",
                GH_ParamAccess.item);
            pManager[0].Optional = true;
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("PV", "PV", "Building Integrated PV System", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "PV text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            double area = 0;
            DA.GetData(0, ref area);

            object orientationObj = null;
            if (!DA.GetData(1,ref orientationObj))
            {
                return;
            }

            Orientation orientation;
            try
            {
                orientation = (Orientation) ((GH_ObjectWrapper) orientationObj).Value;
            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error,"Invalid Orientation");
                return;
            }

            double angle = double.NaN;
            if (!DA.GetData(2, ref angle))
            {
                return;
            }

            if (!double.IsNaN(angle))
            {
                bool isOk = false;
                double[] list = { 15, 30, 45, 60, 75, 90 };
                foreach (double d in list)
                {
                    if (angle == d)
                    {
                        isOk = true;
                        break;
                    }
                }
                if (!isOk)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "PV Angle must be 15, 30, 45, 60, 75, 90.");
                    return;
                }
            }


            object pvTypeObj = null;
            if (!DA.GetData(3,ref pvTypeObj))
            {
                return;
            }
            PvType pvType;
            try
            {
                pvType = (PvType) ((GH_ObjectWrapper) pvTypeObj).Value;
            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error,"Invalid PV Type.");
                return;
            }

            object pvVentilationTypeObj = null;
            if (!DA.GetData(4,ref pvVentilationTypeObj))
            {
                return;
            }

            PvVentilationType pvVentilationType;
            try
            {
                pvVentilationType = (PvVentilationType) ((GH_ObjectWrapper) pvVentilationTypeObj).Value;
            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid PV Ventilation Type.");
                return;
            }

            PV pv = new PV
            {
                SurfaceArea = area,
                Orientation = orientation,
                Angle = angle,
                Type = pvType,
                VentilationType = pvVentilationType
            };

            DA.SetData(0, pv);
            DA.SetData(1, pv.ToCen());
        }
    }
}