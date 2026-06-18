using System;
using System.Collections.Generic;
using System.Linq;
using GH_IO;
using Grasshopper.Kernel.Types;
using Rhino;
using Rhino.Geometry;
using RCBldGH.Domains;
using RCBldGH.Utils;
using RCBldGH.Components.Envelope;

namespace RCBldGH.Modules
{
    /// <summary>
    /// Opaque 类型不包含 SlabArea。
    /// Underground 只包含 OpaqueArea 和 SlabArea.
    /// </summary>
    public enum EnvelopeType
    {
        Opaque = 1,
        Underground = 2,
    }

    public enum SurfaceType
    {
        Plane,
        Facade,
        Slope
    }

    public enum WindowShadingType
    {
        WhiteBlinds = 1,
        WhiteCurtains = 2,
        ColoredTextures = 3,
        AluminumCoatedTexture = 4
    }

    public enum WindowShadingWhere
    {
        Inside = 1,
        Outside = 2,
    }

    public enum WindowShadingControl
    {
        Manual = 1,
        Auto = 2,
        Others = 3,
    }

    /// <summary>
    /// 合并后的envelope，只包含ToCen信息
    /// </summary>
    public class Envelope
    {
        public Envelope()
        {
            Id = Guid.NewGuid().ToString();
            Name = Id;
        }
        public Envelope(EnvelopeSetting envelopeSetting)
        {
            Id = Guid.NewGuid().ToString();
            Name = Id;
            Area = envelopeSetting.GetAreaNoWindow();
            Material = envelopeSetting.GetMainMaterial();
            Windows = envelopeSetting.Windows;
        }
        public string Id { get; }
        private const string Br = "\r\n";
        public string Name { get; set; }
        public Material Material { get; set; }
        public double Area { get; set;}
        public List<Window> Windows { get; set; }
        public Envelope ExternalFloorArea { get; set; }
        
        public string ToCen()
        {
            if (this.Area == 0 && this.ExternalFloorArea == null)
            {
                return null;
            }
            else
            {
                string result = $"Surface Name: {Name} \t!!! Specify the envelope setting name" + Br;
                if (this.Area > 0)
                {
                    result += $"{Material.Name} Area: {Converter.DoubleToString(Converter.ToMeters(Area))} \t!!! unit: m2" + Br;
                    Dictionary<Material, double> windowMaterialAreaDict = new Dictionary<Material, double>();
                    Dictionary<Material, Window> windowMaterialWindowObjDict = new Dictionary<Material, Window>();
                    if (Windows != null)
                    {
                        foreach (var window in Windows)
                        {
                            if (!windowMaterialAreaDict.Keys.Contains(window.Material))
                            {
                                windowMaterialAreaDict.Add(window.Material, window.Area);
                                windowMaterialWindowObjDict.Add(window.Material, window);
                            }
                            else
                            {
                                windowMaterialAreaDict[window.Material] = window.Area + windowMaterialAreaDict[window.Material];
                            }
                        }
                    }
                    foreach (KeyValuePair<Material, double> item in windowMaterialAreaDict)
                    {
                        result += $"{item.Key.Name} Area: {Converter.DoubleToString(Converter.ToMeters(item.Value))} \t!!! unit: m2" + Br;

                        result +=
                            $"{item.Key.Name} Overhang Angle: {windowMaterialWindowObjDict[item.Key].WindowOverhangAngleStr} \t!!! unit: degree, can choose from 30, 45, 60, caution: there is no overhang for roof, thus it should be left with '-'" +
                            Br;
                        result +=
                            $"{item.Key.Name} Fin Angle: {windowMaterialWindowObjDict[item.Key].WindowFinAngleStr} \t!!! unit: degree, can choose from 30, 45, 60" + Br;
                        result +=
                            $"{item.Key.Name} Horizon Angle: {windowMaterialWindowObjDict[item.Key].WindowHorizonAngleStr} \t!!! unit: degree, can choose from 10, 20, 30, 40, 50, 60, 70, 80" +
                            Br;
                        result +=
                            $"{item.Key.Name} Shading Type: {windowMaterialWindowObjDict[item.Key].WindowShadingTypeStr} \t!!! 1. white blinds, 2. white curtains, 3. colored textures, 4. aluminum-coated texture" +
                            Br;
                        result +=
                            $"{item.Key.Name} Shading Where: {windowMaterialWindowObjDict[item.Key].WindowShadingWhereStr} \t!!! 1. inside: internal shading, 2. outside: external shading" +
                            Br;
                        result +=
                            $"{item.Key.Name} Shading Control: {windowMaterialWindowObjDict[item.Key].WindowShadingControlStr} \t!!! 1. manually controlled, 2. automated control, 3. all others" +
                            Br;
                    }
                }
                if (this.ExternalFloorArea != null)
                {
                    result += $"{ExternalFloorArea.Material.Name} Area: {Converter.DoubleToString(Converter.ToMeters(ExternalFloorArea.Area))} \t!!! unit: m2" + Br;
                    result += $"Window Area: {Converter.DoubleToString(Converter.ToMeters(ExternalFloorArea.Area))}    !!! unit: m2\r\nWindow Overhang Angle: -  !!! unit: degree, can choose from 30, 45, 60, caution: there is no overhang for roof, thus it should be left with '-'\r\nWindow Fin Angle: -   !!! unit: degree, can choose from 30, 45, 60\r\nWindow Horizon Angle: -   !!! unit: degree, can choose from 10, 20, 30, 40, 50, 60, 70, 80\r\nWindow Shading Type: 4    !!! 1. white blinds, 2. white curtains, 3. colored textures, 4. aluminum-coated texture\r\nWindow Shading Where: 2   !!! 1. inside: internal shading, 2. outside: external shading\r\nWindow Shading Control: 2     !!! 1. manually controlled, 2. automated control, 3. all others";
                }
                return result;
            }
        }
        public List<Material> GetAllMaterials()
        {
            var materials = new List<Material>
            {
                this.Material
            };    
            if (Windows != null)
            {
                foreach (var window in Windows)
                {
                    if (window.Material != null && !materials.Contains(window.Material))
                    {
                        materials.Add(window.Material);
                    }
                }
            }
            return materials;
        }
        public override string ToString()
        {
            if (Material == null) { return $"SuperSurface, No Material"; }
            else { return $"SuperSurface: {Material.MaterialType}"; }
        }
    }
    //###############################################

