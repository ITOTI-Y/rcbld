using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules;
using System;
using System.Collections.Generic;

namespace RCBldGH.Components.Envelope
{
    public class SuperSurfaceParam : GH_Param<GH_Goo<SuperSurface>>, IGH_PreviewObject
    {
        public SuperSurfaceParam() : base(new GH_InstanceDescription("SuperSurface", "SuperSurface", "SuperSurface", "RCBldGH", "Params"))
        {

        }

        public override Guid ComponentGuid => new Guid("{170eb30a-1f27-454a-b519-f9138c9002ad}");
        public override GH_Exposure Exposure => GH_Exposure.hidden;
        public bool Hidden { get; set; }

        public bool IsPreviewCapable => true;

        protected override GH_Goo<SuperSurface> InstantiateT()
        {
            return new SuperSurfaceGoo();
        }

        private BoundingBox m_clippingBox;
        public BoundingBox ClippingBox => GetClippingBox();

        public BoundingBox GetClippingBox()
        {
            BoundingBox clippingBox;
            if (this.m_clippingBox.IsValid)
            {
                clippingBox = this.m_clippingBox;
            }
            else
            {
                this.m_clippingBox = BoundingBox.Empty;
                if (this.m_data.IsEmpty)
                {
                    clippingBox = this.m_clippingBox;
                }
                else
                {
                    try
                    {
                        foreach (List<GH_Goo<SuperSurface>> list in this.m_data.Branches)
                        {
                            try
                            {
                                foreach (GH_Goo<SuperSurface> t in list)
                                {
                                    if (t != null)
                                    {
                                        var ghSurface = t.Value.GH_Surface;

                                        try
                                        {
                                            if (ghSurface is IGH_PreviewData ighPreviewData)
                                            {
                                                BoundingBox clippingBox2 = ighPreviewData.ClippingBox;
                                                if (clippingBox2.IsValid)
                                                {
                                                    this.m_clippingBox.Union(clippingBox2);
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

                    clippingBox = this.m_clippingBox;
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
                    args2 = new GH_PreviewMeshArgs(args.Viewport, args.Display, args.ShadeMaterial_Selected,
                        args.MeshingParameters);
                }
                else
                {
                    args2 = new GH_PreviewMeshArgs(args.Viewport, args.Display, args.ShadeMaterial,
                        args.MeshingParameters);
                }

                try
                {
                    foreach (List<GH_Goo<SuperSurface>> list in this.m_data.Branches)
                    {
                        try
                        {
                            foreach (GH_Goo<SuperSurface> t in list)
                            {
                                if (t != null)
                                {
                                    var ghSurface = (t.Value).GH_Surface;

                                    try
                                    {
                                        if (ghSurface is IGH_PreviewData ighPreviewData)
                                        {
                                            ighPreviewData.DrawViewportMeshes(args2);
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
            }
        }

        public void DrawViewportWires(IGH_PreviewArgs args)
        {
            if (!this.m_data.IsEmpty && !this.Locked)
            {
                GH_PreviewWireArgs args2;
                if (base.Attributes.GetTopLevel.Selected)
                {
                    args2 = new GH_PreviewWireArgs(args.Viewport, args.Display, args.WireColour_Selected,
                        args.DefaultCurveThickness);
                }
                else
                {
                    args2 = new GH_PreviewWireArgs(args.Viewport, args.Display, args.WireColour,
                        args.DefaultCurveThickness);
                }

                try
                {
                    foreach (List<GH_Goo<SuperSurface>> list in this.m_data.Branches)
                    {
                        try
                        {
                            foreach (GH_Goo<SuperSurface> t in list)
                            {
                                if (t != null)
                                {
                                    var ghSurface = (t.Value).GH_Surface;

                                    try
                                    {
                                        if (ghSurface is IGH_PreviewData ighPreviewData)
                                        {
                                            ighPreviewData.DrawViewportWires(args2);
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
            }
        }
    }
}