using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Grasshopper.Kernel.Types;
using Rhino;
using Rhino.Geometry;
using RCBldGH.Domains;
using RCBldGH.Modules;
using RCBldGH.Utils;
using RCBldGH.Components.Envelope;
using System.Security.Policy;

namespace RCBldGH.Modules
{
    public enum AirInfiltrationLevel
    {
        Low=1,
        Medium=2,
        High=3
    }
    public enum VentilationType
    {
        MechanicalVentOnly=1,
        MechanicalVentShared=2,
        NaturalVentOnly=3
    }
    public enum DistinguishFloorResult
    {
        Success,
        MultiPlane, // 属于异常的状态，标记为地板属性的 surface 不共面超过两个，没法区分地板和天花板
        NoFloor, // 整个 Zone 没有地板或 underground，属于异常的状态 
        NotRun // 还没有执行辨别
    }
    public struct AdjacentContactAreaPare
    {
        public Zone Zone { get; set; }
        public double ContactArea { get; set; }
    }
    public struct AdjacentBrepAreaPare
    {
        public SuperBrep SuperBrep { get; set; }
        public double ContactArea { get; set; }
    }

    public class Program
    { 
        
        public double Occupancy { get; set; }
        public double MetabolicRate { get; set; }
        public double Appliance { get; set; }
        public LightingSetting LightingTemplate { get; set; }
        public double OutdoorAir { get; set; }
        public double AirInfiltrationRate { get; set; }
        public AirInfiltrationLevel AirInfiltrationLevel { get; set; }
        public Schedule AirInfiltrationSchedule { get; set; }
        public VentilationType VentilationType { get; set; }
        public bool NightFlushing { get; set; }
        public double WindowAreaOpenPercentage { get; set; }
        public double AngleOfOpening { get; set; }
        public double DHW { get; set; }
        public Schedule IndoorTemperatureSetPointSchedule { get; set; }
        public Schedule BuildingUseSchedule { get; set; }
        public HVAC HvacTemplate { get; set; }
    }
    public class Zone
    {
        public Zone()
        {
            this.Id = Guid.NewGuid().ToString();
        }

        private const string Br = "\r\n";
        public string Name { get; set; }
        public string Id { get; set; }
        public double[] SolarOP { get; set; }
        public double[] SolarW { get; set; }
        /// 当前 Zone 对应的所有 EnvelopeSurface 的列表                  
        public List<EnvelopeSetting> EnvelopSurfaces
        {
            get
            {
                List<EnvelopeSetting> result = new List<EnvelopeSetting>();
                result.AddRange(UndergroundSurfaces);
                result.AddRange(ExternalFloorSurfaces);
                result.AddRange(InternalFloorSurfaces);
                result.AddRange(WallSurfaces);
                result.AddRange(RoofSurfaces);
                return result;
            }
        }
        public List<EnvelopeSetting> UndergroundSurfaces { get; } = new List<EnvelopeSetting>();
        public List<EnvelopeSetting> RoofSurfaces { get; } = new List<EnvelopeSetting>();
        public List<EnvelopeSetting> ExternalFloorSurfaces { get; } = new List<EnvelopeSetting>();
        public List<EnvelopeSetting> InternalFloorSurfaces { get; } = new List<EnvelopeSetting>();
        public List<EnvelopeSetting> WallSurfaces { get; } = new List<EnvelopeSetting>();


        // 下面两个属性用于在 BEM 电池中判断 zone 的相邻关系。
        public Dictionary<string, List<string>> SurfaceZones { get; set; }
        public Dictionary<string, Zone> ZoneDictionary { get; set; }   
        
