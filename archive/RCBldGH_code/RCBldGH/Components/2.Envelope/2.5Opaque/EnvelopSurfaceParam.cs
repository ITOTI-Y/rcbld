using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using Rhino.Geometry;
using RCBldGH.Modules;
using System.Windows.Forms;
using Rhino;
using System.Linq;
using Rhino.DocObjects;
using GH_IO.Serialization;

namespace RCBldGH.Components.Envelope
{
    public class EnvelopSurfaceParam : GH_Param<GH_Goo<EnvelopeSetting>>, IGH_PreviewObject, IGH_BakeAwareObject
    {
        public EnvelopSurfaceParam() : base(new GH_InstanceDescription
            ("Envelop Surface", "EnvSrf", "Envelop Surface", "RCBldGH", "Params"))
        {
        }   
        public bool Hidden { get; set; }
        public bool IsPreviewCapable => true;
        public BoundingBox ClippingBox => GetClippingBox();
        public override Guid ComponentGuid => new Guid("{D842F734-1A2C-4842-AFA7-B0E71D1AEAB0}");

        public bool IsBakeCapable => true;

        private BoundingBox m_clippingBox;
        protected override GH_Goo<EnvelopeSetting> InstantiateT()
        {
            return new EnvelopeSettingGoo();        }

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
                        foreach (List<GH_Goo<EnvelopeSetting>> list in this.m_data.Branches)
                        {
                            try
                            {
                                foreach (GH_Goo<EnvelopeSetting> t in list)
                                {
                                    if (t != null)
                                    {
                                        var surface = t.Value.GetAllSurfaces();

                                        try
                                        {
                                            foreach (var ghSurface in surface)
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
                    args2 = new GH_PreviewMeshArgs(args.Viewport, args.Display, args.ShadeMaterial_Selected, args.MeshingParameters);
                }
                else
                {
                    args2 = new GH_PreviewMeshArgs(args.Viewport, args.Display, args.ShadeMaterial, args.MeshingParameters);
                }
                try
                {
                    foreach (List<GH_Goo<EnvelopeSetting>> list in this.m_data.Branches)
                    {
                        try
                        {
                            foreach (GH_Goo<EnvelopeSetting> t in list)
                            {
                                if (t != null)
                                {
                                    var surface = (t.Value).GetAllSurfaces();

                                    try
                                    {
                                        foreach (var ghSurface in surface)
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
                    foreach (List<GH_Goo<EnvelopeSetting>> list in this.m_data.Branches)
                    {
                        try
                        {
                            foreach (GH_Goo<EnvelopeSetting> t in list)
                            {
                                if (t != null)
                                {
                                    var surface = (t.Value).GetAllSurfaces();

                                    try
                                    {
                                        foreach (var ghSurface in surface)
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


        public void BakeGeometry(RhinoDoc doc, List<Guid> obj_ids)
        {
            foreach (GH_Goo<EnvelopeSetting> goo in m_data)
            {
                try
                {
                    foreach (List<GH_Goo<EnvelopeSetting>> list in this.m_data.Branches)
                    {
                        try
                        {
                            foreach (GH_Goo<EnvelopeSetting> t in list)
                            {
                                if (t != null)
                                {
                                    var surface = (t.Value).GetAllSurfaces();

                                    try
                                    {
                                        foreach (var ghSurface in surface)
                                        {                                            
                                            Guid id = doc.Objects.Add(ghSurface.Value);
                                            obj_ids.Add(id);
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

        public  void BakeGeometry(RhinoDoc doc, ObjectAttributes att, List<Guid> obj_ids)
        {
            // Example logic for baking
            foreach (GH_Goo<EnvelopeSetting> goo in m_data)
            {
                try
                {
                    foreach (List<GH_Goo<EnvelopeSetting>> list in this.m_data.Branches)
                    {
                        try
                        {
                            foreach (GH_Goo<EnvelopeSetting> t in list)
                            {
                                if (t != null)
                                {
                                    var surface = (t.Value).GetAllSurfaces();

                                    try
                                    {
                                        foreach (var ghSurface in surface)
                                        {
                                            var geometry = ghSurface.Value;
                                            // Add geometry to Rhino document
                                            Guid id = doc.Objects.Add(geometry, att);
                                            // Add the id to the list of baked object ids
                                            obj_ids.Add(id);
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
