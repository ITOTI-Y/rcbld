using System;
using Grasshopper.Kernel;

using RCBldGH.Modules;

namespace RCBldGH.Components.Material
{
    public class WindowMaterialComp: GH_Component
    {
        public WindowMaterialComp()
            : base("WindowMaterial", "WindowMaterial",
                "Window material, to be used with the Window componen",
                "RCBldGH", "1.Materials")
        {
        }

        public override Guid ComponentGuid
        {
            get { return new Guid("{CB02B6A1-D788-4ABD-95D6-DBA0D76EBD94}"); }
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.window_material;


        public override GH_Exposure Exposure => GH_Exposure.quarternary;

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Name", "N", "Window material name", GH_ParamAccess.item,"Window");
            pManager.AddNumberParameter("U-Value", "U", "U-Value[W / m²·K）]", GH_ParamAccess.item, 2);
            pManager.AddNumberParameter("Emissivity", "E", "Emissivity", GH_ParamAccess.item,0.6);
            pManager.AddNumberParameter("SHGC", "SHGC", "SHGC", GH_ParamAccess.item,0.3);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Material", "M", "Window material", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;
            double u = -1;
            double e = -1;
            double s = -1;
            if (DA.GetData(0, ref name))
            {
                DA.GetData(1, ref u);
                DA.GetData(2, ref e);
                DA.GetData(3, ref s);

                Modules.Material material = new Modules.Material
                {
                    MaterialType = MaterialType.Window,
                    Name = name,
                    UValue = u,
                    Emissivity = e,
                    SHGC = s,
                };

                DA.SetData(0, material);

            }
        }
    }
}