        /// <summary>
        /// 
        /// </summary>
        public double Length { get; set; } = double.NaN;
        private string LengthStr => double.IsNaN(Length) ? "-" : Converter.DoubleToString(Length);
        public double Width { get; set; } = double.NaN;
        private string WidthStr => double.IsNaN(Width) ? "-" : Converter.DoubleToString(Width);
        public double Area { get; set; } = double.NaN;
        private string AreaStr => double.IsNaN(Area) ? "-" : Converter.DoubleToString(Area);
        public double Height { get; set; } = double.NaN;
        private string HeightStr => double.IsNaN(Height) ? "-" : Converter.DoubleToString(Height);
        public double Occupancy  { get; set; } = double.NaN;
        private string OccupancyStr => double.IsNaN(Occupancy) ? "-" : Converter.DoubleToString(Occupancy);
        public double MetabolicRate { get; set; } = double.NaN;
        private string MetabolicRateStr => double.IsNaN(MetabolicRate) ? "-" : Converter.DoubleToString(MetabolicRate);
        public double Appliance { get; set; } = double.NaN;
        private string ApplianceStr => double.IsNaN(Appliance) ? "-" : Converter.DoubleToString(Appliance);
        public LightingSetting LightingTemplate { get; set; }
        private string LightingTemplateStr => LightingTemplate == null ? "-" : LightingTemplate.LightingName;
        public double OutdoorAir { get; set; } = double.NaN;
        private string OutdoorAirStr => double.IsNaN(OutdoorAir) ? "-" : Converter.DoubleToString(OutdoorAir);
        public AirInfiltrationLevel AirInfiltrationLevel { get; set; }
        private string AirInfiltrationLevelStr => AirInfiltrationLevel == 0 ? "-" : ((int)AirInfiltrationLevel).ToString();
        public double AirInfiltrationRate { get; set; } = double.NaN;
        private string AirInfiltrationRateStr => double.IsNaN(AirInfiltrationRate) ? "-" : Converter.DoubleToString(AirInfiltrationRate);
        public Schedule AirInfiltrationSchedule { get; set; }
        private string AirInfiltrationScheduleStr => AirInfiltrationSchedule == null ? "-" : AirInfiltrationSchedule.Name;
        public VentilationType VentilationType { get; set; }
        private string VentilationTypeStr => VentilationType == 0 ? "-" : ((int)VentilationType).ToString();
        public bool NightFlushing { get; set; }
        public double WindowAreaOpenPercentage { get; set; } = double.NaN;
        private string WindowAreaOpenPercentageStr => double.IsNaN(WindowAreaOpenPercentage) ? "-" : Converter.DoubleToString(WindowAreaOpenPercentage);
        public double AngleOfOpening { get; set; } = double.NaN;
        private string AngleOfOpeningStr => double.IsNaN(AngleOfOpening) ? "-" : Converter.DoubleToString(AngleOfOpening);
        public double DHW { get; set; } = double.NaN;
        private string DHWStr => double.IsNaN(DHW) ? "-" : Converter.DoubleToString(DHW);
        public Schedule IndoorTemperatureSetPointSchedule { get; set; }
        private string IndoorTemperatureSetPointScheduleStr => IndoorTemperatureSetPointSchedule == null ? "-" : IndoorTemperatureSetPointSchedule.Name;
        public Schedule BuildingUseSchedule { get; set; }
        private string BuildingUseScheduleStr => BuildingUseSchedule == null ? "-" : BuildingUseSchedule.Name;
        public HVAC HvacTemplate { get; set; }
        private string HvacTemplateStr => HvacTemplate == null ? "-" : HvacTemplate.Name;
        public int Multiplier { get; set; } = -1;
        private string MultiplierStr => Multiplier < 0 ? "-" : Multiplier.ToString();


        public Material InteriorFloorMaterial { get; set; }
        private string InteriorFloorMaterialStr => InteriorFloorMaterial == null ? "-" : InteriorFloorMaterial.Name;

        public Material InteriorWallMaterial { get; set; }
        private string InteriorWallMaterialStr => InteriorWallMaterial == null ? "-" : InteriorWallMaterial.Name;
        public EnvelopeSetting SExternalFacadeSetting { get; set; }
        private string SExternalFacadeSettingStr => SExternalFacadeSetting == null ? "-" : SExternalFacadeSetting.Name;

        public EnvelopeSetting EExternalFacadeSetting { get; set; }
        private string EExternalFacadeSettingStr => EExternalFacadeSetting == null ? "-" : EExternalFacadeSetting.Name;

        public EnvelopeSetting NExternalFacadeSetting { get; set; }
        private string NExternalFacadeSettingStr => NExternalFacadeSetting == null ? "-" : NExternalFacadeSetting.Name;

        public EnvelopeSetting WExternalFacadeSetting { get; set; }
        private string WExternalFacadeSettingStr => WExternalFacadeSetting == null ? "-" : WExternalFacadeSetting.Name;

