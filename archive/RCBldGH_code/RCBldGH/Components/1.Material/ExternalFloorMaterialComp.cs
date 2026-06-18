using System;
using Grasshopper.Kernel;
using RCBldGH.Modules;

namespace RCBldGH.Components.Material
{
    public class ExternalFloorMaterialComp: GH_Component
    {
        public ExternalFloorMaterialComp()
            : base("ExternalFloor", "ExternalFloor", "Information of External floor material, to be used with the MaterialSetting component", "RCBldGH", "1.Materials")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.exfloor;
        public override Guid ComponentGuid
        {
            get { return new Guid("{6ABC9256-9361-49CC-9240-977A236607EC}"); }
        }

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Name", "N", "External floor material name", GH_ParamAccess.item,"ExternalFloor");
            pManager.AddNumberParameter("U-Value", "U", "U-Value[W / m²·K）]", GH_ParamAccess.item,3);
        }
        public override GH_Exposure Exposure => GH_Exposure.tertiary;
        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Material", "M", "InternalFloor material", GH_ParamAccess.item);
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
                    MaterialType = MaterialType.ExternalFloor,
                    Name = name,
                    UValue = u,
                };

                DA.SetData(0, material);

            }
        }
    }
}