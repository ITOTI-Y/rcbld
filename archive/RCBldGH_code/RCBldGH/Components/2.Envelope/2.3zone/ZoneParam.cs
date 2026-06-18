using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class ZoneParam: GH_Param<GH_Goo<Zone>>, IGH_PreviewObject
    {
        public ZoneParam(): base(new GH_InstanceDescription("Zone", "Zone", "Zone", "RCBldGH", "Params"))
        {
            
        }

        public bool Hidden { get; set; }

        public bool IsPreviewCapable => true;

        public BoundingBox ClippingBox => GetClippingBox();

        public override Guid ComponentGuid => new Guid("{1CA1BF7E-1904-4077-92A6-DEF92D12737C}");
        public override GH_Exposure Exposure => GH_Exposure.hidden;
        private BoundingBox _clippingBox;

        protected override GH_Goo<Zone> InstantiateT()
        {
            return new ZoneGoo();
        }

        public BoundingBox GetClippingBox()
        {
            BoundingBox clippingBox;
            if (this._clippingBox.IsValid)
            {
                clippingBox = this._clippingBox;
            }
            else
            {
                this._clippingBox = BoundingBox.Empty;
                if (this.m_data.IsEmpty)
                {
                    clippingBox = this._clippingBox;
                }
                else
                {
                    try
                    {
                        foreach (List<GH_Goo<Zone>> list in this.m_data.Branches)
                        {
                            try
                            {
                                foreach (GH_Goo<Zone> t in list)
                                {
                                    if (t != null)
                                    {
                                        var allSurfaces = new List<GH_Surface>();
                                        foreach (var surface in t.Value.EnvelopSurfaces)
                                        {
                                            allSurfaces.AddRange(surface.GetAllSurfaces());
                                        }

                                        try
                                        {
                                            foreach (var ghSurface in allSurfaces)
                                            {
                                                if (ghSurface is IGH_PreviewData ighPreviewData)
                                                {
                                                    BoundingBox clippingBox2 = ighPreviewData.ClippingBox;
                                                    if (clippingBox2.IsValid)
                                                    {
                                                        this._clippingBox.Union(clippingBox2);
                                                    }
                                                }
                                            }
                                        }
                                        finally
                                        {
                                        }
                                    }
                                }
                            }
                            finally
                            {
                            }
                        }
                    }
                    finally
                    {
                    }

                    clippingBox = this._clippingBox;
                }
            }

            return clippingBox;
        }
        public void DrawViewportMeshes(IGH_PreviewArgs args)
        {
            if (!this.m_data.IsEmpty && !this.Locked)
            {
                GH_PreviewMeshArgs args2;
                if (base.Attributes.GetTopLevel.Selected)
                {
                    args2 = new GH_PreviewMeshArgs(args.Viewport, args.Display, args.ShadeMaterial_Selected, args.MeshingParameters);
                }
                else
                {
                    args2 = new GH_PreviewMeshArgs(args.Viewport, args.Display, args.ShadeMaterial, args.MeshingParameters);
                }
                try
                {
                    foreach (List<GH_Goo<Zone>> list in this.m_data.Branches)
                    {
                        try
                        {
                            foreach (GH_Goo<Zone> t in list)
                            {
                                if (t != null)
                                {
                                    var allSurfaces = new List<GH_Surface>();
                                    foreach (var surface in t.Value.EnvelopSurfaces)
                                    {
                                        allSurfaces.AddRange(surface.GetAllSurfaces());
                                    }

                                    try
                                    {
                                        foreach (var ghSurface in allSurfaces)
                                        {
                                            IGH_PreviewData ighPreviewData = ghSurface as IGH_PreviewData;
                                            if (ighPreviewData != null)
                                            {
                                                ighPreviewData.DrawViewportMeshes(args2);
                                            }
                                        }
                                    }
                                    finally { }
                                }
                            }
                        }
                        finally
                        {
                        }
                    }
                }
                finally
                {
                }
            }
        }

        public void DrawViewportWires(IGH_PreviewArgs args)
        {
            if (!this.m_data.IsEmpty && !this.Locked)
            {
                GH_PreviewWireArgs args2;
                if (base.Attributes.GetTopLevel.Selected)
                {
                    args2 = new GH_PreviewWireArgs(args.Viewport, args.Display, args.WireColour_Selected, args.DefaultCurveThickness);
                }
                else
                {
                    args2 = new GH_PreviewWireArgs(args.Viewport, args.Display, args.WireColour, args.DefaultCurveThickness);
                }
                try
                {
                    foreach (List<GH_Goo<Zone>> list in this.m_data.Branches)
                    {
                        try
                        {
                            foreach (GH_Goo<Zone> t in list)
                            {
                                if (t != null)
                                {
                                    var allSurfaces = new List<GH_Surface>();
                                    foreach (var surface in t.Value.EnvelopSurfaces)
                                    {
                                        allSurfaces.AddRange(surface.GetAllSurfaces());
                                    }

                                    try
                                    {
                                        foreach (var ghSurface in allSurfaces)
                                        {
                                            IGH_PreviewData ighPreviewData = ghSurface as IGH_PreviewData;
                                            if (ighPreviewData != null)
                                            {
                                                ighPreviewData.DrawViewportWires(args2);
                                            }
                                        }
                                    }
                                    finally { }
                                }
                            }
                        }
                        finally
                        {
                        }
                    }
                }
                finally
                {
                }
            }
        }
    }
}