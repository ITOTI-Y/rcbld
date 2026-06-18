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
    public class ZoneComp : GH_Component
    {
        public ZoneComp()
            : base("Zone Creator", "Z","Zone Creator to handle rooms made up of walls of different materials.","RCBldGH", "2.Envelops")
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.quinary;
        public override Guid ComponentGuid => new Guid("{6A521456-D511-40AC-90C3-6ABD94B93E57}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.zone_old;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Zone Name", "N", "Specify the zone name", GH_ParamAccess.item);
            EnvelopSurfaceParam surfaceParam = new EnvelopSurfaceParam();
            pManager.AddParameter(surfaceParam,"Envelope Surfaces", "S", "Surfaces that can form a closed zone.",GH_ParamAccess.list);
            pManager.AddNumberParameter("Occupancy Rate", "OR", "Unit: m2/person.", GH_ParamAccess.item);
            pManager.AddNumberParameter("Metabolic Rate", "MR", "Unit: W/person.", GH_ParamAccess.item);
            pManager.AddNumberParameter("Appliance Intensity", "A", "Unit: W/m2.", GH_ParamAccess.item);
            pManager.AddGenericParameter("Lighting Template", "L", "Specify a predefined lighting system.",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("Outdoor Air Rate", "OAR",
                "Outdoor Air(liter/s/person).If ignored, then minimum outdoor air default will be used",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("Air Infiltration Level", "AIL", "specify a predefined lighting system.",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("Air Infiltration Rate", "AIR",
                "Air Infiltration Rate. Leave blank if air infiltration level is used, unit: /h air change rate at Q4Pa",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("Air Infiltration Schedule", "AIS",
                "Specify a predefined monthly air infiltration schedule", GH_ParamAccess.item);
            pManager.AddGenericParameter("Ventilation Type", "V",
                "Ventilation Type,Note: zones that don't have external structures can't apply natural ventilation.",
                GH_ParamAccess.item);
            pManager.AddBooleanParameter("Night Flushing", "NF", "Night Flushing", GH_ParamAccess.item);
            pManager.AddNumberParameter("Window Area Open Percentage", "WP",
                "Window Area Open Percentage. If natural ventilation is used, specify the opened area percentage of total window area, unit: %",
                GH_ParamAccess.item);
            pManager.AddAngleParameter("Angle of Opening", "AO",
                "Unit: degree. If natural ventilation is used, specify the angle of opening for bottom hung windows",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("DHW", "DHW", "DHW. unit: liter/m2/month", GH_ParamAccess.item);
            pManager.AddGenericParameter("Monthly ITSS", "ITSS",
                "Specify a predefined indoor temperature setpoint schedule.",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("Monthly BUS", "BUS", "Specify a predefined building use schedule.",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("HAVC Template", "HAVC", "Specify a predefined HVAC system",GH_ParamAccess.item);
            pManager.AddIntegerParameter("Number of floors", "M",
                "If ignored, floor number will be used as multiplier of this zone", GH_ParamAccess.item,1);


            for (int i = 0; i < pManager.ParamCount; i++)
            {
                if (i==0&& i==1)
                {
                    continue;
                }
                pManager[i].Optional = true;
            }
        }
        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            ZoneParam zone = new ZoneParam();
            pManager.AddParameter(zone,"Zone", "Z", "Zone", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Zone text", GH_ParamAccess.item);
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

            foreach (var envelopeSettingGoo in envelopeSettingGoos)
            {
                try
                {
                    EnvelopeSetting surface = envelopeSettingGoo.Value;
                    // 不存在当前 surface id 索引，实例化一个新的 Zone Id List.
                    if (SurfaceZones.Keys.All(e => 0 != String.CompareOrdinal(e, surface.Id)))
                    {
                        SurfaceZones[surface.Id] = new List<string>();
                    }
                    // surface id 索引中不包含当前 zone 的 id 时再把当前 zone 加入其中。
                    if (!SurfaceZones[surface.Id].Contains(zone.Id))
                    {
                        SurfaceZones[surface.Id].Add(zone.Id);
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
            bool isZoneClosed = zone.IsZoneClosed(out Brep closedBrep);
            if (!isZoneClosed)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error,$"Zone({zone.Name}) is not closed!");
                return;
            }
            //对zone内的envelopeSurface进行合并

            // 计算 Zone 的体积
            double zoneVolume = closedBrep.GetVolume();

            // 区分地板和天花板
            if (zone.FloorDistinguishResult==DistinguishFloorResult.NotRun)
            {
                zone.FloorDistinguishResult = zone.DistinguishFloor();
            }

            if (zone.FloorDistinguishResult==DistinguishFloorResult.MultiPlane)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, $"The floors or ceilings in the zone({zone.Name}) is not on the same plane.");
            }

            if (zone.FloorDistinguishResult==DistinguishFloorResult.NoFloor)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Warning,$"Unable to distinguish the floor in the zone({zone.Name}).");
            }

            // 计算面积
            if (zone.FloorDistinguishResult==DistinguishFloorResult.Success)
            {
                double area = 0;
                area = zone.GetZoneArea();
                zone.Area = area;
            }

            // 计算平均高度
            zone.Height = zoneVolume / zone.Area;

            // 获取 Occupancy
            double occupancy = 0;
            if (DA.GetData("Occupancy Rate", ref occupancy))
            {
                zone.Occupancy = occupancy;
            }

            // 获取 Metabolic Rate
            double metabolic = 0;
            if (DA.GetData("Metabolic Rate", ref metabolic))
            {
                zone.MetabolicRate = metabolic;
            }

            // 获取 Appliance Intensity
            double appliance = 0;
            if (DA.GetData("Appliance Intensity", ref appliance))
            {
                zone.Appliance = appliance;
            }

            // 获取 Lighting Template
            object lightingObj = null;
            if (DA.GetData("Lighting Template", ref lightingObj))
            {
                try
                {
                    LightingSetting lighting = (LightingSetting) ((GH_ObjectWrapper) lightingObj).Value;
                    zone.LightingTemplate = lighting;
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Lighting Template is Invalid.");
                }
            }

            // 获取 Outdoor Air Rate
            double outdoorAirRate = 0;
            if (DA.GetData("Outdoor Air Rate", ref outdoorAirRate))
            {
                zone.OutdoorAir = outdoorAirRate;
            }

            // 获取 Air Infiltration Rate
            double airInfiltrationRate = double.NaN;
            if (DA.GetData("Air Infiltration Rate", ref airInfiltrationRate))
            {
                zone.AirInfiltrationRate = airInfiltrationRate;
            }

            // 获取 Air Infiltration Level
            object levelObj = null;
            if (DA.GetData("Air Infiltration Level", ref levelObj))
            {
                try
                {
                    AirInfiltrationLevel level = (AirInfiltrationLevel) ((GH_ObjectWrapper) levelObj).Value;
                    zone.AirInfiltrationLevel = level;
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Air Infiltration Level is Invalid.");
                }
            }

            if (!double.IsNaN(airInfiltrationRate) && levelObj!=null)
            {
                zone.AirInfiltrationRate = double.NaN;
                AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Air Infiltration Level and Air Infiltration Rate cannot coexist, Air Infiltration Rate has been ignored");
            }

            // 获取 Air Infiltration Schedule
            object airSchedule = null;
            if (DA.GetData("Air Infiltration Schedule", ref airSchedule))
            {
                try
                {
                    Schedule schedule = (Schedule) ((GH_ObjectWrapper)airSchedule).Value;
                    if (schedule.ScheduleType != ScheduleType.MonthlyCoefficient)
                    {
                        AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Air Infiltration Schedule is Invalid.");
                    }
                    else
                    {
                        zone.AirInfiltrationSchedule = schedule;
                    }

                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Air Infiltration Schedule is Invalid.");
                }
            }

            // 获取 Ventilation Type
            object ventilationObj = null;
            if (DA.GetData("Ventilation Type", ref ventilationObj))
            {
                try
                {
                    VentilationType ventilationType = (VentilationType) ((GH_ObjectWrapper)ventilationObj).Value;
                    zone.VentilationType = ventilationType;
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Ventilation Type is Invalid.");
                }
            }

            // 获取 Night Flushing
            bool nf = false;
            if (DA.GetData("Night Flushing", ref nf))
            {
                zone.NightFlushing = nf;
            }

            // 获取 Window Area Open Percentage
            double waop = 0;
            if (DA.GetData("Window Area Open Percentage", ref waop))
            {
                if (waop < 0 || waop > 100)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning,
                        "The Window Area Open Percentage must be between 0 and 100.");
                }
                else
                {
                    zone.WindowAreaOpenPercentage = waop;
                }
            }
            // 获取 Angle of Opening
            double angeleOfOpening = 0;
            if (DA.GetData("Angle of Opening",ref angeleOfOpening))
            {
                zone.AngleOfOpening = angeleOfOpening;
            }
            // 获取 DHW
            double dhw = 0;
            if (DA.GetData("DHW",ref dhw))
            {
                zone.DHW = dhw;
            }
            // 获取 Monthly ITSS
            object itss = null;
            if (DA.GetData("Monthly ITSS", ref itss))
            {
                try
                {
                    Schedule schedule = (Schedule)((GH_ObjectWrapper)itss).Value;
                    if (schedule.ScheduleType != ScheduleType.MonthlyItss)
                    {
                        AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Monthly ITSS is Invalid.");
                    }
                    else
                    {
                        zone.IndoorTemperatureSetPointSchedule = schedule;
                    }

                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Monthly ITSS is Invalid.");
                }
            }
            // 获取 Monthly BUS
            object bus = null;
            if (DA.GetData("Monthly BUS", ref bus))
            {
                try
                {
                    Schedule schedule = (Schedule)((GH_ObjectWrapper)bus).Value;
                    if (schedule.ScheduleType != ScheduleType.MonthlyBus)
                    {
                        AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Monthly BUS is Invalid.");
                    }
                    else
                    {
                        zone.BuildingUseSchedule = schedule;
                    }

                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The Monthly BUS is Invalid.");
                }
            }

            // 获取 HAVC Template
            object hvacObj = null;
            if (DA.GetData("HAVC Template",ref hvacObj))
            {
                try
                {
                    HVAC hvac = (HVAC) ((GH_ObjectWrapper) hvacObj).Value;
                    zone.HvacTemplate = hvac;
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The HAVC Template is Invalid.");
                }
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
            foreach (var surface in zone.EnvelopSurfaces)
            {
                if (surface.Opaques != null && !(isFloorMaterialSet && isWallMaterialSet && isRoofSet))
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
                    }
                }
                if (surface.EnvelopeType==EnvelopeType.Underground)
                {
                    zone.GroundSlabSetting = surface;
                }
            }

            // 输出 Zone 
            var result = new ZoneGoo() {Value = zone};
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