using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using RCBldGH.Components.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components._2.Envelope._2._2window
{
    public class Toward : TypeList
    {
        /// <summary>
        /// Initializes a new instance of the MyComponent1 class.
        /// </summary>
        public Toward() : base(new GH_InstanceDescription("Toward", "T", 
            "ndicate the building orientation for the window opening, to be used with the WindowWallRate component.",
            "RCBldGH", "2.Envelops"))
        {
        }
        public override GH_Exposure Exposure => GH_Exposure.primary;
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.toward;
        /// <summary>
        /// Registers all the input parameters for this component.
        /// </summary>
        public override List<TypeListItem> TypeItems { get; } = new List<TypeListItem>
        {
            new TypeListItem("N", "n"),
            new TypeListItem("S", "s"),
            new TypeListItem("E", "e"),
            new TypeListItem("W", "w"),
        };

        protected override void CollectVolatileData_Custom()
        {
            this.m_data.Clear();

            this.m_data.Append(this.SelectedItem.Value, new GH_Path(0));

        }
        

        /// <summary>
        /// Provides an Icon for the component.
        /// </summary>
        
       

        /// <summary>
        /// Gets the unique ID for this component. Do not change this ID after release.
        /// </summary>
        public override Guid ComponentGuid
        {
            get { return new Guid("C0267B74-916C-4869-AA24-6CBA49E35B9F"); }
        }
    }
}