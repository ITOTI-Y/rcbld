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
    public class WindowComp : GH_Component
    {
        public WindowComp()
            : base("Window", "Window",
                "Window",
                "RCBldGH", "2.Envelops")
        {
        }

        public override Guid ComponentGuid => new Guid("{D7810379-A560-47B2-BE46-944E41B7EA68}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.window;
        public override GH_Exposure Exposure => GH_Exposure.secondary;

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddSurfaceParameter("Surface", "S", "Window Surface", GH_ParamAccess.item);
            pManager.AddGenericParameter("Material", "M", "Window Material", GH_ParamAccess.item);
            pManager.AddNumberParameter("Window Overhang Angle", "WO", "Degree, must choose from 30, 45, 60.",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("Window Fin Angle", "F", "Degree, must choose from 30, 45, 60.",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("Window Horizon Angle", "H", "Degree, must be 10, 20, 30, 40, 50, 60, 70, 80.",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("Window Shading Type", "ST", "1. white blinds, 2. white curtains, 3. colored textures, 4. aluminum-coated texture.",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("Window Shading Where", "SW", "1. inside: internal shading, 2. outside: external shading.",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("Window Shading Control", "SC", "1. manually controlled, 2. automated control, 3. all others.",
                GH_ParamAccess.item);

            pManager[2].Optional = true;
            pManager[3].Optional = true;
            pManager[4].Optional = true;
            pManager[5].Optional = true;
            pManager[6].Optional = true;
            pManager[7].Optional = true;
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            WindowParam window = new WindowParam();
            pManager.AddParameter(window, "Windows", "W", "Windows, to be used with the MaterialAssign componen", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            GH_Surface window1 = null;
            object w1MaterialObj = null;
            double w1OverhangAngle = -1;
            double w1FinAngle = -1;
            double w1HorizonAngle = -1;
            object w1ShadingType = null;
            object w1ShadingWhere = null;
            object w1ShadingControl = null;


            DA.GetData(0, ref window1);
            DA.GetData(1, ref w1MaterialObj);
            if (DA.GetData(2, ref w1OverhangAngle))
            {
                if (w1OverhangAngle != 30 && w1OverhangAngle != 45 && w1OverhangAngle != 60)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Window Overhang Angle must be 30, 45 or 60.");
                    return;
                }
            }
            if (DA.GetData(3, ref w1FinAngle))
            {
                if (w1FinAngle != 30 && w1FinAngle != 45 && w1FinAngle != 60)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Window Fin Angle must be 30, 45 or 60.");
                    return;
                }
            }

            if (DA.GetData(4, ref w1HorizonAngle))
            {
                bool isOk = false;
                double[] list = { 10, 20, 30, 40, 50, 60, 70, 80 };
                foreach (double d in list)
                {
                    if (w1HorizonAngle == d)
                    {
                        isOk = true;
                        break;
                    }
                }
                if (!isOk)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Window Horizon Angle must be 10, 20, 30, 40, 50, 60, 70, 80.");
                    return;
                }
            }
            DA.GetData(5, ref w1ShadingType);
            DA.GetData(6, ref w1ShadingWhere);
            DA.GetData(7, ref w1ShadingControl);


            // 判断输入的材质类型是否正确
            Modules.Material w1Material;
            try
            {
                w1Material = (Modules.Material)((GH_ObjectWrapper)w1MaterialObj).Value;
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Window Material is not a correct material type.");
                return;
            }

            // 建立 Window 实例
            Window window = new Window()
            {
                GeometrySurface = window1,

                WindowOverhangAngle = w1OverhangAngle,
                WindowFinAngle = w1FinAngle,
                WindowHorizonAngle = w1HorizonAngle,
            };

            // 设置材质属性
            if (w1Material != null)
            {
                window.Material = w1Material;
                if (w1Material.MaterialType != MaterialType.Window)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Window Material type must be Window.");
                    return;
                }
            }

            // 设置类型属性
            if (w1ShadingType != null)
            {
                window.WindowShadingType = (WindowShadingType)((GH_ObjectWrapper)w1ShadingType).Value;
            }

            if (w1ShadingWhere != null)
            {
                window.WindowShadingWhere = (WindowShadingWhere)((GH_ObjectWrapper)w1ShadingWhere).Value;
            }

            if (w1ShadingControl != null)
            {
                window.WindowShadingControl = (WindowShadingControl)((GH_ObjectWrapper)w1ShadingControl).Value;
            }

            var result = new WindowGoo() { Value = window };
            DA.SetData(0, result);
        }

    }
}