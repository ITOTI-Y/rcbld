using System;
using System.Collections.Generic;
using System.Linq;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Geometry;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class NEWZoneComp : GH_Component
    {
        public NEWZoneComp()
            : base("Zone Creator", "Zone Creator","Zone Creator","RCBldGH", "2.Envelops")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.tertiary;
        public override Guid ComponentGuid => new Guid("{1625b73f-b65d-4128-8cfc-6da16f486404}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.zone;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Zone Name", "N", "Specify the zone name", GH_ParamAccess.item);
            EnvelopSurfaceParam surfaceParam = new EnvelopSurfaceParam();
            pManager.AddParameter(surfaceParam, "Envelope Surfaces", "S", "Surfaces that can form a closed zone.", GH_ParamAccess.list);

            pManager.AddGenericParameter("Program", "P", "Building usage conditions for a zone", GH_ParamAccess.item);
            pManager.AddGenericParameter("ScheduleSetting", "S", "ScheduleSetting to be used with the ZoneCreator component.", GH_ParamAccess.item);
            pManager.AddIntegerParameter("Number of floors", "M",
                "If ignored, floor number will be used as multiplier of this zone", GH_ParamAccess.item, 1);
            //for (int i = 0; i < pManager.ParamCount; i++)
            // {
            //     if (i==0&& i==1)
            //     {
            //         continue;
            //     }
            //     pManager[i].Optional = true;
            // }
     
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            ZoneParam zone = new ZoneParam();
            pManager.AddParameter(zone, "Zone", "Z", "Zone", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Zone text", GH_ParamAccess.item);
            pManager.AddBrepParameter("a", "a", "a", GH_ParamAccess.list);
        }

        private Dictionary<string, Zone> ZoneDictionary { get; set; }
        private Dictionary<string, List<string>> SurfaceZones { get; set; }
        protected override void SolveInstance(IGH_DataAccess DA)
        {
            // 新建 Zone 的实例并加入 Zone 的字典。
            Zone zone = new Zone();
            ZoneDictionary[zone.Id] = zone;
            zone.ZoneDictionary = ZoneDictionary;
            zone.SurfaceZones = SurfaceZones;


            // 获取 Zone Name
            string name = String.Empty;
            if (!DA.GetData("Zone Name", ref name))
            {
                return;
            }
            zone.Name = name;

            // 获取 Envelope Surfaces
            List<EnvelopeSettingGoo> envelopeSettingGoos = new List<EnvelopeSettingGoo>();
            if (!DA.GetDataList("Envelope Surfaces", envelopeSettingGoos) || envelopeSettingGoos.Count == 0)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "At least one Envelope Surface list is empty.");
                return;
            }

            //foreach (var envelopeSettingGoo in envelopeSettingGoos)
            //{
            //    try
            //    {
            //        EnvelopeSetting surface = envelopeSettingGoo.Value;
            //        // 不存在当前 surface id 索引，实例化一个新的 Zone Id List.                   
            //        if (SurfaceZones.Keys.All(e => 0 != String.CompareOrdinal(e, surface.Name)))
            //        {
            //            SurfaceZones[surface.Name] = new List<string>();
            //            //EnvelopeSurfaces.Add(surface);
            //        }
            //        // surface id 索引中不包含当前 zone 的 id 时再把当前 zone 加入其中。
            //        if (!SurfaceZones[surface.Name].Contains(zone.Id))
            //        {
            //            SurfaceZones[surface.Name].Add(zone.Id);
            //        }

            //        // zone 的 surface 列表已经包含当前的 surface ,跳过。
            //        if (zone.EnvelopSurfaces.Contains(surface))
            //        {
            //            continue;
            //        }
            //        zone.AddSurface(surface);
            //    }
            //    catch (Exception)
            //    {
            //        AddRuntimeMessage(GH_RuntimeMessageLevel.Warning,
            //            "At least one input Envelop Surface has incorrect type.");
            //    }
            //}
            foreach (var envelopeSettingGoo in envelopeSettingGoos)
            {
                try
                {
                    EnvelopeSetting surface = envelopeSettingGoo.Value;
                    // 不存在当前 surface id 索引，实例化一个新的 Zone Id List.
                    if (SurfaceZones.Keys.All(e => 0 != String.CompareOrdinal(e, surface.Name)))
                    {
                        SurfaceZones[surface.Name] = new List<string>();
                    }
                    // surface id 索引中不包含当前 zone 的 id 时再把当前 zone 加入其中。
                    if (!SurfaceZones[surface.Name].Contains(zone.Id))
                    {
                        SurfaceZones[surface.Name].Add(zone.Id);
                    }

                    // zone 的 surface 列表已经包含当前的 surface ,跳过。
                    if (zone.EnvelopSurfaces.Contains(surface))
                    {
                        continue;
                    }
                    zone.AddSurface(surface);
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning,
                        "At least one input Envelop Surface has incorrect type.");
                }
            }
            // 判断 Zone 是否闭合
            bool isZoneClosed = zone.IsZoneClosedTest(out Brep closedBrep,out List<GH_Surface> resultBreps);
            DA.SetDataList(2, resultBreps);
            if (!isZoneClosed)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, $"Zone({zone.Name}) is not closed!");
                return;
            }
            // 计算 Zone 的体积
            double zoneVolume = closedBrep.GetVolume();

            // 区分地板和天花板
            if (zone.FloorDistinguishResult == DistinguishFloorResult.NotRun)
            {
                zone.FloorDistinguishResult = zone.DistinguishFloor();
            }

            if (zone.FloorDistinguishResult == DistinguishFloorResult.MultiPlane)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, $"The floors or ceilings in the zone({zone.Name}) is not on the same plane.");
            }

            if (zone.FloorDistinguishResult == DistinguishFloorResult.NoFloor)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, $"Unable to distinguish the floor in the zone({zone.Name}).");
            }

            // 计算面积
            if (zone.FloorDistinguishResult == DistinguishFloorResult.Success)
            {
                double area = 0;
                area = zone.GetZoneArea();
                zone.Area = area;
            }

            // 计算平均高度
            zone.Height = zoneVolume / zone.Area;

            // 获取 Occupancy
            RCBldGH.Modules.Program program = new RCBldGH.Modules.Program();
            if (DA.GetData("Program", ref program))
            {
                zone.Occupancy = program.Occupancy;
                zone.MetabolicRate = program.MetabolicRate;
                zone.Appliance = program.Appliance;
                zone.LightingTemplate = program.LightingTemplate;
                zone.OutdoorAir = program.OutdoorAir;
                zone.AirInfiltrationRate = program.AirInfiltrationRate;
                zone.AirInfiltrationLevel = program.AirInfiltrationLevel;
                zone.VentilationType = program.VentilationType;
                zone.NightFlushing = program.NightFlushing;
                zone.WindowAreaOpenPercentage = program.WindowAreaOpenPercentage;
                zone.AngleOfOpening = program.AngleOfOpening;
                zone.DHW = program.DHW;
                zone.HvacTemplate = program.HvacTemplate;
            }
            RCBldGH.Modules.Schedule.ScheduleSetting schedule1 = new RCBldGH.Modules.Schedule.ScheduleSetting();
            if (DA.GetData("ScheduleSetting", ref schedule1))
            {
                zone.AirInfiltrationSchedule = schedule1.AirInfiltrationSchedule;
                zone.IndoorTemperatureSetPointSchedule = schedule1.IndoorTemperatureSetPointSchedule;
                zone.BuildingUseSchedule = schedule1.BuildingUseSchedule;
            }

            // 获取 Multiplier
            int multiplier = 1;
            if (DA.GetData("Number of floors", ref multiplier))
            {
                zone.Multiplier = multiplier;
            }

            // 设置 Interior Floor Material \ Interior Wall Material \ Ground Slab Setting \ Roof Setting
            bool isFloorMaterialSet = false;
            bool isWallMaterialSet = false;
            bool isRoofSet = false;
            bool isGroundSet = false;
            foreach (var surface in zone.EnvelopSurfaces)
            {                
                    if (surface.Opaques != null && !(isFloorMaterialSet && isWallMaterialSet && isRoofSet && isGroundSet))
                    {
                        foreach (var opaque in surface.Opaques)
                        {
                            if (!isFloorMaterialSet && opaque.Material.MaterialType == MaterialType.InternalFloor)
                            {
                                zone.InteriorFloorMaterial = opaque.Material;
                                isFloorMaterialSet = true;
                            }
                            if (!isWallMaterialSet && opaque.Material.MaterialType == MaterialType.InternalWall)
                            {
                                zone.InteriorWallMaterial = opaque.Material;
                                isWallMaterialSet = true;
                            }
                            if (!isRoofSet && opaque.Material.MaterialType == MaterialType.Roof)
                            {
                                zone.RoofSetting = surface;
                                isRoofSet = true;
                            }
                            if (!isGroundSet && opaque.Material.MaterialType == MaterialType.ExternalFloor)
                            {
                                zone.GroundSlabSetting = surface;
                                surface.EnvelopeType = EnvelopeType.Underground;
                                isGroundSet = true;
                            }
                        }
                    }
                if (surface.EnvelopeType == EnvelopeType.Underground)
                {
                    zone.GroundSlabSetting = surface;
                }
            }

            // 输出 Zone 
            var result = new ZoneGoo() { Value = zone };
            DA.SetData(0, result);
            DA.SetData(1, zone.ToCen());
            
        }

        protected override void BeforeSolveInstance()
        {
            base.BeforeSolveInstance();
            ZoneDictionary = new Dictionary<string, Zone>();
            SurfaceZones = new Dictionary<string, List<string>>();
        }
    }
}