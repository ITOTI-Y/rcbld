using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Windows.Forms;
using Grasshopper.GUI;
using Grasshopper.GUI.Canvas;
using Grasshopper.Kernel;

namespace RCBldGH.Components.Types
{
    public class TypeListAttributes:GH_Attributes<TypeList>
    {
        private RectangleF ItemBounds { get; set; }
        private RectangleF NameBounds { get; set; }
        public TypeListAttributes(TypeList owner) : base(owner)
        {
        }

        // 禁用输入端
        public override bool HasInputGrip => false;

        public override bool AllowMessageBalloon => false;

        public override GH_ObjectResponse RespondToMouseDown(GH_Canvas sender, GH_CanvasMouseEvent e)
        {
            if (e.Button == MouseButtons.Left)
            {
                TypeListItem firstSelectedItem = base.Owner.SelectedItem;
                if (firstSelectedItem != null && firstSelectedItem.BoxRight.Contains(e.CanvasLocation))
                {
                    ToolStripDropDownMenu toolStripDropDownMenu = new ToolStripDropDownMenu();
                    TypeListItem firstSelectedItem2 = base.Owner.SelectedItem;
                    foreach (TypeListItem item in base.Owner.TypeItems)
                    {
                        ToolStripMenuItem toolStripMenuItem = new ToolStripMenuItem(item.Name);
                        toolStripMenuItem.Click += this.ValueMenuItem_Click;
                        if (item == firstSelectedItem2)
                        {
                            toolStripMenuItem.Checked = true;
                        }

                        toolStripMenuItem.Tag = item;
                        toolStripDropDownMenu.Items.Add(toolStripMenuItem);
                    }
                    toolStripDropDownMenu.Show(sender, e.ControlLocation);
                    return GH_ObjectResponse.Handled;
                }
            }
            return base.RespondToMouseDown(sender, e);
        }

        private void ValueMenuItem_Click(object sender, EventArgs e)
        {
            ToolStripMenuItem toolStripMenuItem = (ToolStripMenuItem)sender;
            if (!toolStripMenuItem.Checked)
            {
                if (toolStripMenuItem.Tag is TypeListItem item)
                {
                    base.Owner.SelectItem(base.Owner.TypeItems.IndexOf(item));
                }
            }
        }

        protected override void Layout()
        {
            this.LayoutDropDown();
            this.ItemBounds = this.Bounds;
            this.NameBounds = new RectangleF(this.Bounds.X, this.Bounds.Y, 0f, this.Bounds.Height);
            if (base.Owner.DisplayName != null)
            {
                int num = GH_FontServer.StringWidth(base.Owner.DisplayName, GH_FontServer.Standard) + 10;
                this.NameBounds = new RectangleF(this.Bounds.X - (float)num, this.Bounds.Y, (float)num, this.Bounds.Height);
                this.Bounds = RectangleF.Union(this.NameBounds, this.ItemBounds);
            }
        }
        private void LayoutDropDown()
        {
            int num = this.ItemMaximumWidth() + 22;
            int num2 = 22;
            this.Pivot = GH_Convert.ToPoint(this.Pivot);
            this.Bounds = new RectangleF(this.Pivot.X, this.Pivot.Y, (float)num, (float)num2);
            TypeListItem selectedItem = base.Owner.SelectedItem;

            foreach (TypeListItem item in base.Owner.TypeItems)
            {
                if (item == selectedItem)
                {
                    item.SetDropdownBounds(this.Bounds);
                }
                else
                {
                    item.SetEmptyBounds(this.Bounds);
                }
            }
        }

        private int ItemMaximumWidth()
        {
            int num = 20;

            foreach (TypeListItem item in base.Owner.TypeItems)
            {
                int val = GH_FontServer.StringWidth(item.Name, GH_FontServer.Standard);
                num = Math.Max(num, val);
            }

            return num + 10;
        }

