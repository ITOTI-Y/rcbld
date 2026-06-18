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
    public class OpaqueComp : GH_Component
    {
        public OpaqueComp()
            : base("Opaque", "Opaque", "Opaque", "RCBldGH", "2.Envelops")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.face;
        public override Guid ComponentGuid => new Guid("{6F1798D8-E487-48BB-A47C-44C20CA27A57}");

        public override GH_Exposure Exposure => GH_Exposure.senary;

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {

            pManager.AddSurfaceParameter("Surface", "S", "Opaque surface", GH_ParamAccess.item);
            pManager.AddGenericParameter("Material", "M", "Opaque Material", GH_ParamAccess.item);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            OpaqueParam op = new OpaqueParam();
            pManager.AddParameter(op, "Opaque", "O", "Opaque", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            GH_Surface opaque1 = null;
            object o1MaterialObj = null;

            // 读取并判断 opaque1 是否为平面
            if (DA.GetData(0, ref opaque1))
            {
                if (!SurfaceTools.IsGhSurfacePlaner(opaque1))
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Opaque must be planer surface.");
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
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Opaque Material is not a correct material type.");
                return;
            }

            // 建立 Opaque 实例
            Opaque opaque = new Opaque()
            {
                GeometrySurface = opaque1,
                Material = o1Material
            };

            var result = new OpaqueGoo() { Value = opaque };
            DA.SetData(0, result);
        }
    }
}