        public EnvelopeSetting NeExternalFacadeSetting { get; set; }
        private string NeExternalFacadeSettingStr => NeExternalFacadeSetting == null ? "-" : NeExternalFacadeSetting.Name;

        public EnvelopeSetting NwExternalFacadeSetting { get; set; }
        private string NwExternalFacadeSettingStr => NwExternalFacadeSetting == null ? "-" : NwExternalFacadeSetting.Name;

        public EnvelopeSetting SeExternalFacadeSetting { get; set; }
        private string SeExternalFacadeSettingStr => SeExternalFacadeSetting == null ? "-" : SeExternalFacadeSetting.Name;

        public EnvelopeSetting SwExternalFacadeSetting { get; set; }
        private string SwExternalFacadeSettingStr => SwExternalFacadeSetting == null ? "-" : SwExternalFacadeSetting.Name;

        public EnvelopeSetting RoofSetting { get; set; }
        private string RoofSettingStr => RoofSetting == null ? "-" : RoofSetting.Name;

        public EnvelopeSetting GroundSlabSetting { get; set; }
        private string GroundSlabSettingStr => GroundSlabSetting == null ? "-" : GroundSlabSetting.Name;

        // 因为在 RunComponent 中计算相邻时，每运行一次都需要初始化一次，所以在 Run 电池中也要初始化。
        public List<AdjacentContactAreaPare> AdjacentWallList { get; set; } = new List<AdjacentContactAreaPare>();
        public List<AdjacentContactAreaPare> AdjacentCeilingList { get; set; } = new List<AdjacentContactAreaPare>();
        // 当前 Zone 地板下方的 Zone
        public List<AdjacentContactAreaPare> AdjacentFloorList { get; set; } = new List<AdjacentContactAreaPare>();
        // 相邻的地面
        public List<AdjacentContactAreaPare> AdjacentGroundList { get; set; } = new List<AdjacentContactAreaPare>();

