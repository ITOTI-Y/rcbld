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
    public class DeSuperComp : GH_Component
    {
        public DeSuperComp() : base("DeSuper", "DeconstructEnvelop", "DeconstructEnvelop", "RCBldGH", "2.Envelops")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.obscure;
        public override Guid ComponentGuid => new Guid("{2ce2aa07-40a0-4252-ac92-df245b181483}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.MSettingAssign;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {            
            EnvelopSurfaceParam windowParam = new EnvelopSurfaceParam();
            pManager.AddParameter(windowParam, "Envelop", "Windows", "Windows objects.", GH_ParamAccess.item);            
        }
        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            EnvelopSurfaceParam opaqueParam = new EnvelopSurfaceParam();
            pManager.AddParameter(opaqueParam, "opaqueParam", "name", "name", GH_ParamAccess.item);
            pManager.AddSurfaceParameter( "surface", "name", "name", GH_ParamAccess.item);
            pManager.AddGenericParameter("surface", "name", "name", GH_ParamAccess.item);

        }
        protected override void SolveInstance(IGH_DataAccess DA)
        {
            EnvelopeSettingGoo envelopeSettingGoos = new EnvelopeSettingGoo();
            DA.GetData(0, ref envelopeSettingGoos);

            SuperSurface a = new SuperSurface(envelopeSettingGoos.Value.Opaques[0].GeometrySurface);

            DA.SetData(0, a.EnvelopeSetting);
            DA.SetData(1, a.GH_Surface);
            DA.SetData(2, a.Surface);
        }
           
    }
}

           

        
            

            

            