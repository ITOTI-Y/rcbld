using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Rhino.Geometry.Collections;
using Rhino.DocObjects;
using System.CodeDom;

using RCBldGH.Utils;
using Grasshopper.Kernel.Geometry.Delaunay;
using RCBldGH.Components.Envelope;
using System.Windows.Forms;
using RCBldGH.Modules;
using Rhino.Render.ChangeQueue;
using Rhino.Display;
using RCBldGH.Components.Material;

namespace RCBldGH.Modules
{
    public class SuperSurface
    {
        public bool IsInternal { get; set; } = false;
        ///
        public SuperSurface()
        {
            Id = Guid.NewGuid().ToString();
            RelativePosition = -1; //给RelativePosition属性赋值一个初始值，表示未知的位置
            IsSlab = false;
            Name = Id;
        }
        public string Id { get; }
        public override string ToString()
        {
            if (Material == null) { return $"SuperSurface, No Material"; }
            else { return $"SuperSurface: {Material.MaterialType}"; }
        }
        public GH_Surface GH_Surface { get; set; }
        public Surface Surface
        {
            get
            {
                BrepFaceList faces = this.GH_Surface.Value.Faces;
                Surface srf = (Surface)faces[0];
                return srf;
            }
        }
        public Point3d Centroid
        {
            get
            {
                GH_Surface gH_Surface = this.GH_Surface;
                AreaMassProperties amp = AreaMassProperties.Compute(gH_Surface.Value);
                Point3d centroid = amp.Centroid;
                return centroid;
            }
        }
        public Vector3d Normal
        {
            get
            {
                GH_Surface gH_Surface = this.GH_Surface;
                BrepFace face = gH_Surface.Value.Faces[0];
                Vector3d normal = face.NormalAt(0, 0);
                return normal;
            }
        }
        public double Area
        {
            get
            {
                GH_Surface gH_Surface = this.GH_Surface;
                AreaMassProperties amp = AreaMassProperties.Compute(gH_Surface.Value);
                double area = amp.Area;
                return area;
            }
        }
        public double Height { get { return this.Centroid.Z; } }
        public string Name { get; set; }
        public int RelativePosition { get; set; }//top=0; vertical face=1; floor=2; 

        public Material Material { get; set; }
        public List<Window> Window { get; set; }
        public bool IsSlab { get; set; }

        public SuperSurface(GH_Surface gH_Surface)//构造函数
        {
            this.GH_Surface = gH_Surface;            
            this.Window = new List<Window>();
            Id = Guid.NewGuid().ToString();
            RelativePosition = -1; //给RelativePosition属性赋值一个初始值，表示未知的位置
            IsSlab = false;
            Name = Id;
        }
        //public EnvelopeSettingGoo EnvelopeSetting
        //{
        //    get
        //    {
        //        EnvelopeSetting es;
        //        if (IsSlab)
        //        {
        //            es = new EnvelopeSetting()
        //            {
        //                EnvelopeType = EnvelopeType.Underground,
        //            };
        //            Slab slab = new Slab
        //            {
        //                Material = Material
        //            };
        //            // add the Opaque object to the EnvelopeSetting object
        //            es.Slabs = new List<Slab>() { slab };
        //            //es.Id = Guid.NewGuid().ToString();
        //        }
        //        else
        //        {
        //            es = new EnvelopeSetting()
        //            {
        //                EnvelopeType = EnvelopeType.Opaque,
        //            };
        //            Opaque opaque = new Opaque
        //            {
        //                Material = Material
        //            };
        //            if (this.Window.Count == 0)
        //            {
        //                opaque.GeometrySurface = this.GH_Surface;
        //            }

        //            if (this.Window.Count > 0) //check if the Opaques list is not null
        //            {
        //                opaque.GeometrySurface = SplitOpaqueByWindow(this.Window);
        //            }
        //            List<Window> windows = this.Window;
        //            // add the Opaque object to the EnvelopeSetting object
        //            es.Opaques = new List<Opaque>() { opaque };
        //            es.Windows = windows;
        //            //es.Id =Guid.NewGuid().ToString();
        //        }
        //        // return the EnvelopeSetting object's value
        //        var esGoo = new EnvelopeSettingGoo { Value = es };
        //        return esGoo;
        //    }
        //}


        public EnvelopeSettingGoo EnvelopeSetting
        {
            get
            {
                EnvelopeSetting es = new EnvelopeSetting()
                {
                    EnvelopeType = EnvelopeType.Opaque, 
                    Name = Name,
                };
                Opaque opaque = new Opaque
                {
                    Material = Material
                };
                if (this.Window.Count == 0)
                {
                    opaque.GeometrySurface = this.GH_Surface;
                }

                if (this.Window.Count > 0) //check if the Opaques list is not null
                {
                    opaque.GeometrySurface = SplitOpaqueByWindow(this.Window);
                }
                List<Window> windows = this.Window;
                // add the Opaque object to the EnvelopeSetting object
                es.Opaques = new List<Opaque>() { opaque };
                es.Windows = windows;
                // return the EnvelopeSetting object's value
                var esGoo = new EnvelopeSettingGoo { Value = es };
                return esGoo;
            }
        }

        //自定义的方法，用Window列表去剪切Opaque
        private GH_Surface SplitOpaqueByWindow(List<Window> windowList)
        {
            Brep opaqueGH_Surface = this.GH_Surface.Value;
            foreach (Window w in windowList) //遍历window列表
            {
                Brep windowBrep = w.GeometrySurface.Value; //获取Window对象的GeometrySurface属性的值的第一个面，也就是一个BrepFace对象
                Brep[] splittedOpaqueFaces = Brep.CreateBooleanDifference(opaqueGH_Surface, windowBrep, Rhino.RhinoDoc.ActiveDoc.ModelAbsoluteTolerance);
                opaqueGH_Surface = splittedOpaqueFaces[0];
            }
            GH_Surface gH = new GH_Surface(opaqueGH_Surface);
            return gH;
        }        
    }
}