        public string ToCen()
        {
            var result = $"Zone Name: {Name}\t!!! specify the zone name" + Br;
            result +=
                $"Length: {LengthStr} \t!!! unit: m" + Br;
            result +=
                $"Width: {WidthStr} \t!!! unit: m" + Br;
            result +=
                $"Area: {AreaStr}\t!!! unit: m2" + Br;
            result +=
                $"Height: {HeightStr}\t!!! unit: m" + Br;
            result +=
                $"Occupancy: {OccupancyStr}\t!!! unit: m2/person " + Br;
            result +=
                $"Metabolic Rate: {MetabolicRateStr}\t!!! unit: W/person" + Br;
            result +=
                $"Appliance: {ApplianceStr}\t\t!!! W/m2" + Br;
            result +=
                $"Lighting Template: {LightingTemplateStr} \t!!!specify a predefined lighting system" + Br;
            result +=
                $"Outdoor Air: {OutdoorAirStr}\t!!! unit: liter/s/person. If ignored, then mininum outdoor air default will be used" + Br;
            result +=
                $"Air Infiltration Level: {AirInfiltrationLevelStr} \t!!! 1. low, 2. medium, 3. High" + Br;
            result +=
                $"Air Infiltration Rate: {AirInfiltrationRateStr} \t!!! leave blank if air infiltration level is used, unit: /h air change rate at Q4Pa" + Br;
            result +=
                $"Air Infiltration Schedule: {AirInfiltrationScheduleStr} \t!!! specify a predefined monthly air infiltration schedule" + Br;
            result +=
                $"Ventilation Type: {VentilationTypeStr} \t!!! 1. Mechanical vent only, 2. Mechanical vent shared w/ Natural, 3. Natural vent only. Note: zones that don't have external structures can't apply natural ventilation" + Br;
            result +=
                $"Night Flushing: {Converter.BoolToCenNum(NightFlushing)} \t!!! 1. Yes, 2. No" + Br;
            result +=
                $"Window Area Open Percentage: {WindowAreaOpenPercentageStr} \t!!! if natural ventilation is used, specify the opened area percentage of total window area, unit: %" +
                Br;
            result +=
                $"Angle of Opening: {AngleOfOpeningStr} \t!!! if natural ventilation is used, specify the angle of opening for bottom hung windows, unit: degree" + Br;
            result +=
                $"DHW: {DHWStr} \t\t!!! unit: liter/m2/month" + Br;
            result +=
                $"Indoor Temperature Setpoint Schedule: {IndoorTemperatureSetPointScheduleStr} \t!!!specify a predefined indoor temperature setpoint schedule" + Br;
            result +=
                $"Building Use Schedule: {BuildingUseScheduleStr} \t!!!specify a predefined building use schedule" + Br;
            result +=
                $"HVAC Template: {HvacTemplateStr} \t!!!specify a predefined HVAC system" + Br;
            result +=
                $"Multiplier: {MultiplierStr}\t!!! If ignored, floor number will be used as multiplier of this zone" + Br;
            result +=
                $"Interior Floor Material: {InteriorFloorMaterialStr} \t!!!specify the material of interior floor, for the 1st floor, leave it '-'" + Br;
            result +=
                $"Interior Wall Material: {InteriorWallMaterialStr} \t!!!specify the material of interior wall, which is defined in wall materials" +
                Br;
            result +=
                $"South Facing External Facade Setting: {SExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
            result +=
                $"East Facing External Facade Setting: {EExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
            result +=
                $"North Facing External Facade Setting: {NExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
            result +=
                $"West Facing External Facade Setting: {WExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
            
            result +=
                $"Southeast Facing External Facade Setting: {SeExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
            result +=
                $"Northeast Facing External Facade Setting: {NeExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
            result +=
                $"Northwest Facing External Facade Setting: {NwExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
            result +=
                $"Southwest Facing External Facade Setting: {SwExternalFacadeSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
            result +=
                $"Roof Setting: {RoofSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" + Br;
            result +=
                $"Ground Slab Setting: {GroundSlabSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" +
                Br;
            // Adjacent Wall Zone
            result += "Adjacent Wall Zone Name and Contact Area: ";
            if (AdjacentWallList.Count==0)
            {
                result += "-";
            }
            else
            {
                for (int i = 0; i < AdjacentWallList.Count; i++)
                {
                    var adjacentWall = AdjacentWallList[i];
                    result += $"{adjacentWall.Zone.Name}, {Converter.DoubleToString(adjacentWall.ContactArea)}";
                    if (i!= AdjacentWallList.Count-1)
                    {
                        result += "; ";
                    }
                }
            }
            result += " \t!!!specify the name of neigboring zone and contact area" + Br;

            // Adjacent Ceiling Zone
            result += "Adjacent Ceiling Zone Name and Contact Area: ";
            if (AdjacentCeilingList.Count == 0)
            {
                result += "-";
            }
            else
            {
                for (int i = 0; i < AdjacentCeilingList.Count; i++)
                {
                    var adjacent = AdjacentCeilingList[i];
                    result += $"{adjacent.Zone.Name}, {Converter.DoubleToString(adjacent.ContactArea)}";
                    if (i != AdjacentCeilingList.Count - 1)
                    {
                        result += "; ";
                    }
                }
            }
            result+= "\t!!!specify the name of neigboring zone and contact area" + Br;

            // Adjacent Floor Zone
            result += "Adjacent Floor Zone Name and Contact Area: ";
            if (AdjacentGroundList.Count == 0 && AdjacentFloorList.Count == 0)
            {
                result += "-";
            }
            else
            {
                for (int i = 0; i < AdjacentGroundList.Count; i++)
                {
                    var adjacent = AdjacentGroundList[i];
                    result += $"ground, {Converter.DoubleToString(adjacent.ContactArea)}";
                }
                for (int i = 0; i < AdjacentFloorList.Count; i++)
                {
                    var adjacent = AdjacentFloorList[i];
                    result += $"{adjacent.Zone.Name}, {Converter.DoubleToString(adjacent.ContactArea)}";
                    if (i != AdjacentFloorList.Count - 1)
                    {
                        result += "; ";
                    }
                }
            }
            result += " \t!!!specify the name of neigboring zone and contact area" + Br;

            
            return result;
        }       
        public override string ToString()
        {
            return $"Zone - Name: {this.Name}";
        }

