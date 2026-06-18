using System;
using System.Collections.Generic;
using System.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Geometry;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules;
using RCBldGH.Components.Envelope;
using System.Security.Policy;
using Rhino.Geometry.Intersect;
using Rhino.Commands;
using Rhino;
using System.Numerics;
namespace RCBldGH.Components
{
    public class Test : GH_Component
    {
        public Test()
            : base("Test", "Names",
                "Create a set of names by a prefix and incremental indexes.",
                "RCBldGH", "Test")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.name;
        
        public override Guid ComponentGuid => new Guid("{f625dd83-a297-49d0-a184-1021fabb2366}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddVectorParameter("sunVector", "P", "Name prefix", GH_ParamAccess.item);
            
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddNumberParameter("N", "N", "Names", GH_ParamAccess.item);
            pManager.AddNumberParameter("N", "N", "Names", GH_ParamAccess.item);
            
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            Vector3d sunVector = new Vector3d();
            DA.GetData(0, ref sunVector);
            Vector3d xyPlaneNormal = new Vector3d(0, 0, -1);
            Vector3d xzPlaneNormal = new Vector3d(0, 1, 0);


            double angleDeg = Vector3d.VectorAngle(sunVector, xyPlaneNormal);
            double angleDegyz = Vector3d.VectorAngle(sunVector, xzPlaneNormal);
           
            DA.SetData(0, angleDeg);
            DA.SetData(1, angleDegyz);
        }
       
    }
}
//protected override void SolveInstance(IGH_DataAccess DA)
//{
//    Vector3d sunVector = new Vector3d();
//    DA.GetData(0, ref sunVector);
//    Vector3d xyPlaneNormal = new Vector3d(0, 0, -1);

//    // 计算向量与XY平面法线向量的点积
//    double dotProduct = sunVector * xyPlaneNormal;

//    // 计算向量和法线向量的模
//    double vectorLength = sunVector.Length;


//    // 计算夹角的余弦值
//    double cosAngle = dotProduct / vectorLength;

//    // 使用反余弦函数得到夹角（以弧度表示）
//    double angleRad = Math.Acos(cosAngle);






//    DA.SetData(0, angleRad);

//}