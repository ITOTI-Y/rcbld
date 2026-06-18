using System;
using Grasshopper.Kernel;
using RCBldGH.Modules;

namespace RCBldGH.Components.Material
{
    public class InternalWallMaterialComp:GH_Component
    {
        public InternalWallMaterialComp()
            : base("InternalWallMaterial", "InternalWallMaterial",
                "Internal wall material, to be used with the MaterialSetting componen",
                "RCBldGH", "1.Materials")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.interwall;
        public override Guid ComponentGuid
        {
            get { return new Guid("{228AA8CE-86C1-4345-8566-26970765B557}"); }
        }

        public override GH_Exposure Exposure => GH_Exposure.secondary;
        double a=0.6;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Name", "N", "Internal wall material name", GH_ParamAccess.item,"InternalWall");
            pManager.AddNumberParameter("U-Value", "U", "U-Value[W / m²·K）]", GH_ParamAccess.item, 3);
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
            if (DA.GetData(0, ref name))
            {
                DA.GetData(1, ref u);
                DA.GetData(2, ref ac);
                DA.GetData(3, ref e);

                Modules.Material material = new Modules.Material
                {
                    MaterialType = MaterialType.InternalWall,
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