        public bool IsZoneClosedTest(out Brep closedBrep,out List<GH_Surface> gSurfaces)
        {
            // 使用 LINQ 直接收集所有的 surfaces
            gSurfaces = EnvelopSurfaces.SelectMany(envelopeSetting =>
                (envelopeSetting.Opaques?.Select(opaque => opaque.GeometrySurface) ?? Enumerable.Empty<GH_Surface>())
                .Concat(envelopeSetting.Slabs?.Select(slab => slab.GeometrySurface) ?? Enumerable.Empty<GH_Surface>())
                .Concat(envelopeSetting.Windows?.Select(window => window.GeometrySurface) ?? Enumerable.Empty<GH_Surface>())
            ).ToList();

            // 转换为 Brep 列表
            List<Brep>breps = gSurfaces.Select(ghSurface => ghSurface.Face.Brep).ToList();

            // 尝试合并 Breps
            closedBrep = null;
            Brep[] resultBreps = Brep.JoinBreps(breps, Rhino.RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);

            // 提前返回，减少嵌套和冗余检查
            if (resultBreps == null )
            {
                return false;
            }

            // 判断合并后的Brep是否封闭
            for (int i = 0; i < resultBreps.Length; i++)
            {
                if (resultBreps[i].IsSolid)
                {
                    closedBrep = resultBreps[i];
                    return true;
                }
            }          
            return false;
        }
        public bool IsZoneClosed(out Brep closedBrep)
        {
            // 使用 LINQ 直接收集所有的 surfaces
            var gSurfaces = EnvelopSurfaces.SelectMany(envelopeSetting =>
                (envelopeSetting.Opaques?.Select(opaque => opaque.GeometrySurface) ?? Enumerable.Empty<GH_Surface>())
                .Concat(envelopeSetting.Slabs?.Select(slab => slab.GeometrySurface) ?? Enumerable.Empty<GH_Surface>())
                .Concat(envelopeSetting.Windows?.Select(window => window.GeometrySurface) ?? Enumerable.Empty<GH_Surface>())
            ).ToList();

            // 转换为 Brep 列表
            var breps = gSurfaces.Select(ghSurface => ghSurface.Face.Brep).ToList();

            // 尝试合并 Breps
            closedBrep = null;
            Brep[]resultBreps = Brep.JoinBreps(breps, Rhino.RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);

            // 提前返回，减少嵌套和冗余检查
            if (resultBreps == null)
            {
                return false;
            }

            // 判断合并后的Brep是否封闭
            if (resultBreps[0].IsSolid)
            {
                closedBrep = resultBreps[0];
                return true;
            }

            return false;
        }

        /// <summary>
        /// 将 EnvelopeSurface 加入到当前 Zone 中，加入的同时对 Surface 进行分类。
        /// </summary>
        /// <returns></returns>
        public void AddSurface(EnvelopeSetting surface)
        {
            // 如果是 Underground 类型，直接当做地板
            if (surface.EnvelopeType == EnvelopeType.Underground)
            {
                UndergroundSurfaces.Add(surface);
                return;
            }

            if (surface.GetMainMaterial().MaterialType == MaterialType.Ground)
            {
                UndergroundSurfaces.Add(surface);
                return;
            }

            // Roof
            if (surface.GetMainMaterial().MaterialType == MaterialType.Roof)
            {
                RoofSurfaces.Add(surface);
                return;
            }

            if (surface.GetMainMaterial().MaterialType == MaterialType.InternalFloor)
            {
                InternalFloorSurfaces.Add(surface);
                return;
            }

            if (surface.GetMainMaterial().MaterialType == MaterialType.ExternalFloor)
            {
                ExternalFloorSurfaces.Add(surface);
                return;
            }

            WallSurfaces.Add(surface);
        }

        /// <summary>
        /// 计算当前 Zone 的面积。
        /// </summary>
        /// <returns></returns>
        public double GetZoneArea()
        {
            double area = 0;
            if (this.FloorDistinguishResult==DistinguishFloorResult.NotRun)
            {
                this.FloorDistinguishResult = DistinguishFloor();
            }

            if (ZoneFloorList.Count==0)
            {
                return area;
            }

            foreach (var surface in ZoneFloorList)
            {
                if (surface.EnvelopeType==EnvelopeType.Underground)
                {
                    foreach (var slab in surface.Slabs)
                    {
                        if (slab.Area>0)
                        {
                            area += slab.Area;
                        }
                    }
                    continue;
                }

                foreach (var opaque in surface.Opaques)
                {
                    if (opaque.Area>0)
                    {
                        area += opaque.Area;
                    }
                }
            }

            return area;
        }


