using System;
using Grasshopper.Kernel;
using Rhino.Geometry;
using Grasshopper.Kernel.Types;
using Rhino;
using RCBldGH.Modules;
using RCBldGH.Utils;

namespace RCBldGH.Components
{
    class GetOrientationComp: GH_Component
    {
        public GetOrientationComp()
            : base("GetOrientation", "GetOrientation",
                "开发测试电池，输入方向向量和参考平面，得出向量的朝向，参考平面的 Y 轴方向为正北方。",
                "RCBldGH", "TestTools")
        {
        }

        public override Guid ComponentGuid => new Guid("{1F3DA5EA-C356-4CB8-A20B-68E26731ED8D}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddVectorParameter("direction", "D", "Direction vector", GH_ParamAccess.item);
            pManager.AddPlaneParameter("Plane", "P", "The Y axis of the reference plane will be north.",
                GH_ParamAccess.item,Plane.WorldXY);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Orientation", "O", "Orientation", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            Plane plane = Plane.Unset;
            Vector3d vector = Vector3d.Unset;
            if ((DA.GetData<Plane>(1, ref plane) && DA.GetData<Vector3d>(0, ref vector) && plane.IsValid && vector.IsValid))
            {
                if (Math.Abs(vector.Length) < 0.0)
                {
                    this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Cannot calculate a zero-length guide vector.");
                    DA.SetData(0, Domains.Orientation.InValid);
                    return;
                }
                DA.SetData(0,VectorTools.GetOrientation(plane, vector));
            }
        }
    }
}