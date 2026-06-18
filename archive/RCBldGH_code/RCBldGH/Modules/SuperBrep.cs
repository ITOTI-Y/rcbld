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
using Grasshopper.Kernel;

namespace RCBldGH.Modules
{
    public class SuperBrep
    {
        //方便操作
        private const string Br = "\r\n";
        public double[] SolarOP { get; set; }
        public double[] SolarW { get; set; }
        private BoundingBox? BoundingBoxCache { get; set; }
        private BoundingBox GetBoundingBox()
        {
            if (BoundingBoxCache == null)
            {
                BoundingBoxCache = Brep.GetBoundingBox(false);
            }
            return BoundingBoxCache.Value;
        }
        private List<SuperSurface> _wall;
        private List<SuperSurface> _floor;
        private List<SuperSurface> _ceiling;

        //核心属性和构造函数
        public SuperBrep()
        {
            Id = Guid.NewGuid().ToString();
            Name = Id;
        }
        public SuperBrep(Brep brep)//构造函数
        {
            this.Brep = brep;
            Id = Guid.NewGuid().ToString();
            Name = Id;            
            _wall = new List<SuperSurface>();
            _floor = new List<SuperSurface>();
            _ceiling = new List<SuperSurface>();
            AdjacentWallList = new List<AdjacentBrepAreaPare> { };
            AdjacentFloorList = new List<AdjacentBrepAreaPare> { };
            AdjacentCeilingList = new List<AdjacentBrepAreaPare> { };
            AdjacentGroundList = new List<AdjacentBrepAreaPare> { };
            InitializeSurfaces();
        }
        private void InitializeSurfaces()
        {
            // 初始化 Wall、Floor 和 Ceiling 列表
            for (int i = 0; i < Brep.Faces.Count; i++)
            {
                var face = Brep.Faces[i];
                var surface = new SuperSurface(new GH_Surface(face.DuplicateFace(false)));

                // 根据法线方向将面分配到 Wall、Floor 或 Ceiling
                if (face.NormalAt(0.1, 0.1).Z >0.5)
                {
                    _ceiling.Add(surface);
                }
                else if (face.NormalAt(0.1, 0.1).Z < -0.5)
                {
                    _floor.Add(surface);
                }
                else
                {
                    _wall.Add(surface);                    
                }
            }
        }
        public string Id { get; }
        public string Name { get; set; }
        public override string ToString()
        {
            return $"SuperBrep: {Name}";
        }
        public Brep Brep { get; set; }
        public MaterialSetting MaterialSetting {get; set; }
        //##########方便运算以及方便进行后续的逻辑判断
        public List<SuperSurface> Ceiling
        {
            get { return _ceiling; }
            set
            {
                if (value != null)
                {
                    _ceiling = value;
                }
            }
        }
        public List<SuperSurface> Floor
        {
            get { return _floor; }
            set
            {
                if (value != null)
                {
                    _floor = value;
                }
            }
        }
        public List<SuperSurface> Wall
        {
            get { return _wall; }
            set
            {
                if (value != null)
                {
                    _wall = value;
                }
            }
        }
        public double MinX
        {
            get { return GetBoundingBox().Min.X; }
        }
        public double MinY
        {
            get { return GetBoundingBox().Min.Y; }
        }
        public double MinZ
        {
            get { return GetBoundingBox().Min.Z; }
        }
        public double MaxX
        {
            get { return GetBoundingBox().Max.X; }
        }
        public double MaxY
        {
            get { return GetBoundingBox().Max.Y; }
        }
        public double MaxZ
        {
            get { return GetBoundingBox().Max.Z; }
        }
        //public List<SuperSurface> ExternalFloor { get; set; }
        //public List<SuperSurface> InternalFloor { get; set; }
        //public List<SuperSurface> InternalWall { get; set; }
        //public List<SuperSurface> Ground { get; set; }
        public List<SuperSurface> ExternalWall
        {
            get
            {
                List<SuperSurface> externalWall = new List<SuperSurface> { };
                foreach (var surface in this.Wall)
                {
                    if (surface.Material.MaterialType == MaterialType.ExternalWall)
                    {
                        externalWall.Add(surface);
                    }
                }
                return externalWall;
            }                
            set { }
        }
        public List<SuperSurface> Roof {
            get
            {
                List<SuperSurface> roof = new List<SuperSurface> { };
                foreach (var surface in this.Ceiling)
                {
                    if (surface.Material.MaterialType == MaterialType.Roof)
                    {
                        roof.Add(surface);
                    }
                }
                return roof;
            }
            set { }
        }
        
        
        