    public class EnvelopeSetting
    {
        public EnvelopeSetting()
        {
            Id = Guid.NewGuid().ToString();
        }
        public string Id { get; }
        private const string Br = "\r\n";

        public string Name { get; set; } 

        public List<Opaque> Opaques { get; set; }
        public List<Window> Windows { get; set; }
        public List<Slab> Slabs { get; set; }

        public EnvelopeType EnvelopeType { get; set; }        
        public double WWR
        {
            get
            {
                // 调用 GetAreaFraction 方法获取 WWR 的值
                return GetAreaFraction();
            }            
        }
        
        public string ToCen()
        {

            string result = $"Surface Name: {Name} \t!!! Specify the envelope setting name" + Br;

            Dictionary<Material, double> opaqueMaterialAreaDict = new Dictionary<Material, double>();
            if (this.Opaques != null)
            {
                foreach (var opaque in Opaques)
                {
                    if (!opaqueMaterialAreaDict.Keys.Contains(opaque.Material))
                    {
                        opaqueMaterialAreaDict.Add(opaque.Material, opaque.Area);
                    }
                    else
                    {
                        opaqueMaterialAreaDict[opaque.Material] = opaque.Area + opaqueMaterialAreaDict[opaque.Material];
                    }
                }
            }

            if (this.Slabs != null)
            {
                foreach (var slab in Slabs)
                {
                    if (!opaqueMaterialAreaDict.Keys.Contains(slab.Material))
                    {
                        opaqueMaterialAreaDict.Add(slab.Material, slab.Area);
                    }
                    else
                    {
                        opaqueMaterialAreaDict[slab.Material] = slab.Area + opaqueMaterialAreaDict[slab.Material];
                    }
                }
            }
            foreach (KeyValuePair<Material, double> item in opaqueMaterialAreaDict)
            {
                result += $"{item.Key.Name} Area: {Converter.DoubleToString(Converter.ToMeters(item.Value))} \t!!! unit: m2" + Br;
            }

            Dictionary<Material, double> windowMaterialAreaDict = new Dictionary<Material, double>();
            Dictionary<Material, Window> windowMaterialWindowObjDict = new Dictionary<Material, Window>();

            if (Windows != null)
            {
                foreach (var window in Windows)
                {
                    if (!windowMaterialAreaDict.Keys.Contains(window.Material))
                    {
                        windowMaterialAreaDict.Add(window.Material, window.Area);
                        windowMaterialWindowObjDict.Add(window.Material, window);
                    }
                    else
                    {
                        windowMaterialAreaDict[window.Material] = window.Area + windowMaterialAreaDict[window.Material];
                    }
                }
            }

            foreach (KeyValuePair<Material, double> item in windowMaterialAreaDict)
            {
                result += $"{item.Key.Name} Area: {Converter.DoubleToString(Converter.ToMeters(item.Value))} \t!!! unit: m2" + Br;

                result +=
                    $"{item.Key.Name} Overhang Angle: {windowMaterialWindowObjDict[item.Key].WindowOverhangAngleStr} \t!!! unit: degree, can choose from 30, 45, 60, caution: there is no overhang for roof, thus it should be left with '-'" +
                    Br;
                result +=
                    $"{item.Key.Name} Fin Angle: {windowMaterialWindowObjDict[item.Key].WindowFinAngleStr} \t!!! unit: degree, can choose from 30, 45, 60" + Br;
                result +=
                    $"{item.Key.Name} Horizon Angle: {windowMaterialWindowObjDict[item.Key].WindowHorizonAngleStr} \t!!! unit: degree, can choose from 10, 20, 30, 40, 50, 60, 70, 80" +
                    Br;
                result +=
                    $"{item.Key.Name} Shading Type: {windowMaterialWindowObjDict[item.Key].WindowShadingTypeStr} \t!!! 1. white blinds, 2. white curtains, 3. colored textures, 4. aluminum-coated texture" +
                    Br;
                result +=
                    $"{item.Key.Name} Shading Where: {windowMaterialWindowObjDict[item.Key].WindowShadingWhereStr} \t!!! 1. inside: internal shading, 2. outside: external shading" +
                    Br;
                result +=
                    $"{item.Key.Name} Shading Control: {windowMaterialWindowObjDict[item.Key].WindowShadingControlStr} \t!!! 1. manually controlled, 2. automated control, 3. all others" +
                    Br;
            }
            return result;
        }