        protected override void Render(GH_Canvas canvas, Graphics graphics, GH_CanvasChannel channel)
        {
            if (channel == GH_CanvasChannel.Objects)
            {
                GH_Capsule gh_Capsule = GH_Capsule.CreateCapsule(this.Bounds, GH_Palette.Normal);
                gh_Capsule.AddOutputGrip(this.OutputGrip.Y);
                gh_Capsule.Render(canvas.Graphics, this.Selected, base.Owner.Locked, base.Owner.Hidden);
                gh_Capsule.Dispose();

                int zoomFadeLow = GH_Canvas.ZoomFadeLow;
                if (zoomFadeLow > 0)
                {
                    canvas.SetSmartTextRenderingHint();
                    GH_PaletteStyle impliedStyle = GH_CapsuleRenderEngine.GetImpliedStyle(GH_Palette.Normal, this);
                    Color color = Color.FromArgb(zoomFadeLow, impliedStyle.Text);
                    if (this.NameBounds.Width > 0f)
                    {
                        SolidBrush solidBrush = new SolidBrush(color);
                        graphics.DrawString(base.Owner.NickName, GH_FontServer.StandardAdjusted, solidBrush, this.NameBounds, GH_TextRenderingConstants.CenterCenter);
                        solidBrush.Dispose();
                        int x = Convert.ToInt32(this.NameBounds.Right);
                        int y = Convert.ToInt32(this.NameBounds.Top);
                        int y2 = Convert.ToInt32(this.NameBounds.Bottom);
                        GH_GraphicsUtil.EtchFadingVertical(graphics, y, y2, x, Convert.ToInt32(0.8 * (double)zoomFadeLow), Convert.ToInt32(0.3 * (double)zoomFadeLow));
                    }
                    this.RenderDropDown(canvas, graphics, color);
                }
            }
        }

        private void RenderDropDown(GH_Canvas canvas, Graphics graphics, Color color)
        {
            TypeListItem firstSelectedItem = base.Owner.SelectedItem;
            if (firstSelectedItem != null)
            {
                graphics.DrawString(firstSelectedItem.Name, GH_FontServer.StandardAdjusted, Brushes.Black, firstSelectedItem.BoxName, GH_TextRenderingConstants.CenterCenter);
                RenderDownArrow(canvas, graphics, firstSelectedItem.BoxRight, color);
            }
        }

        private static void RenderDownArrow(GH_Canvas canvas, Graphics graphics, RectangleF bounds, Color color)
        {
            int num = Convert.ToInt32(bounds.X + 0.5f * bounds.Width);
            int num2 = Convert.ToInt32(bounds.Y + 0.5f * bounds.Height);
            PointF[] points = new PointF[]
            {
                new PointF((float)num, (float)(num2 + 6)),
                new PointF((float)(num + 6), (float)(num2 - 6)),
                new PointF((float)(num - 6), (float)(num2 - 6))
            };
            RenderShape(canvas, graphics, points, color);
        }

        private static void RenderShape(GH_Canvas canvas, Graphics graphics, PointF[] points, Color color)
        {
            int zoomFadeMedium = GH_Canvas.ZoomFadeMedium;
            float num = points[0].X;
            float num2 = num;
            float num3 = points[0].Y;
            float num4 = num3;
            int num5 = points.Length - 1;
            for (int i = 1; i <= num5; i++)
            {
                num = Math.Min(num, points[i].X);
                num2 = Math.Max(num2, points[i].X);
                num3 = Math.Min(num3, points[i].Y);
                num4 = Math.Max(num4, points[i].Y);
            }
            RectangleF rect = RectangleF.FromLTRB(num, num3, num2, num4);
            rect.Inflate(1f, 1f);
            LinearGradientBrush linearGradientBrush = new LinearGradientBrush(rect, color, GH_GraphicsUtil.OffsetColour(color, 50), LinearGradientMode.Vertical);
            linearGradientBrush.WrapMode = WrapMode.TileFlipXY;
            graphics.FillPolygon(linearGradientBrush, points);
            linearGradientBrush.Dispose();
            if (zoomFadeMedium > 0)
            {
                Color color2 = Color.FromArgb(Convert.ToInt32(0.5 * (double)zoomFadeMedium), Color.White);
                Color color3 = Color.FromArgb(0, Color.White);
                LinearGradientBrush linearGradientBrush2 = new LinearGradientBrush(rect, color2, color3, LinearGradientMode.Vertical);
                linearGradientBrush2.WrapMode = WrapMode.TileFlipXY;
                Pen pen = new Pen(linearGradientBrush2, 3f);
                pen.LineJoin = LineJoin.Round;
                pen.CompoundArray = new float[]
                {
                    0f,
                    0.5f
                };
                graphics.DrawPolygon(pen, points);
                linearGradientBrush2.Dispose();
                pen.Dispose();
            }
            graphics.DrawPolygon(new Pen(color, 1f)
            {
                LineJoin = LineJoin.Round
            }, points);
        }
    }
}