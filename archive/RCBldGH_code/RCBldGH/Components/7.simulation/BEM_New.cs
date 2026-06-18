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
using System.Linq;

namespace RCBldGH.Components.Others
{
    public class BEMComp_alpha : GH_Component
    {
        public BEMComp_alpha()
            : base("BEM3.0", "BEM",
                "Building energy model",
                "RCBldGH", "7.Simulation")
        {
        }

        public override Guid ComponentGuid => new Guid("{5078544a-5878-44d9-8571-8868870a7191}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.BUS;
        protected override void RegisterInputParams(GH_Component.GH_InputParamManager pManager)
        {
            pManager.AddGenericParameter("SuperBreps", "Z", "Zones", GH_ParamAccess.list);
            pManager[0].DataMapping = GH_DataMapping.Flatten;
            pManager.AddGenericParameter("Basics", "B", "Basics", GH_ParamAccess.item);            
            
            pManager.AddGenericParameter("DHW", "DHW", "DHW", GH_ParamAccess.item);
            pManager.AddGenericParameter("Pumps", "P", "Pumps", GH_ParamAccess.item);
            pManager.AddGenericParameter("Energy Sources", "E", "Energy Sources", GH_ParamAccess.item);
            pManager.AddGenericParameter("BEM Type", "BT", "1. Class D: No building automation function,  2. Class C: adapting the operation of the building and technical systems to users needs, 3. Class B: optimizing the operation by the tuning of the different controllers and standard alarming and monitoring functions, 4. Class A: detecting faults of building and technical systems and providing support to the diagnosis of these faults, Reporting information regarding energy consumption, indoor conditions, and possibilities for improvement.", GH_ParamAccess.item);            
            pManager.AddGenericParameter("Renewable System", "R", "Renewable System", GH_ParamAccess.item);
           
        }

        protected override void RegisterOutputParams(GH_Component.GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("BUS Data", "D", "BUS Data.", GH_ParamAccess.item);
            //pManager.AddGenericParameter("BUS Data", "D", "BUS Data.", GH_ParamAccess.list);
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
            Data busData = new Data();
            Plane plane = Plane.WorldXY;            
            busData.Plane = plane;
            // 获取全部 Zone
            var zones = GetAllSuperBreps(DA);
            busData.SuperBreps = zones;
            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, ($"program and schedule setting applied to {zones[0].Envelop[0].Material.MaterialType}"));
            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, "Start.");

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

            List<RCBldGH.Modules.Envelope> surfaces = GetEnvelopeSettings(zones, ref lightingSettings, ref hvacList);

            busData.HvacList = hvacList;
            busData.LightingSettings = lightingSettings;
            busData.Surfaces = surfaces;

            //DA.SetDataList(1, surfaces);
            // 获取全部材质
            List<Modules.Material> materials = GetAllMaterials(surfaces);
            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, "1.0");
            // 材质分组
            List<Modules.Material> externalWallMaterials = new List<Modules.Material>();
            List<Modules.Material> internalWallMaterials = new List<Modules.Material>();
            List<Modules.Material> windowMaterials = new List<Modules.Material>();
            List<Modules.Material> roofMaterials = new List<Modules.Material>();
            List<Modules.Material> externalFloorMaterials = new List<Modules.Material>();
            List<Modules.Material> internalFloorMaterials = new List<Modules.Material>();
            List<Modules.Material> GroundMaterials = new List<Modules.Material>();
            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, "1.1");
            GroupingMaterials(materials, ref externalWallMaterials, ref internalWallMaterials, ref roofMaterials,
                ref windowMaterials, ref externalFloorMaterials, ref internalFloorMaterials,ref GroundMaterials);

            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, "1.2");
            busData.ExternalWallMaterials = externalWallMaterials;
            busData.InternalWallMaterials = internalWallMaterials;
            busData.WindowMaterials = windowMaterials;
            busData.RoofMaterials = roofMaterials;
            busData.ExternalFloorMaterials = externalFloorMaterials;
            busData.InternalFloorMaterials = internalFloorMaterials;
            busData.GroundMaterials= GroundMaterials;
            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, "2.");
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
            
            double maxX = 0;
            double minX = 0;
            double maxY = 0;
            double minY = 0;
            double minZ = 0;
            double maxZ = 0;
            double groundFloorArea = 0;
            List<double> rooms = new List<double> {};   
            foreach (var brep in busData.SuperBreps)
            {
                groundFloorArea += brep.GroundSetting.Area;
                rooms.Add(brep.MinZ);
                if (brep.MinX < minX)
                {
                    minX = brep.MinX;
                }
                if (brep.MinY < minY)
                {
                    minY = brep.MinY;
                }
                if (brep.MinZ < minZ)
                {
                    minZ = brep.MinZ;
                }
                if (brep.MaxZ > maxZ)
                {
                    maxZ = brep.MaxZ;
                }
                if (brep.MaxX > maxX)
                {
                    maxX = brep.MaxX;
                }
                if (brep.MaxY > maxY)
                {
                    maxY = brep.MaxY;
                }
            }
            var uniqueZCoordinates = rooms.Distinct();
            busData.Basics.Floors = uniqueZCoordinates.Count();
            busData.Basics.BuildingArea = groundFloorArea;
            busData.Basics.BuildingHeight = maxZ - minZ;
            busData.Basics.BuildingLength = maxX - minX;
            busData.Basics.BuildingWidth = maxY - minY;
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

            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, "3.");
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
            //AddRuntimeMessage(GH_RuntimeMessageLevel.Remark, "4.");
            DA.SetData(0, busData);
        }
        
        /// 获取全部 Zone        
        public List<SuperBrep> GetAllSuperBreps(IGH_DataAccess DA)
        {
            List<SuperBrep> zones = new List<SuperBrep>();
            
            if (DA.GetDataList("SuperBreps", zones))
            {
                if (DA.Iteration > 0)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Zones CANNOT be DataTree.");
                    return zones;
                }
                if (zones.Count < 1)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Zones cannot be an empty list.");
                    return zones;
                }
            }
            return zones;
        }

        private List<Schedule> GetMonthlySchedulesFromZones(List<SuperBrep> zones)
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

        private List<Modules.Envelope> GetEnvelopeSettings(List<SuperBrep> zones, ref List<LightingSetting> lightingSettings, ref List<HVAC> hvacList)
        {
            var surfaces = new List<Modules.Envelope>();
            foreach (var zone in zones)
            {
                foreach (var surface in zone.Envelop)
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
        private List<Modules.Material> GetAllMaterials(List<Modules.Envelope> surfaces)
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
            ref List<Modules.Material> internalFloorMaterials,ref List<Modules.Material> GroundMaterials)
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
                if (material.MaterialType == MaterialType.Ground)
                {
                    GroundMaterials.Add(material);
                }
            }
        }
    }
}