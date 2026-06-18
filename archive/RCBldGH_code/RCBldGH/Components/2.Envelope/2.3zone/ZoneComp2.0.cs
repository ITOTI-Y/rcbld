using System;
using System.Collections.Generic;
using System.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Geometry;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules;
using System.Security.Policy;

namespace RCBldGH.Components.Envelope
{
    public class Zone2 : GH_Component
    {
        public Zone2()
            : base("Zone2.0", "Zone Creator","Zone Creator","RCBldGH", "2.Envelops")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.tertiary;
        public override Guid ComponentGuid => new Guid("{28a9cc79-b868-4bc2-b945-13d9ba1f1839}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.zone;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Zone Name", "N", "Specify the zone name", GH_ParamAccess.item);            
            pManager.AddGenericParameter("SuperBrep", "S", "Surfaces that can form a closed zone.", GH_ParamAccess.item);
            pManager.AddGenericParameter("Program", "P", "Building usage conditions for a zone", GH_ParamAccess.item);
            pManager.AddGenericParameter("ScheduleSetting", "S", "ScheduleSetting to be used with the ZoneCreator component.", GH_ParamAccess.item);           
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {           
            pManager.AddGenericParameter( "Zone", "Z", "Zone", GH_ParamAccess.item);
        }        

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            // 获取 Zone Name
            string name = null;
            if (!DA.GetData("Zone Name", ref name))
            {
                return;
            }
            // 获取 Envelope Surfaces
            SuperBrep superBrep = null;
            if (!DA.GetData("SuperBrep", ref superBrep))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "At least one Envelope Surface list is empty.");
                return;
            }
            superBrep.Name = name;
            bool isZoneClosed = superBrep.IsZoneClosed(out Brep closedBrep);
            if (!isZoneClosed)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, $"Zone({superBrep.Name}) is not closed!");
                return;
            }
            //体积面积高度
            double zoneVolume = closedBrep.GetVolume();
            double area = 0;            
            area = superBrep.GetZoneArea();
            superBrep.Area = area;  
            superBrep.Height = zoneVolume / superBrep.Area;

            // 获取 Occupancy
            Program program = new RCBldGH.Modules.Program();
            if (DA.GetData("Program", ref program))
            {
                superBrep.Occupancy = program.Occupancy;
                superBrep.MetabolicRate = program.MetabolicRate;
                superBrep.Appliance = program.Appliance;
                superBrep.LightingTemplate = program.LightingTemplate;
                superBrep.OutdoorAir = program.OutdoorAir;
                superBrep.AirInfiltrationRate = program.AirInfiltrationRate;
                superBrep.AirInfiltrationLevel = program.AirInfiltrationLevel;
                superBrep.VentilationType = program.VentilationType;
                superBrep.NightFlushing = program.NightFlushing;
                superBrep.WindowAreaOpenPercentage = program.WindowAreaOpenPercentage;
                superBrep.AngleOfOpening = program.AngleOfOpening;
                superBrep.DHW = program.DHW;
                superBrep.HvacTemplate = program.HvacTemplate;
            }
            Schedule.ScheduleSetting schedule1 = new RCBldGH.Modules.Schedule.ScheduleSetting();
            if (DA.GetData("ScheduleSetting", ref schedule1))
            {
                superBrep.AirInfiltrationSchedule = schedule1.AirInfiltrationSchedule;
                superBrep.IndoorTemperatureSetPointSchedule = schedule1.IndoorTemperatureSetPointSchedule;
                superBrep.BuildingUseSchedule = schedule1.BuildingUseSchedule;
            }

            // 设置 Interior Floor Material \ Interior Wall Material
            foreach (var surface in superBrep.Wall)
            {
                if (surface.Material.MaterialType == MaterialType.InternalWall)
                {
                    superBrep.InteriorWallMaterial = surface.Material;
                    break;
                }
            }
            List < SuperSurface > flat= new List<SuperSurface> { };
            flat.AddRange(superBrep.Ceiling);
            flat.AddRange(superBrep.Floor);
            foreach (var surface in flat)
            {
                if (surface.Material.MaterialType == MaterialType.InternalFloor)
                {
                    superBrep.InteriorFloorMaterial = surface.Material;
                    break;
                }
            }
            //envelopSetting合并\设置Ground Slab Setting \ Roof Setting\
            superBrep.MergeExternalEnvelope();

            // 输出 Zone             
            DA.SetData(0, superBrep);
            DA.SetData(1, superBrep.ToCen());            
        }        
    }
}
//public void superAssign(SuperBrep superBrep)
//{
//    for (int j = 0; j < superBrep.Ceiling.Count; j++)
//    {
//        if (superBrep.Ceiling[j].Material.MaterialType == MaterialType.InternalFloor)
//        {
//            superBrep.InternalFloor.Add(superBrep.Ceiling[j]);
//        }
//        else
//        { superBrep.Roof.Add(superBrep.Ceiling[j]); }                
//    }
//    for (int j = 0; j < superBrep.Floor.Count; j++)
//    {
//        if (superBrep.Floor[j].Material.MaterialType == MaterialType.InternalFloor)
//        {
//            superBrep.InternalFloor.Add(superBrep.Floor[j]);
//        }
//        else if (superBrep.Floor[j].Material.MaterialType == MaterialType.ExternalFloor)
//        {
//            superBrep.ExternalFloor.Add(superBrep.Floor[j]);
//        }
//        else
//        {
//            superBrep.Ground.Add(superBrep.Floor[j]);
//        }
//    }
//    for (int j = 0; j < superBrep.Wall.Count; j++)
//    {
//        if (superBrep.Wall[j].Material.MaterialType == MaterialType.InternalWall)
//        {
//            superBrep.InternalFloor.Add(superBrep.Ceiling[j]);
//        }
//        else
//        { superBrep.Roof.Add(superBrep.Ceiling[j]); }
//    }
//}