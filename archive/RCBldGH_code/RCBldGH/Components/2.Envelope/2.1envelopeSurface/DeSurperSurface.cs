using Grasshopper.Kernel;
using RCBldGH.Modules;
using RCBldGH.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Rhino.Geometry.Collections;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Components.Material;
using Grasshopper;
using Grasshopper.Kernel.Data;
using System.IO;
using Rhino;
using Grasshopper.Kernel.Geometry.Delaunay;
using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;
using Rhino.Render;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace RCBldGH.Components.Envelope.envelopeSurface
{
    public class DeconstructEnvelopComp : GH_Component
    {
        public DeconstructEnvelopComp() : base("DeconstructEnvelop", "DeconstructEnvelop", "DeconstructEnvelop", "RCBldGH", "2.Envelops")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.obscure;
        public override Guid ComponentGuid => new Guid("{95150ac8-eeb7-42d2-be45-437a41986b2c}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.MSettingAssign;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {            
            
            pManager.AddGenericParameter("SuperSurface", "Windows", "Windows objects.", GH_ParamAccess.item);            
        }
        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            OpaqueParam opaqueParam = new OpaqueParam();
            SlabParam slabParam = new SlabParam();  
            //pManager.AddParameter(opaqueParam, "opaqueParam", "name", "name", GH_ParamAccess.item);
            //pManager.AddParameter(slabParam, "slabParam", "setting", "Envelope setting", GH_ParamAccess.item);
            pManager.AddTextParameter("Name", "setting", "Envelope setting", GH_ParamAccess.item);
            pManager.AddTextParameter("Id", "setting", "Envelope setting", GH_ParamAccess.item);
            pManager.AddTextParameter("Type", "setting", "Envelope setting", GH_ParamAccess.item);
            pManager.AddBrepParameter("SurfaceType", "setting", "Envelope setting", GH_ParamAccess.item);
            pManager.AddTextParameter("MaterialType", "setting", "Envelope setting", GH_ParamAccess.item);
        }
        protected override void SolveInstance(IGH_DataAccess DA)
        {
            SuperSurface envelopeSettingGoos = new SuperSurface();
            DA.GetData(0, ref envelopeSettingGoos);

            DA.SetData(0, envelopeSettingGoos.Name);
            DA.SetData(3, envelopeSettingGoos.GH_Surface);
            DA.SetData(1, envelopeSettingGoos.Id);
            DA.SetData(2, $"{envelopeSettingGoos.Material}");
            DA.SetData(4, $"{envelopeSettingGoos}");

        }
           
    }
}

           

        
            

            

            