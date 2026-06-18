using System;
using Grasshopper.Kernel;
using RCBldGH.Modules;

namespace RCBldGH.Components.Material
{
    public class InternalFloorMaterialComp: GH_Component
    {
        public InternalFloorMaterialComp()
            : base("InternalFloor", "InternalFloor",
                "Internal floor material, to be used with the MaterialSetting componen",
                "RCBldGH", "1.Materials")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.tertiary;
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.interfloor;
        public override Guid ComponentGuid
        {
            get { return new Guid("{D00EE9E8-6DD6-4447-BBB6-75A3180B9FCB}"); }
        }
        
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Name", "N", "Internal floor material name", GH_ParamAccess.item,"InternalFloor");
            pManager.AddNumberParameter("U-Value", "U", "U-Value[W / m²·K）]", GH_ParamAccess.item, 3);
        }

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
                    MaterialType = MaterialType.InternalFloor,
                    Name = name,
                    UValue = u,
                };

                DA.SetData(0, material);

            }
        }
    }
}