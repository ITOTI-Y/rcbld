using System;
using System.Collections.Generic;
using System.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using RCBldGH.Modules;
using RCBldGH.Utils;

namespace RCBldGH.Components.Envelope
{
    public class EnvelopeSurfaceComp : GH_Component
    {
        public EnvelopeSurfaceComp()
            : base("Envelope Surface Creator", "EnvSurCreator","Create Envelop surface(s)","RCBldGH", "2.Envelops")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.envelopSurface;
        public override GH_Exposure Exposure => GH_Exposure.senary;

        public override Guid ComponentGuid => new Guid("{12127189-97B8-4504-9196-0A489D56324C}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Surface Name", "Surface Name", "Specify the envelope setting name", GH_ParamAccess.item);

            OpaqueParam opaqueParam = new OpaqueParam();
            pManager.AddParameter(opaqueParam, "Opaques", "Opaques", "Opaque objects.",GH_ParamAccess.list);

            WindowParam windowParam = new WindowParam();
            pManager.AddParameter(windowParam, "Windows", "Windows", "Windows objects.", GH_ParamAccess.list);

            pManager[1].Optional = true;
            pManager[2].Optional = true;
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            EnvelopSurfaceParam es = new EnvelopSurfaceParam();
            pManager.AddParameter(es, "Envelope setting", "setting", "Envelope setting", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Envelop surface text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;

            List<OpaqueGoo> opaques = new List<OpaqueGoo>();
            List<WindowGoo> windows = new List<WindowGoo>();

            DA.GetData(0, ref name);

            // 读取并判断所有 opaque 是否为平面
            if (DA.GetDataList(1, opaques))
            {
                foreach (var opaque in opaques)
                {
                    if (!SurfaceTools.IsGhSurfacePlaner(opaque.Value.GeometrySurface))
                    {
                        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Opaque 1 must be planer surface.");
                        return;
                    }
                }
            }

            DA.GetDataList(2, windows);
            
            // 建立 EnvelopeSetting 实例
            EnvelopeSetting es = new EnvelopeSetting()
            {
                EnvelopeType = EnvelopeType.Opaque,                
            };
            if (opaques.Count>0)
            {
                es.Opaques = opaques.Select(opaque => opaque.Value).ToList();
            }

            if (windows.Count>0)
            {
                es.Windows = windows.Select(window => window.Value).ToList();
            }
            
            var result = new EnvelopeSettingGoo { Value = es };
            DA.SetData(0, result);
            DA.SetData(1, es.ToCen());
        }
    }
}