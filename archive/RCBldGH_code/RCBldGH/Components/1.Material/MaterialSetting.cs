using Grasshopper.Kernel;
using Rhino.Render.ChangeQueue;
using RCBldGH.Modules;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RCBldGH.Components.Material
{
     public class MaterialSettingComp : GH_Component
        {
            public MaterialSettingComp() : base("MaterialSetting", "MaterialSetting", "set the room material set,using roof material/externalfloormaterial etc, to be used with the MaterialAssign componen", "RCBldGH", "1.Materials")
            {
            }

            public override Guid ComponentGuid
            {
                get { return new Guid("{9cd7bdc4-e491-4cfe-86c0-07b622138c29}"); }
            }

        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.mSetting;


        public override GH_Exposure Exposure => GH_Exposure.quinary;

            protected override void RegisterInputParams(GH_InputParamManager pManager)
            {
            //pManager.AddTextParameter ("Name", "N", "just a name of this material setting", GH_ParamAccess.item);
            pManager.AddGenericParameter("RoofMaterial", "M", "Opaque Material", GH_ParamAccess.item);
            pManager.AddGenericParameter("ExternalWallMaterial", "M", "Opaque Material", GH_ParamAccess.item);
            pManager.AddGenericParameter("InternalWallMaterial", "M", "Opaque Material", GH_ParamAccess.item);
            
            pManager.AddGenericParameter("ExternalFloorMaterial", "M", "Opaque Material", GH_ParamAccess.item);
            pManager.AddGenericParameter("InternalFloorMaterial", "M", "Opaque Material", GH_ParamAccess.item);
            pManager.AddGenericParameter("GroundMaterial", "M", "Opaque Material", GH_ParamAccess.item);
            }

            protected override void RegisterOutputParams(GH_OutputParamManager pManager)
            {
                pManager.AddGenericParameter("MaterialSetting", "MSetting", "material setting for a zone", GH_ParamAccess.item);
            }

            protected override void SolveInstance(IGH_DataAccess DA)
            {
            Modules.Material roofMaterial = new Modules.Material(); 
            Modules.Material externalWallMaterial = new Modules.Material(); 
            Modules.Material internalWallMaterial = new Modules.Material();            
            Modules.Material externalFloorMaterial = new Modules.Material();
            Modules.Material internalFloorMaterial = new Modules.Material();
            Modules.Material groundMaterial = new Modules.Material();
            //string name=null;

           //DA.GetData(0, ref name);
            DA.GetData("RoofMaterial", ref roofMaterial);
            DA.GetData("ExternalWallMaterial", ref externalWallMaterial);            
            DA.GetData("InternalWallMaterial", ref internalWallMaterial);            
            DA.GetData("ExternalFloorMaterial", ref externalFloorMaterial); 
            DA.GetData("InternalFloorMaterial", ref internalFloorMaterial);
            if (!DA.GetData("GroundMaterial", ref groundMaterial))
            { groundMaterial = null; }
            

            MaterialSetting materialSetting = new MaterialSetting ();
            materialSetting.RoofMaterial = roofMaterial;
            materialSetting.ExternalWallMaterial = externalWallMaterial;
            materialSetting.InternalWallMaterial = internalWallMaterial;
            
            materialSetting.ExternalFloorMaterial = externalFloorMaterial;
            materialSetting.InternalFloorMaterial = internalFloorMaterial;
            materialSetting.GroundMaterial = groundMaterial;
            //materialSetting.Name=name;

            DA.SetData(0, materialSetting);             
            }
        }
    }