        public bool IsAdjacent(SuperBrep other)
        {
            bool xIntersecting = this.MinX <= other.MaxX && this.MaxX >= other.MinX;
            // 检查Y轴上的投影是否有重叠
            bool yIntersecting = this.MinY <= other.MaxY && this.MaxY >= other.MinY;
            // 检查Z轴上的投影是否有重叠
            bool zIntersecting = this.MinZ <= other.MaxZ && this.MaxZ >= other.MinZ;
            // 如果三个轴上的投影都有重叠，则两个Box相交
            return xIntersecting && yIntersecting && zIntersecting;
        }
        public bool IsZoneClosed(out Brep closedBrep)
        {
            // 使用 LINQ 直接收集所有的 surfaces
            var gSurfaces = _wall.Select(s => s.GH_Surface)
                       .Concat(_floor.Select(s => s.GH_Surface))
                       .Concat(_ceiling.Select(s => s.GH_Surface))
                       .ToList();

            // 转换为 Brep 列表
            List<Brep> breps = gSurfaces.Select(ghSurface => ghSurface.Face.Brep).ToList();

            // 尝试合并 Breps
            closedBrep = null;
            Brep[] resultBreps = Brep.JoinBreps(breps, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);

            // 提前返回，减少嵌套和冗余检查
            if (resultBreps == null)
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
        public List<AdjacentBrepAreaPare> AdjacentWallList { get; set; } = new List<AdjacentBrepAreaPare>();
        public List<AdjacentBrepAreaPare> AdjacentCeilingList { get; set; } = new List<AdjacentBrepAreaPare>();        
        public List<AdjacentBrepAreaPare> AdjacentFloorList { get; set; } = new List<AdjacentBrepAreaPare>();       
        public List<AdjacentBrepAreaPare> AdjacentGroundList { get; set; } = new List<AdjacentBrepAreaPare>();
        //######################################################

        //储存Envelope信息
        public List<Envelope> Envelop { get; set; }        

        
        public double Length { get; set; } = double.NaN;
        public string LengthStr => double.IsNaN(Length) ? "-" : Converter.DoubleToString(Length);
        public double Width { get; set; } = double.NaN;
        public string WidthStr => double.IsNaN(Width) ? "-" : Converter.DoubleToString(Width);
        public double Area { get; set; } = double.NaN;
        public string AreaStr => double.IsNaN(Area) ? "-" : Converter.DoubleToString(Area);
        public double Height { get; set; } = double.NaN;
        public string HeightStr => double.IsNaN(Height) ? "-" : Converter.DoubleToString(Height);
        public double Occupancy { get; set; } = double.NaN;
        public string OccupancyStr => double.IsNaN(Occupancy) ? "-" : Converter.DoubleToString(Occupancy);
        public double MetabolicRate { get; set; } = double.NaN;
        public string MetabolicRateStr => double.IsNaN(MetabolicRate) ? "-" : Converter.DoubleToString(MetabolicRate);
        public double Appliance { get; set; } = double.NaN;
        public string ApplianceStr => double.IsNaN(Appliance) ? "-" : Converter.DoubleToString(Appliance);
        public LightingSetting LightingTemplate { get; set; }
        public string LightingTemplateStr => LightingTemplate == null ? "-" : LightingTemplate.LightingName;
        public double OutdoorAir { get; set; } = double.NaN;
        public string OutdoorAirStr => double.IsNaN(OutdoorAir) ? "-" : Converter.DoubleToString(OutdoorAir);
        public AirInfiltrationLevel AirInfiltrationLevel { get; set; }
        public string AirInfiltrationLevelStr => AirInfiltrationLevel == 0 ? "-" : ((int)AirInfiltrationLevel).ToString();
        public double AirInfiltrationRate { get; set; } = double.NaN;
        public string AirInfiltrationRateStr => double.IsNaN(AirInfiltrationRate) ? "-" : Converter.DoubleToString(AirInfiltrationRate);
        public Schedule AirInfiltrationSchedule { get; set; }
        public string AirInfiltrationScheduleStr => AirInfiltrationSchedule == null ? "-" : AirInfiltrationSchedule.Name;
        public VentilationType VentilationType { get; set; }
        public string VentilationTypeStr => VentilationType == 0 ? "-" : ((int)VentilationType).ToString();
        public bool NightFlushing { get; set; }
        public string NightFlushingStr => NightFlushing == false ? "2" : "1";
        public double WindowAreaOpenPercentage { get; set; } = double.NaN;
        public string WindowAreaOpenPercentageStr => double.IsNaN(WindowAreaOpenPercentage) ? "-" : Converter.DoubleToString(WindowAreaOpenPercentage);
        public double AngleOfOpening { get; set; } = double.NaN;
        public string AngleOfOpeningStr => double.IsNaN(AngleOfOpening) ? "-" : Converter.DoubleToString(AngleOfOpening);
        public double DHW { get; set; } = double.NaN;
        public string DHWStr => double.IsNaN(DHW) ? "-" : Converter.DoubleToString(DHW);
        public Schedule IndoorTemperatureSetPointSchedule { get; set; }
        public string IndoorTemperatureSetPointScheduleStr => IndoorTemperatureSetPointSchedule == null ? "-" : IndoorTemperatureSetPointSchedule.Name;
        public Schedule BuildingUseSchedule { get; set; }
        public string BuildingUseScheduleStr => BuildingUseSchedule == null ? "-" : BuildingUseSchedule.Name;
        public HVAC HvacTemplate { get; set; }
        public string HvacTemplateStr => HvacTemplate == null ? "-" : HvacTemplate.Name;
        public int Multiplier { get; set; } = 1;
        public string MultiplierStr => Multiplier < 0 ? "-" : Multiplier.ToString();


        public Material InteriorFloorMaterial { get; set; }
        public string InteriorFloorMaterialStr => InteriorFloorMaterial == null ? "-" : InteriorFloorMaterial.Name;
        public Material InteriorWallMaterial { get; set; }
        public string InteriorWallMaterialStr => InteriorWallMaterial == null ? "-" : InteriorWallMaterial.Name;

        public Envelope SExternalFacadeSetting { get; set; }        
        public string SExternalFacadeSettingStr => SExternalFacadeSetting.Area== 0 ? "-" : SExternalFacadeSetting.Name;
        public Envelope EExternalFacadeSetting { get; set; }
        public string EExternalFacadeSettingStr => EExternalFacadeSetting.Area == 0 ? "-" : EExternalFacadeSetting.Name;
        public Envelope NExternalFacadeSetting { get; set; }
        public string NExternalFacadeSettingStr => NExternalFacadeSetting.Area == 0 ? "-" : NExternalFacadeSetting.Name;
        public Envelope WExternalFacadeSetting { get; set; }
        public string WExternalFacadeSettingStr => WExternalFacadeSetting.Area == 0 ? "-" : WExternalFacadeSetting.Name;
        public Envelope NeExternalFacadeSetting { get; set; }
        public string NeExternalFacadeSettingStr => NeExternalFacadeSetting.Area == 0 ? "-" : NeExternalFacadeSetting.Name;
        public Envelope NwExternalFacadeSetting { get; set; }
        public string NwExternalFacadeSettingStr => NwExternalFacadeSetting.Area == 0 ? "-" : NwExternalFacadeSetting.Name;
        public Envelope SeExternalFacadeSetting { get; set; }
        public string SeExternalFacadeSettingStr => SeExternalFacadeSetting.Area == 0 ? "-" : SeExternalFacadeSetting.Name;
        public Envelope SwExternalFacadeSetting { get; set; }
        public string SwExternalFacadeSettingStr => SwExternalFacadeSetting.Area == 0 ? "-" : SwExternalFacadeSetting.Name;
        public Envelope RoofSetting { get; set; }
        public string RoofSettingStr => RoofSetting.Area == 0 ? "-" : RoofSetting.Name;
        public Envelope GroundSetting { get; set; }
        public string GroundSettingStr => GroundSetting.Area == 0 ? "-" : GroundSetting.Name;

      
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
                $"Ground Slab Setting: {GroundSettingStr} \t!!!specify the external facade defined in envelope settings, use '-' if there is not external structure" +
                Br;
            //Adjacent Wall Zone

           result += "Adjacent Wall Zone Name and Contact Area: ";
            if (AdjacentWallList.Count == 0)
            {
                result += "-";
            }
            else
            {
                for (int i = 0; i < AdjacentWallList.Count; i++)
                {
                    var adjacentWall = AdjacentWallList[i];
                    result += $"{adjacentWall.SuperBrep.Name}, {Converter.DoubleToString(adjacentWall.ContactArea)}";
                    if (i != AdjacentWallList.Count - 1)
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
                    result += $"{adjacent.SuperBrep.Name}, {Converter.DoubleToString(adjacent.ContactArea)}";
                    if (i != AdjacentCeilingList.Count - 1)
                    {
                        result += "; ";
                    }
                }
            }
            result += "\t!!!specify the name of neigboring zone and contact area" + Br;

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
                    result += $"{adjacent.SuperBrep.Name}, {Converter.DoubleToString(adjacent.ContactArea)}";
                    if (i != AdjacentFloorList.Count - 1)
                    {
                        result += "; ";
                    }
                }
            }
            result += " \t!!!specify the name of neigboring zone and contact area" + Br;

