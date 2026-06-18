using System;
using Grasshopper.Kernel;
using RCBldGH.Modules;

namespace RCBldGH.Components.Material
{
    public class GroundMaterialComp : GH_Component
    {
        public GroundMaterialComp()
            : base("GroundMaterial", "GroundMaterial",
                "Ground material, to be used with the MaterialSetting componen",
                "RCBldGH", "1.Materials")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.tertiary;
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.ground;
        public override Guid ComponentGuid
        {
            get { return new Guid("{58F0604C-4DBC-4A71-A8BE-3BF8BE59FE9C}"); }
        }

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Name", "N", "Ground material name", GH_ParamAccess.item,"Ground");
            pManager.AddNumberParameter("U-Value", "U", "U-Value[W / m²·K）]", GH_ParamAccess.item, 3);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Material", "M", "Ground material", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;
            double u = -1;

            if (DA.GetData(0, ref name))
            {
                DA.GetData(1, ref u);


                Modules.Material material = new Modules.Material
                {
                    MaterialType = MaterialType.Ground,
                    Name = name,
                    UValue = u,
                };

                DA.SetData(0, material);

            }
        }
    }
}