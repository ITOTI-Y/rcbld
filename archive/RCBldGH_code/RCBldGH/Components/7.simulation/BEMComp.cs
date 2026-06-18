using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Threading;
using GH_IO.Types;
using Grasshopper;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using Grasshopper.Kernel.Parameters;
using Grasshopper.Kernel.Types;
using Rhino;
using Rhino.Geometry;
using RCBldGH.Components.Envelope;
using RCBldGH.Modules;

namespace RCBldGH.Components.Others
{
    public class BEMComp : GH_Component
    {
        public BEMComp()
            : base("BEM", "BEM",
                "Building energy model",
                "RCBldGH", "7.Simulation")
        {
        }

        public override Guid ComponentGuid => new Guid("{C194A17F-8F1E-4EF0-8126-716700D2F135}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.BUS;
        protected override void RegisterInputParams(GH_Component.GH_InputParamManager pManager)
        {
            pManager.AddPlaneParameter("Reference Plane", "P", "The Y axis of the reference plane is north.",
                GH_ParamAccess.item, Plane.WorldXY);
            pManager.AddGenericParameter("Basics", "B", "Basics", GH_ParamAccess.item);
            ZoneParam zoneParam = new ZoneParam();
            pManager.AddParameter(zoneParam, "Zones", "Z", "Zones", GH_ParamAccess.list);
            pManager[2].DataMapping = GH_DataMapping.Flatten;
            pManager.AddGenericParameter("DHW", "DHW", "DHW", GH_ParamAccess.item);
            pManager.AddGenericParameter("Pumps", "P", "Pumps", GH_ParamAccess.item);
            pManager.AddGenericParameter("Energy Sources", "E", "Energy Sources", GH_ParamAccess.item);
            pManager.AddGenericParameter("BEM Type", "BT", "1. Class D: No building automation function,  2. Class C: adapting the operation of the building and technical systems to users needs, 3. Class B: optimizing the operation by the tuning of the different controllers and standard alarming and monitoring functions, 4. Class A: detecting faults of building and technical systems and providing support to the diagnosis of these faults, Reporting information regarding energy consumption, indoor conditions, and possibilities for improvement.", GH_ParamAccess.item);
            
            pManager.AddGenericParameter("Renewable System", "R", "Renewable System", GH_ParamAccess.item);
            pManager.AddGenericParameter("Calibration", "C", "If simulation mode is 'c', Calibration parameter can not be none.", GH_ParamAccess.item);

            pManager[0].Optional = true;
           pManager[8].Optional = true;
        }

        protected override void RegisterOutputParams(GH_Component.GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("BUS Data", "D", "BUS Data.", GH_ParamAccess.item);
        }

        protected override void BeforeSolveInstance()
        {
            base.BeforeSolveInstance();
            if (Rhino.RhinoDoc.ActiveDoc.ModelUnitSystem != UnitSystem.Meters)
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The current model unit system is not Meters. Change it to Meters please. ");
            }
        }
        protected override void SolveInstance(IGH_DataAccess DA)
        {
            if (this.RunCount > 1)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "This component does not support outputting multiple files. Please check your input data.");
                return;
            }

            BusData busData = new BusData();

