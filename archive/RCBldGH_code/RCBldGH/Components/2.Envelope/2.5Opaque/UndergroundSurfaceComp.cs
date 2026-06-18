using System;
using System.Collections.Generic;
using System.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Rhino;
using Rhino.Geometry;
using RCBldGH.Modules;
using RCBldGH.Utils;

namespace RCBldGH.Components.Envelope
{
    public class UndergroundSurfaceComp: GH_Component
    {
        public UndergroundSurfaceComp()
            : base("UndergroundSurface", "UndergroundSurface",
                "Underground surface",
                "RCBldGH", "2.Envelops")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.senary;
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.undergroundwall;
        public override Guid ComponentGuid => new Guid("{12099DB5-D08F-46D6-8F29-644FF2D9DAA6}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Surface Name", "N", "Surface name", GH_ParamAccess.item);

            OpaqueParam opaqueParam = new OpaqueParam();
            pManager.AddParameter(opaqueParam, "Opaques", "O", "Opaque objects.",GH_ParamAccess.list);

            SlabParam slabParam = new SlabParam();
            pManager.AddParameter(slabParam, "Slabs", "S", "Slab objects.", GH_ParamAccess.list);

            pManager[1].Optional = true;
            pManager[2].Optional = true;
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            EnvelopSurfaceParam es=new EnvelopSurfaceParam();
            pManager.AddParameter(es,"Envelope setting", "E", "Envelope setting", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Underground surface text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;
            List<OpaqueGoo> opaques = new List<OpaqueGoo>();
            List<SlabGoo> slabs = new List<SlabGoo>();

            DA.GetData(0, ref name);
            DA.GetDataList(1, opaques);
            DA.GetDataList(2, slabs);

            // 建立 EnvelopeSetting 实例
            EnvelopeSetting es = new EnvelopeSetting()
            {
                EnvelopeType = EnvelopeType.Underground,                
            };
            if (opaques.Count>0)
            {
                es.Opaques = opaques.Select(opaque => opaque.Value).ToList(); ;
            }

            if (slabs.Count>0)
            {
                es.Slabs = slabs.Select(slab => slab.Value).ToList();
            }
            // 判断 slab 是不是都共面
            if (slabs.Count>1)
            {
                var slab0 = slabs[0];
                for (int i = 1; i < slabs.Count; i++)
                {
                    var slab = slabs[i];
                    bool isCoplanar = SurfaceTools.IsTwoGhSurfacesCoplanar(slab0.Value.GeometrySurface, slab.Value.GeometrySurface);
                    if (!isCoplanar)
                    {
                        this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Slab 1 and Slab 2 are not coplanar.");
                        return;
                    }
                }
            }
            
            var result = new EnvelopeSettingGoo {Value = es};
            DA.SetData(0, result);
            DA.SetData(1, es.ToCen());
        }
    }
}