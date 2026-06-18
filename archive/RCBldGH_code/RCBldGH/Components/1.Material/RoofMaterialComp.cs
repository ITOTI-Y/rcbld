using System;
using Grasshopper.Kernel;
using RCBldGH.Modules;

namespace RCBldGH.Components.Material
{
    public class RoofMaterialComp:GH_Component
    {
        public RoofMaterialComp()
            : base("RoofMaterial", "RoofMaterial",
                "Roof material, to be used with the MaterialSetting componen",
                "RCBldGH", "1.Materials")
        {
        }
        public override Guid ComponentGuid
        {
            get { return new Guid("{23D55352-DE60-4862-9E0B-2F622F040B5D}"); }
        }

        public override GH_Exposure Exposure => GH_Exposure.primary;
        double a = 0.4;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Name", "N", "Roof material name", GH_ParamAccess.item,"Roof");
            pManager.AddNumberParameter("U-Value", "U", "U-Value[W / m²·K）]", GH_ParamAccess.item, 3);
            pManager.AddNumberParameter("Absorption coefficient", "AC", "Absorption coefficient", GH_ParamAccess.item,a);
            pManager.AddNumberParameter("Emissivity", "E", "Emissivity", GH_ParamAccess.item,1-a);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Material", "M", "Roof material", GH_ParamAccess.item);
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.roofmaterial;
        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;
            double u = -1;
            double ac = -1;
            double e = -1;
            if (DA.GetData(0, ref name))
            {
                DA.GetData(1, ref u);
                DA.GetData(2, ref ac);
                DA.GetData(3, ref e);

                Modules.Material material = new Modules.Material()
                {
                    MaterialType = MaterialType.Roof,
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