            // 获取参考平面
            Plane plane = Plane.WorldXY;
            if (DA.GetData("Reference Plane", ref plane))
            {
                if (DA.Iteration > 0)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error,
                        "Only one Reference Plane can be entered.");
                    return;
                }
            }
            busData.Plane = plane;

            // 获取全部 Zone
            var zones = GetAllZones(DA);

            // 设置外墙朝向
            foreach (var zone in zones)
            {
                zone.SetExternalFacade(plane);
            }

            // 计算相邻的 Zone 和共有面积。
            if (zones.Count > 0)
            {
                CalculateAdjacentZonesAndContactAreaTest(zones);
            }

            busData.Zones = zones;

            // 获取全部 Monthly Schedules
            List<Schedule> monthlySchedules = GetMonthlySchedulesFromZones(zones);
            busData.MonthlySchedules = monthlySchedules;

            // 获取全部 Building Use Schedules
            List<Schedule> buildingUseSchedules = GetBuildingUseSchedulesFromMonthly(monthlySchedules);
            busData.BuildingUseSchedules = buildingUseSchedules;

            // 获取全部 Indoor Temperature Setpoint Schedules
            List<Schedule> itss = GetItssFromMonthly(monthlySchedules);
            busData.Itss = itss;

            // 获取全部 EnvelopSurfaces 、 HVAC 以及 Lighting Setting
            List<HVAC> hvacList = new List<HVAC>();
            List<LightingSetting> lightingSettings = new List<LightingSetting>();
            List<EnvelopeSetting> surfaces = GetEnvelopeSettings(zones, ref lightingSettings, ref hvacList);
            busData.HvacList = hvacList;
            busData.LightingSettings = lightingSettings;
            busData.Surfaces = surfaces;

            // 获取全部材质
            List<Modules.Material> materials = GetAllMaterials(surfaces);

            // 材质分组
            List<Modules.Material> externalWallMaterials = new List<Modules.Material>();
            List<Modules.Material> internalWallMaterials = new List<Modules.Material>();
            List<Modules.Material> windowMaterials = new List<Modules.Material>();
            List<Modules.Material> roofMaterials = new List<Modules.Material>();
            List<Modules.Material> externalFloorMaterials = new List<Modules.Material>();
            List<Modules.Material> internalFloorMaterials = new List<Modules.Material>();
            GroupingMaterials(materials, ref externalWallMaterials, ref internalWallMaterials, ref roofMaterials,
                ref windowMaterials, ref externalFloorMaterials, ref internalFloorMaterials);

            busData.ExternalWallMaterials = externalWallMaterials;
            busData.InternalWallMaterials = internalWallMaterials;
            busData.WindowMaterials = windowMaterials;
            busData.RoofMaterials = roofMaterials;
            busData.ExternalFloorMaterials = externalFloorMaterials;
            busData.InternalFloorMaterials = internalFloorMaterials;

            // 获取 Basics
            object basicsObj = null;
            Modules.Basics basics = null;
            try
            {
                if (DA.GetData("Basics", ref basicsObj) && basicsObj != null)
                {
                    basics = (Modules.Basics)((GH_ObjectWrapper)basicsObj).Value;
                }
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Basics.");
                return;
            }

            busData.Basics = basics;

            // 获取 DHW
            object dhwObj = null;
            DHW dhw = null;
            try
            {
                if (DA.GetData("DHW", ref dhwObj) && dhwObj != null)
                {
                    dhw = (DHW)((GH_ObjectWrapper)dhwObj).Value;
                }
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid DHW.");
            }

            busData.Dhw = dhw;

            // 获取 Pumps 
            object pumpsObj = null;
            Modules.Pumps pumps = null;
            try
            {
                if (DA.GetData("Pumps", ref pumpsObj) && pumpsObj != null)
                {
                    pumps = (Modules.Pumps)((GH_ObjectWrapper)pumpsObj).Value;
                }
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Pumps");
            }

            busData.Pumps = pumps;

            // 获取 Renewable
            object renewableObj = null;
            Modules.Renewable renewable = null;
            try
            {
                if (DA.GetData("Renewable System", ref renewableObj) && renewableObj != null)
                {
                    renewable = (Modules.Renewable)((GH_ObjectWrapper)renewableObj).Value;
                }
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Renewable System");
            }

            busData.Renewable = renewable;

            // 获取 BEM Type 并生成 BEM
            object bemTypeObj = null;
            if (!DA.GetData("BEM Type", ref bemTypeObj))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Get BEM Type failed.");
                return;
            }

            BemType bemType;
            try
            {
                bemType = (BemType)((GH_ObjectWrapper)bemTypeObj).Value;
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid BEM Type");
                return;
            }
            BEM bem = new BEM
            {
                Type = bemType,
            };

            busData.Bem = bem;

            // 获取 Energy Sources
            object energyObj = null;
            EnergySources energySources = null;
            try
            {
                if (DA.GetData("Energy Sources", ref energyObj) && energyObj != null)
                {
                    energySources = (EnergySources)((GH_ObjectWrapper)energyObj).Value;
                }
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Energy Sources");
                return;
            }

            busData.EnergySources = energySources;

            // 获取 CalibrationPara
            object calibrationObj = null;
            try
            {
                if (DA.GetData("Calibration", ref calibrationObj) && calibrationObj != null)
                {
                    CalibrationPara calibration = (Modules.CalibrationPara)((GH_ObjectWrapper)calibrationObj).Value;
                    busData.Calibration = calibration;
                }
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Calibration");
                return;
            }

            DA.SetData(0, busData);
        }
        
        /// 获取全部 Zone        
        public List<Zone> GetAllZones(IGH_DataAccess DA)
        {
            List<Zone> zones = new List<Zone>();
            List<ZoneGoo> zoneGoos = new List<ZoneGoo>();
            if (DA.GetDataList("Zones", zoneGoos))
            {
                if (DA.Iteration > 0)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Zones CANNOT be DataTree.");
                    return zones;
                }
                if (zoneGoos.Count < 1)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Zones cannot be an empty list.");
                    return zones;
                }
            }

            foreach (var zoneGoo in zoneGoos)
            {
                if (zoneGoo != null)
                {
                    zones.Add(zoneGoo.Value);
                }
            }
            return zones;
        }

        
        /// 计算每个 Zone 相邻的 zone 以及共有 surface 的面积。        
        public void CalculateAdjacentZonesAndContactArea(List<Zone> zones)
        {
            var surfaceZones = zones[0].SurfaceZones;
            var zoneDictionary = zones[0].ZoneDictionary;

            foreach (var zone in zones)
            {
                zone.AdjacentGroundList = new List<AdjacentContactAreaPare>();
                zone.AdjacentWallList = new List<AdjacentContactAreaPare>();
                zone.AdjacentCeilingList = new List<AdjacentContactAreaPare>();
                zone.AdjacentFloorList = new List<AdjacentContactAreaPare>();
                foreach (var envelopSurface in zone.EnvelopSurfaces)
                {
                    if (envelopSurface.EnvelopeType == EnvelopeType.Underground)
                    {
                        zone.AdjacentGroundList.Add(new AdjacentContactAreaPare
                        {
                            ContactArea = envelopSurface.GetPlanePartArea()
                        });
                        continue;
                    }

                    // 如果一个面只被一个 zone 所拥有
                    if (surfaceZones[envelopSurface.Name].Count <= 1)
                    {
                        continue;
                    }
                    // 找到相邻的 zone
                    Zone adjacentZone = null;
                    foreach (var zid in surfaceZones[envelopSurface.Name])
                    {
                        if (zid == zone.Id)
                        {
                            continue;
                        }
                        adjacentZone = zoneDictionary[zid];
                    }

                    if (adjacentZone == null)
                    {
                        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Unknown Error.");
                        return;
                    }
                    // 判断当前 surface 在当前 zone 的地板列表中还是在天花板列表中
                    if (zone.ZoneFloorList.Contains(envelopSurface))
                    {
                        zone.AdjacentFloorList.Add(new AdjacentContactAreaPare
                        {
                            Zone = adjacentZone,
                            ContactArea = envelopSurface.GetPlanePartArea()
                        });
                        continue;
                    }

                    if (zone.ZoneCeilingList.Contains(envelopSurface))
                    {
                        zone.AdjacentCeilingList.Add(new AdjacentContactAreaPare
                        {
                            Zone = adjacentZone,
                            ContactArea = envelopSurface.GetPlanePartArea()
                        });
                        continue;
                    }
                    zone.AdjacentWallList.Add(new AdjacentContactAreaPare
                    {
                        Zone = adjacentZone,
                        ContactArea = envelopSurface.GetPlanePartArea()
                    });
                }
            }
        }
        public void CalculateAdjacentZonesAndContactAreaTest(List<Zone> zones)
        {
            var surfaceZones = zones[0].SurfaceZones;
            var zoneDictionary = zones[0].ZoneDictionary;
            
                // 可能引发异常的代码

                foreach (var zone in zones)
                {                
                    zone.AdjacentGroundList = new List<AdjacentContactAreaPare>();
                    zone.AdjacentWallList = new List<AdjacentContactAreaPare>();
                    zone.AdjacentCeilingList = new List<AdjacentContactAreaPare>();
                    zone.AdjacentFloorList = new List<AdjacentContactAreaPare>();
                    foreach (var envelopSurface in zone.EnvelopSurfaces)
                    {
                        if (envelopSurface.EnvelopeType == EnvelopeType.Underground)
                        {
                            zone.AdjacentGroundList.Add(new AdjacentContactAreaPare
                            {
                                ContactArea = envelopSurface.GetPlanePartArea()
                            });
                            continue;
                        }

                        // 如果一个面只被一个 zone 所拥有
                        if (surfaceZones[envelopSurface.Name].Count <= 1)
                        {
                            continue;
                        }
                        // 找到相邻的 zone
                        List<Zone> adjacentZone = new List<Zone>();
                    try
                    {
                        foreach (var zoneID in surfaceZones[envelopSurface.Name])
                        {
                            if (zoneID == zone.Id)
                            {
                                continue;
                            }
                            adjacentZone.Add(zoneDictionary[zoneID]);
                        }
                    }
                    catch ( NullReferenceException ex)                    
                    { AddRuntimeMessage(GH_RuntimeMessageLevel.Error, $"HERE: {ex.Message}"); }

                        if (adjacentZone == null)
                        {
                            AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Unknown Error.");
                            return;
                        }
                    // 判断当前 surface 在当前 zone 的地板列表中还是在天花板列表中
                    try
                    {
                        if (zone.ZoneFloorList.Contains(envelopSurface))//如果surface是当前zone的地板
                        {
                            for (int i = 0; i < adjacentZone.Count; i++)
                            {
                                if (envelopSurface.Name == adjacentZone[i].ZoneCeilingList[0].Name)
                                {
                                    zone.AdjacentFloorList.Add(new AdjacentContactAreaPare
                                    {
                                        Zone = adjacentZone[i],
                                        ContactArea = Math.Min(adjacentZone[i].ZoneCeilingList[0].GetPlanePartArea(),envelopSurface.GetPlanePartArea())//取相邻zone天花板的面积作为相邻面积
                                    });
                                }
                            }
                            continue;
                        }

                        if (zone.ZoneCeilingList.Contains(envelopSurface))
                        {
                            for (int i = 0; i < adjacentZone.Count; i++)
                            {
                                if (envelopSurface.Name == adjacentZone[i].ZoneFloorList[0].Name)
                                {
                                    zone.AdjacentCeilingList.Add(new AdjacentContactAreaPare
                                    {
                                        Zone = adjacentZone[i],
                                        ContactArea = Math.Min(adjacentZone[i].ZoneFloorList[0].GetPlanePartArea(), envelopSurface.GetPlanePartArea())//取相邻zone天花板的面积作为相邻面积
                                    });
                                }
                            }
                            continue;
                        }

                        zone.AdjacentWallList.Add(new AdjacentContactAreaPare
                        {
                            Zone = adjacentZone[0],
                            ContactArea = envelopSurface.GetPlanePartArea()
                        });

                    }
                    catch (NullReferenceException ex)
                    {
                        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, $"wodefa:Null reference exception: {ex.Message}");
                    }

                }
                
            }
            
        }

        private List<Schedule> GetMonthlySchedulesFromZones(List<Zone> zones)
        {
            var monthlySchedules = new List<Schedule>();
            foreach (var zone in zones)
            {
                if (zone.IndoorTemperatureSetPointSchedule != null)
                {
                    var schedule = zone.IndoorTemperatureSetPointSchedule;
                    if (!monthlySchedules.Contains(schedule))
                    {
                        monthlySchedules.Add(schedule);
                    }
                }

                if (zone.BuildingUseSchedule != null)
                {
                    var schedule = zone.BuildingUseSchedule;
                    if (!monthlySchedules.Contains(schedule))
                    {
                        monthlySchedules.Add(zone.BuildingUseSchedule);
                    }
                }

                if (zone.AirInfiltrationSchedule != null)
                {
                    var schedule = zone.AirInfiltrationSchedule;
                    if (!monthlySchedules.Contains(schedule))
                    {
                        monthlySchedules.Add(schedule);
                    }
                }
            }
            return monthlySchedules;
        }
        private List<Schedule> GetBuildingUseSchedulesFromMonthly(List<Schedule> monthlySchedules)
        {
            var buildingUse = new List<Schedule>();
            foreach (var monthlySchedule in monthlySchedules)
            {
                if (monthlySchedule.ScheduleType == ScheduleType.MonthlyBus)
                {
                    foreach (var timespanSchedulePair in monthlySchedule.RelatedSchedules)
                    {
                        if (!buildingUse.Contains(timespanSchedulePair.RelatedSchedule))
                        {
                            buildingUse.Add(timespanSchedulePair.RelatedSchedule);
                        }
                    }
                }
            }

            return buildingUse;
        }
        private List<Schedule> GetItssFromMonthly(List<Schedule> monthlySchedules)
        {
            var itss = new List<Schedule>();
            foreach (var monthlySchedule in monthlySchedules)
            {
                if (monthlySchedule.ScheduleType == ScheduleType.MonthlyItss)
                {
                    foreach (var timespanSchedulePair in monthlySchedule.RelatedSchedules)
                    {
                        if (!itss.Contains(timespanSchedulePair.RelatedSchedule))
                        {
                            itss.Add(timespanSchedulePair.RelatedSchedule);
                        }
                    }
                }
            }

            return itss;
        }

        private List<EnvelopeSetting> GetEnvelopeSettings(List<Zone> zones, ref List<LightingSetting> lightingSettings, ref List<HVAC> hvacList)
        {
            var surfaces = new List<EnvelopeSetting>();
            foreach (var zone in zones)
            {
                foreach (var surface in zone.EnvelopSurfaces)
                {
                    if (!surfaces.Contains(surface))
                    {
                        surfaces.Add(surface);
                    }
                }
                if (zone.HvacTemplate != null && !lightingSettings.Contains(zone.LightingTemplate))
                {
                    lightingSettings.Add(zone.LightingTemplate);
                }
                if (zone.HvacTemplate != null && !hvacList.Contains(zone.HvacTemplate))
                {
                    hvacList.Add(zone.HvacTemplate);
                }
            }
            return surfaces;
        }
        private List<Modules.Material> GetAllMaterials(List<EnvelopeSetting> surfaces)
        {
            var allMaterials = new List<Modules.Material>();
            foreach (var surface in surfaces)
            {
                var materials = surface.GetAllMaterials();
                foreach (var material in materials)
                {
                    if (!allMaterials.Contains(material))
                    {
                        allMaterials.Add(material);
                    }
                }
            }
            return allMaterials;
        }

        private void GroupingMaterials(List<Modules.Material> materials,
            ref List<Modules.Material> externalWallMaterials,
            ref List<Modules.Material> internalWallMaterials,
            ref List<Modules.Material> roofMaterials,
            ref List<Modules.Material> windowMaterials,
            ref List<Modules.Material> externalFloorMaterials,
            ref List<Modules.Material> internalFloorMaterials)
        {
            foreach (var material in materials)
            {
                if (material.MaterialType == MaterialType.ExternalWall)
                {
                    externalWallMaterials.Add(material);
                }

                if (material.MaterialType == MaterialType.InternalWall)
                {
                    internalWallMaterials.Add(material);
                }

                if (material.MaterialType == MaterialType.Roof)
                {
                    roofMaterials.Add(material);
                }

                if (material.MaterialType == MaterialType.Window)
                {
                    windowMaterials.Add(material);
                }

                if (material.MaterialType == MaterialType.ExternalFloor)
                {
                    externalFloorMaterials.Add(material);
                }

                if (material.MaterialType == MaterialType.InternalFloor)
                {
                    internalFloorMaterials.Add(material);
                }
            }
        }
    }
}