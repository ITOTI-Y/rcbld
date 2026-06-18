using System;
using Grasshopper.Kernel;
using RCBldGH.Modules;

namespace RCBldGH.Components.Material
{
    public class ExternalWallMaterialComp : GH_Component
    {
        public ExternalWallMaterialComp()
            : base("ExternalWallMaterial", "ExternalWallMaterial",
                "Information of External wall material, to be used with the MaterialSetting componen",
                "RCBldGH", "1.Materials")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.exwall;
        public override Guid ComponentGuid
        {
            get { return new Guid("{E8954AAE-19F4-4BD3-A5A4-03EEE657B3DD}"); }
        }

        public override GH_Exposure Exposure => GH_Exposure.secondary;
        double a = 0.6;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Name", "N", "External wall material name", GH_ParamAccess.item,"ExternalWall");
            pManager.AddNumberParameter("U-Value", "U", "U-Value[W / m²·K）]", GH_ParamAccess.item,3);
            pManager.AddNumberParameter("Absorption coefficient", "AC", "Absorption coefficient", GH_ParamAccess.item,a);
            pManager.AddNumberParameter("Emissivity", "E", "Emissivity", GH_ParamAccess.item,1-a);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Material", "M", "InternalWall material", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;
            double u = -1;
            double ac = -1;
            double e = -1;
            if (DA.GetData(0, ref name) )
            {
                DA.GetData(1, ref u);
                DA.GetData(2, ref ac);
                DA.GetData(3, ref e);

                Modules.Material material = new Modules.Material
                {
                    MaterialType = MaterialType.ExternalWall,
                    Name = name,
                    UValue = u,
                    AbsorptionCoefficient = ac,
                    Emissivity = e
                };

                DA.SetData(0, material);

            }
        }
    }
}