using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules;

namespace RCBldGH.Components.Envelope
{
    public class WindowParam : GH_Param<GH_Goo<Window>>, IGH_PreviewObject
    {
        public WindowParam() : base(new GH_InstanceDescription("Window", "Window", "Window", "RCBldGH", "Params"))
        {

        }

        public override Guid ComponentGuid => new Guid("{FCF1B7C8-2624-4B67-94A1-64F0EC7393DE}");

        public override GH_Exposure Exposure => GH_Exposure.hidden;
        public bool Hidden { get; set; }

        public bool IsPreviewCapable => true;

        protected override GH_Goo<Window> InstantiateT()
        {
            return new WindowGoo();
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
                        foreach (List<GH_Goo<Window>> list in this.m_data.Branches)
                        {
                            try
                            {
                                foreach (GH_Goo<Window> t in list)
                                {
                                    if (t != null)
                                    {
                                        var ghSurface = t.Value.GeometrySurface;

                                        try
                                        {
                                            IGH_PreviewData ighPreviewData = ghSurface as IGH_PreviewData;
                                            if (ighPreviewData != null)
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
                    foreach (List<GH_Goo<Window>> list in this.m_data.Branches)
                    {
                        try
                        {
                            foreach (GH_Goo<Window> t in list)
                            {
                                if (t != null)
                                {
                                    var ghSurface = (t.Value).GeometrySurface;

                                    try
                                    {

                                        IGH_PreviewData ighPreviewData = ghSurface as IGH_PreviewData;
                                        if (ighPreviewData != null)
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
                    foreach (List<GH_Goo<Window>> list in this.m_data.Branches)
                    {
                        try
                        {
                            foreach (GH_Goo<Window> t in list)
                            {
                                if (t != null)
                                {
                                    var ghSurface = (t.Value).GeometrySurface;

                                    try
                                    {

                                        IGH_PreviewData ighPreviewData = ghSurface as IGH_PreviewData;
                                        if (ighPreviewData != null)
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