        public override string ToString()
        {
            if (EnvelopeType == EnvelopeType.Underground)
            {
                return $"Underground Surface: {Name}";
            }
            return $"Envelop Surface: {Name}";
        }

        /// <summary>
        /// 以第一个 Opaque 的朝向作为整个 Envelope Surface 的朝向。
        /// </summary>
        public Orientation GetOrientation(Plane plane)
        {
            try
            {
                Plane plane2 = GetPlane();
                if (plane2 != Plane.Unset)
                {
                    return VectorTools.GetOrientation(plane, plane2.Normal);
                }

                return Orientation.InValid;
            }
            catch (Exception)
            {
                return Orientation.InValid;
            }
        }

        /// <summary>
        /// 获取当前 EnvelopSurface 的基准平面。
        /// 以  Opaque 1 所在的平面作为基准平面。Opaque 1 为空则使用 Opaque 2 所在的平面。
        /// </summary>
        public Plane GetPlane()
        {
            try
            {
                var opaqueFace = Opaques[0].GeometrySurface.Face;
                bool planar = opaqueFace.TryGetPlane(out var plane, RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                if (planar)
                {
                    return plane;
                }

                return Plane.Unset;
            }
            catch (Exception)
            {
                return Plane.Unset;
            }
        }

        /// <summary>
        /// 获取当前 EnvelopeSurface 的主体材质。
        /// 如果是 Underground 类型，Slab1 优先级大于 Slab2 。
        /// 其他类型 Opaque1>Opaque1>Window1>Window2。
        /// </summary>
        /// <returns></returns>
        public Material GetMainMaterial()
        {
            if (EnvelopeType == EnvelopeType.Underground && Slabs != null && Slabs.Count > 0)
            {
                return Slabs[0].Material;
            }

            if (Opaques != null && Opaques.Count > 0)
            {
                return Opaques[0].Material;
            }

            if (Windows != null && Windows.Count > 0)
            {
                return Windows[0].Material;
            }

            return null;
        }

        public List<Material> GetAllMaterials()
        {
            var materials = new List<Material>();
            if (Opaques != null)
            {
                foreach (Opaque opaque in Opaques)
                {
                    if (opaque.Material != null && !materials.Contains(opaque.Material))
                    {
                        materials.Add(opaque.Material);
                    }
                }
            }

            if (Slabs != null)
            {
                foreach (Slab slab in Slabs)
                {
                    if (slab.Material != null && !materials.Contains(slab.Material))
                    {
                        materials.Add(slab.Material);
                    }
                }
            }

            if (Windows != null)
            {
                foreach (var window in Windows)
                {
                    if (window.Material != null && !materials.Contains(window.Material))
                    {
                        materials.Add(window.Material);
                    }
                }
            }

            return materials;
        }

        public double GetPlanePartArea()
        {
            double area = 0;
            if (EnvelopeType == EnvelopeType.Underground)
            {
                if (Slabs != null)
                {
                    foreach (var slab in Slabs)
                    {
                        var slabArea = slab.Area;
                        if (slabArea > 0)
                        {
                            area += slabArea;
                        }
                    }
                }
                if (Opaques != null)
                {
                    foreach (var opaque in Opaques)
                    {
                        var opaqueArea = opaque.Area;
                        if (opaqueArea > 0)
                        {
                            area += opaqueArea;
                        }
                    }
                }
                return area;
            }

            if (Opaques != null)
            {
                foreach (var opaque in Opaques)
                {
                    var opaqueArea = opaque.Area;
                    if (opaqueArea > 0)
                    {
                        area += opaqueArea;
                    }
                }
            }

            if (Windows != null)
            {
                foreach (var window in Windows)
                {
                    var windowArea = window.Area;
                    if (windowArea > 0)
                    {
                        area += windowArea;
                    }
                }
            }

            return area;
        }
        public double GetAreaNoWindow()
        {
            double area = 0;
            if (EnvelopeType == EnvelopeType.Underground)
            {
                if (Slabs != null)
                {
                    foreach (var slab in Slabs)
                    {
                        var slabArea = slab.Area;
                        if (slabArea > 0)
                        {
                            area += slabArea;
                        }
                    }
                }
                if (Opaques != null)
                {
                    foreach (var opaque in Opaques)
                    {
                        var opaqueArea = opaque.Area;
                        if (opaqueArea > 0)
                        {
                            area += opaqueArea;
                        }
                    }
                }
                return area;
            }

            if (Opaques != null)
            {
                foreach (var opaque in Opaques)
                {
                    var opaqueArea = opaque.Area;
                    if (opaqueArea > 0)
                    {
                        area += opaqueArea;
                    }
                }
            }
            return area;
        }

        public double GetAreaFraction()
        {
            double area = 0;
            double windowAreaTotal = 0;
            if (EnvelopeType == EnvelopeType.Underground)
            {
                if (Slabs != null)
                {
                    foreach (var slab in Slabs)
                    {
                        var slabArea = slab.Area;
                        if (slabArea > 0)
                        {
                            area += slabArea;
                        }
                    }
                }                
            }

            if (Opaques != null)
            {
                foreach (var opaque in Opaques)
                {
                    var opaqueArea = opaque.Area;
                    if (opaqueArea > 0)
                    {
                        area += opaqueArea;
                    }
                }
            }
            if (Windows != null)
            {
                foreach (var window in Windows)
                {
                    var windowArea = window.Area;
                    if (windowArea > 0)
                    {
                        area += windowArea;
                        windowAreaTotal += windowArea;
                    }
                }
            }
            
            return windowAreaTotal/area;
        }

        public List<GH_Surface> GetAllSurfaces()
        {
            List<GH_Surface> surfaces = new List<GH_Surface>();
            if (Opaques != null)
            {
                foreach (var item in Opaques)
                {
                    surfaces.Add(item.GeometrySurface);
                }
            }

            if (Windows != null)
            {
                foreach (var item in Windows)
                {
                    surfaces.Add(item.GeometrySurface);
                }
            }

            if (Slabs != null)
            {
                foreach (var item in Slabs)
                {
                    surfaces.Add(item.GeometrySurface);
                }
            }

            return surfaces;
        }
    }
}