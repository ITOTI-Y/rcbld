using System.Drawing;
using Grasshopper.Kernel.Types;

namespace RCBldGH.Components.Types
{
    public class TypeListItem
    {
        public TypeListItem(string name, object obj)
        {
            Value = new GH_ObjectWrapper(obj);
            Name = name;
        }

        public bool Selected { get; set; }

        public string Name { get; }
        public IGH_Goo Value { get; }

        public RectangleF BoxLeft { get; set; }
        public RectangleF BoxRight { get; set; }
        public RectangleF BoxName { get; set; }

        internal void SetDropdownBounds(RectangleF bounds)
        {
            this.BoxLeft = new RectangleF(bounds.X, bounds.Y, 0f, bounds.Height);
            this.BoxName = new RectangleF(bounds.X, bounds.Y, bounds.Width - 22f, bounds.Height);
            this.BoxRight = new RectangleF(bounds.Right - 22f, bounds.Y, 22f, bounds.Height);
        }
        internal void SetEmptyBounds(RectangleF bounds)
        {
            this.BoxLeft = new RectangleF(bounds.X, bounds.Y, 0f, 0f);
            this.BoxName = new RectangleF(bounds.X, bounds.Y, 0f, 0f);
            this.BoxRight = new RectangleF(bounds.X, bounds.Y, 0f, 0f);
        }
    }
}