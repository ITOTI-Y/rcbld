using System;
using System.Collections.Generic;
using System.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules;
using RCBldGH.Utils;

namespace RCBldGH.Components.Envelope
{
    public class SlabComp : GH_Component
    {
        public SlabComp()
            : base("Slab", "Slab",
                "Slab",
                "RCBldGH", "2.Envelops")
        {
        }

        public override Guid ComponentGuid => new Guid("{5C137519-11E7-4BB5-85D6-9077E3A60E57}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.slab;
        public override GH_Exposure Exposure => GH_Exposure.senary;

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {

            pManager.AddSurfaceParameter("Surface", "S", "Slab surface", GH_ParamAccess.item);
            pManager.AddGenericParameter("Material", "M", "Slab Material", GH_ParamAccess.item);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            SlabParam op = new SlabParam();
            pManager.AddParameter(op, "Slab", "S", "Slab", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            GH_Surface slab1 = null;
            object o1MaterialObj = null;

            // 读取并判断 slab 是否为平面
            if (DA.GetData(0, ref slab1))
            {
                if (!SurfaceTools.IsGhSurfacePlaner(slab1))
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Slab must be planer surface.");
                }
            }

            DA.GetData(1, ref o1MaterialObj);

            Modules.Material o1Material;
            // 判断输入的材质类型是否正确
            try
            {
                o1Material = (Modules.Material)((GH_ObjectWrapper)o1MaterialObj).Value;
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Slab Material is not a correct material type.");
                return;
            }

            // 建立 Slab 实例
            Slab slab = new Slab()
            {
                GeometrySurface = slab1,
                Material = o1Material
            };

            var result = new SlabGoo() { Value = slab };
            DA.SetData(0, result);
        }
    }
}