            return result;
        }

        /// <summary>
        /// 计算当前 Zone 的面积。
        /// </summary>
        /// <returns></returns>
        public double GetZoneArea()
        {
            double area = 0;
            foreach (var surface in Floor)
            {
                area += surface.Area;
            }
            return area;
        }
        /// <summary>
        /// 判断 合并 envelopeSetting
        /// </summary>
        public void MergeExternalEnvelope()
        {
            Envelope roof = new Envelope
            {
                Area = 0,
                Windows = new List<Window> { },
                Material =MaterialSetting.RoofMaterial,                
            };
            Envelope ground = new Envelope
            {
                Area = 0,
                Material = MaterialSetting.GroundMaterial,
            };
            Envelope externalFloor = new Envelope
            {
                Area = 0,
                Material = MaterialSetting.ExternalFloorMaterial,
            };
            Envelope e = new Envelope
            {
                Area = 0,
                Windows = new List<Window> { },
                Material = MaterialSetting.ExternalWallMaterial,
            };
            Envelope s = new Envelope
            {
                Area = 0,
                Windows = new List<Window> { },
                Material = MaterialSetting.ExternalWallMaterial,
            };
            Envelope w = new Envelope
            {
                Area = 0,
                Windows = new List<Window> { },
                Material = MaterialSetting.ExternalWallMaterial,
            };
            Envelope n = new Envelope
            {
                Area = 0,
                Windows = new List<Window> { },
                Material = MaterialSetting.ExternalWallMaterial,
            };
            Envelope ne = new Envelope
            {
                Area = 0,
                Windows = new List<Window> { },
                Material = MaterialSetting.ExternalWallMaterial,
            };
            Envelope nw = new Envelope
            {
                Area = 0,
                Windows = new List<Window> { },
                Material = MaterialSetting.ExternalWallMaterial,
            };
            Envelope se = new Envelope
            {
                Area = 0,
                Windows = new List<Window> { },
                Material = MaterialSetting.ExternalWallMaterial,
            };
            Envelope sw = new Envelope
            {
                Area = 0,
                Windows = new List<Window> { },
                Material = MaterialSetting.ExternalWallMaterial,
            };
            foreach (var surface in this.Roof)
            {

                if(surface.Material.MaterialType == MaterialType.Roof)
                { 
                roof.Area += surface.EnvelopeSetting.Value.GetPlanePartArea();               
                roof.Windows.AddRange(surface.EnvelopeSetting.Value.Windows);
                }
            }
            foreach (var surface in this.Floor)
            {
                if (surface.Material.MaterialType == MaterialType.Ground)
                {
                    ground.Area += surface.EnvelopeSetting.Value.GetPlanePartArea();
                    break;
                }  
            }
            foreach (var surface in this.Floor)
            {
                if (surface.Material.MaterialType == MaterialType.ExternalFloor)
                {
                    externalFloor.Area += surface.EnvelopeSetting.Value.GetPlanePartArea();
                    break;
                }
            }
            if (externalFloor.Area > 0)
            {
                roof.ExternalFloorArea = externalFloor;
            }
            RoofSetting = roof;
            GroundSetting = ground;
            foreach (var surface in this.ExternalWall)
            {
                Plane surfacePlane = surface.EnvelopeSetting.Value.GetPlane();//
                var orientation = VectorTools.GetOrientation(Plane.WorldXY, surfacePlane.Normal);
                if (orientation == Orientation.InValid || orientation == Orientation.UP || orientation == Orientation.DOWN)
                {
                    continue;
                }
                if (orientation == Orientation.E)
                {
                    e.Area += surface.EnvelopeSetting.Value.GetPlanePartArea();
                    //e.Name = surface.EnvelopeSetting.Value.Name;
                    e.Windows.AddRange(surface.EnvelopeSetting.Value.Windows);
                    continue;
                }

                if (orientation == Orientation.S)
                {
                    s.Area += surface.EnvelopeSetting.Value.GetPlanePartArea();
                    //s.Name = surface.EnvelopeSetting.Value.Name;
                    s.Windows.AddRange(surface.EnvelopeSetting.Value.Windows);
                    continue;
                }

                if (orientation == Orientation.W)
                {
                    w.Area += surface.EnvelopeSetting.Value.GetPlanePartArea();
                    //w.Name = surface.EnvelopeSetting.Value.Name;
                    w.Windows.AddRange(surface.EnvelopeSetting.Value.Windows);
                    continue;
                }

                if (orientation == Orientation.N)
                {
                    n.Area += surface.EnvelopeSetting.Value.GetPlanePartArea();
                    //n.Name = surface.EnvelopeSetting.Value.Name;
                    n.Windows.AddRange(surface.EnvelopeSetting.Value.Windows);
                    continue;
                }

                if (orientation == Orientation.SE)
                {
                    se.Area += surface.EnvelopeSetting.Value.GetPlanePartArea();
                    //se.Name = surface.EnvelopeSetting.Value.Name;
                    se.Windows.AddRange(surface.EnvelopeSetting.Value.Windows);
                    continue;
                }

                if (orientation == Orientation.NW)
                {
                    nw.Area += surface.EnvelopeSetting.Value.GetPlanePartArea();
                    //nw.Name = surface.EnvelopeSetting.Value.Name;
                    nw.Windows.AddRange(surface.EnvelopeSetting.Value.Windows);
                    continue;
                }

                if (orientation == Orientation.SW)
                {
                    sw.Area += surface.EnvelopeSetting.Value.GetPlanePartArea();
                    //sw.Name = surface.EnvelopeSetting.Value.Name;
                    sw.Windows.AddRange(surface.EnvelopeSetting.Value.Windows);
                    continue;
                }

                if (orientation == Orientation.NE)
                {
                    ne.Area += surface.EnvelopeSetting.Value.GetPlanePartArea();
                    //ne.Name = surface.EnvelopeSetting.Value.Name;
                    ne.Windows.AddRange(surface.EnvelopeSetting.Value.Windows);
                }
            }
            SExternalFacadeSetting = s;
            WExternalFacadeSetting = w;
            EExternalFacadeSetting = e;
            NExternalFacadeSetting = n;
            SeExternalFacadeSetting = se;
            SwExternalFacadeSetting = sw;
            NeExternalFacadeSetting = ne;
            NwExternalFacadeSetting = nw;
            List<Envelope> Envelopes = new List<Envelope> { roof, ground, e, s, w, n, ne, nw, se, sw };//加入各种Envelop
            foreach (var surface in this.Wall)
            {
                if (surface.Material.MaterialType == MaterialType.InternalWall)
                {
                    Envelopes.Add(new Envelope(surface.EnvelopeSetting.Value));                    
                }
            }
            foreach (var surface in this.Ceiling)
            {
                if (surface.Material.MaterialType == MaterialType.InternalFloor)
                {
                    Envelopes.Add(new Envelope(surface.EnvelopeSetting.Value));
                }
            }
            foreach (var surface in this.Floor)
            {
                if (surface.Material.MaterialType == MaterialType.InternalFloor|| surface.Material.MaterialType == MaterialType.ExternalFloor)
                {
                    Envelopes.Add(new Envelope(surface.EnvelopeSetting.Value));
                }
            }
            this.Envelop = Envelopes;
        }
    }
}