        public DistinguishFloorResult FloorDistinguishResult { get; set; } = DistinguishFloorResult.NotRun;        
        public List<EnvelopeSetting> ZoneFloorList { get;} = new List<EnvelopeSetting>();        
        public List<EnvelopeSetting> ZoneCeilingList { get; } = new List<EnvelopeSetting>();

        /// <summary>
        /// 判断 ExternalWall 的朝向
        /// </summary>
        public void SetExternalFacade(Plane plane)
        {
            foreach (var surface in EnvelopSurfaces)
            {
                if (surface.EnvelopeType == EnvelopeType.Underground)
                {
                    continue;
                }

                bool isAllNotExternalWall = true;
                foreach (var item in surface.Opaques)
                {
                    if (item.Material.MaterialType==MaterialType.ExternalWall)
                    {
                        isAllNotExternalWall = false;
                    }
                }
                if (isAllNotExternalWall)
                {
                    continue;
                }

                Plane surfacePlane = surface.GetPlane();
                if (surfacePlane == Plane.Unset)
                {
                    continue;
                }

                var orientation = VectorTools.GetOrientation(plane, surfacePlane.Normal);
                if (orientation == Orientation.InValid || orientation == Orientation.DOWN ||
                    orientation == Orientation.UP)
                {
                    continue;
                }

                if (orientation == Orientation.E)
                {
                    EExternalFacadeSetting = surface;
                    continue;
                }

                if (orientation == Orientation.S)
                {
                    SExternalFacadeSetting = surface;
                    continue;
                }

                if (orientation == Orientation.W)
                {
                    WExternalFacadeSetting = surface;
                    continue;
                }

                if (orientation == Orientation.N)
                {
                    NExternalFacadeSetting = surface;
                    continue;
                }

                if (orientation == Orientation.SE)
                {
                    SeExternalFacadeSetting = surface;
                    continue;
                }

                if (orientation == Orientation.NW)
                {
                    NwExternalFacadeSetting = surface;
                    continue;
                }

                if (orientation == Orientation.SW)
                {
                    SwExternalFacadeSetting = surface;
                    continue;
                }

                if (orientation == Orientation.NE)
                {
                    NeExternalFacadeSetting = surface;
                }
            }
        }
        public DistinguishFloorResult DistinguishFloor()
        {
            Plane floorPlane = Plane.Unset;
            //List<Plane> ceilingPlanes = new List<Plane>();
            Plane tempPlane = Plane.Unset;
            List<EnvelopeSetting> tempSurfaces = new List<EnvelopeSetting>();

            // Underground surface 直接当地板来用
            foreach (var undergroundSurface in UndergroundSurfaces)
            {
                // 如果无法获得 underground surface 的面，跳过当前的 underground surface
                GH_Surface ghSurface;
                if (undergroundSurface.Slabs!=null && undergroundSurface.Slabs.Count>0)
                {
                    ghSurface = undergroundSurface.Slabs[0].GeometrySurface;
                }
                //if (undergroundSurface.Opaques != null && undergroundSurface.Opaques.Count > 0)
                //{
                //    ghSurface = undergroundSurface.Opaques[0].GeometrySurface;
                //}
                else
                {
                    continue;
                }

                // 如果没有 floorPlane ,直接拿当前的 underground surface 所在的平面当作 floorPlane.
                // 如果有 floorPlane ，当前 underground 的 plane 是否和 floorPlane 共面，共面就加入 Floor 列表，不共面就返回错误
                if (floorPlane == Plane.Unset)
                {
                    ghSurface.Face.TryGetPlane(out var plane, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                    floorPlane = plane;
                }
                else
                {
                    bool isCoplanar = SurfaceTools.IsPlaneGhSurfaceCoplanar(ghSurface, floorPlane);
                    if (!isCoplanar)
                    {
                        return DistinguishFloorResult.MultiPlane;
                    }
                }

                ZoneFloorList.Add(undergroundSurface);
            }
            // ExternalFloor 的处理方式和 undergroundSurface 一样。
            foreach (var surface in ExternalFloorSurfaces)
            {
                GH_Surface ghSurface= null;
                if (surface.Opaques!=null)
                {
                    foreach (var opaque in surface.Opaques)
                    {
                        if (opaque.Material.MaterialType==MaterialType.ExternalFloor)
                        {
                            ghSurface = opaque.GeometrySurface;
                            break;
                        }
                    }
                }
                else if(surface.Slabs != null)
                {
                    foreach (var opaque in surface.Opaques)
                    {
                        if (opaque.Material.MaterialType == MaterialType.ExternalFloor)
                        {
                            ghSurface = opaque.GeometrySurface;
                            break;
                        }
                    }
                }
                if (ghSurface==null)
                {
                    continue;
                }

                if (floorPlane == Plane.Unset)
                {
                    Plane plane = Plane.Unset;
                    try
                    {
                        ghSurface.Face.TryGetPlane(out plane, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                    }
                    catch (Exception)
                    {
                        continue;
                    }

                    floorPlane = plane;
                }
                else
                {
                    bool isCoplanar = SurfaceTools.IsPlaneGhSurfaceCoplanar(ghSurface, floorPlane);
                    if (!isCoplanar)
                    {
                        return DistinguishFloorResult.MultiPlane;
                    }
                }

                ZoneFloorList.Add(surface);
            }

            // 处理标记为 Roof 的 surface
            foreach (var surface in RoofSurfaces)
            {
                ZoneCeilingList.Add(surface);
            }

            // 处理标记为 InternalFloor 材质的 surface.
            foreach (var surface in InternalFloorSurfaces)
            {
                GH_Surface ghSurface=null;
                // 如果无法获取 ghSurface,跳过。
                if (surface.Opaques!=null)
                {
                    foreach (var opaque in surface.Opaques)
                    {
                        if (opaque.Material.MaterialType==MaterialType.InternalFloor)
                        {
                            ghSurface = opaque.GeometrySurface;
                            break;
                        }
                    }
                }
                
                if (ghSurface==null)
                {
                    continue;
                }

                
                // 获取当前 surface 的 plane ，命名为 ghSurfacePlane
                ghSurface.Face.TryGetPlane(out var ghSurfacePlane, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                
                // 如果没有 floor.
                if (floorPlane == Plane.Unset)
                {
                    // 先看看有没有 tempPlane。没有的话就把当前 surface 的 plane 设置为 tempPlane.
                    // 然后处理下一个 surface.
                    if (tempPlane == Plane.Unset)
                    {
                        tempPlane = ghSurfacePlane;
                        tempSurfaces.Add(surface);
                        continue;
                    }

                    // 如果存在 tempPlane，判断当前 surface 是不是和 tempPlane 共面，
                    // 如果共面把当前 surface 也加入 tempSurfaces 列表中。并处理下一个面。
                    if (SurfaceTools.IsPlaneGhSurfaceCoplanar(ghSurface, tempPlane))
                    {
                        tempSurfaces.Add(surface);
                        continue;
                    }

                    // 如果当前 surface 的 plane 和 tempPlane不共面，肯定有一个高，一个低。高的加入 ceiling,低的继续作为 temp.
                    if (tempPlane.Origin.Z > ghSurfacePlane.Origin.Z)
                    {
                        ZoneCeilingList.AddRange(tempSurfaces);
                        tempPlane = ghSurfacePlane;
                        tempSurfaces = new List<EnvelopeSetting>
                        {
                            surface
                        };
                        continue;
                    }

                    ZoneCeilingList.Add(surface);
                    continue;
                }
                // 如果 floorPlane 不为空，判断当前 surface 和 floorPlane 是否共面，
                // 共面就是 floor ，不共面就是 ceiling
                if (floorPlane != Plane.Unset)
                {
                    if (SurfaceTools.IsPlaneGhSurfaceCoplanar(ghSurface, floorPlane))
                    {
                        ZoneFloorList.Add(surface);
                        continue;
                    }
                    ZoneCeilingList.Add(surface);
                }
            }

            if (ZoneFloorList.Count == 0 && tempSurfaces.Count>0)
            {
                ZoneFloorList.AddRange(tempSurfaces);
            }

            if (ZoneFloorList.Count==0)
            {
                return DistinguishFloorResult.NoFloor;
            }

            return DistinguishFloorResult.Success;
        }
    }
}
