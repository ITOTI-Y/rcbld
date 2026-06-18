using Grasshopper.Kernel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Rhino;
using Rhino.Geometry;
using Grasshopper;


namespace RCBldGH.ultaricon
{
    public class TabProperties : GH_AssemblyPriority
    {
        public override GH_LoadingInstruction PriorityLoad()
        {
            var server = Grasshopper.Instances.ComponentServer;
            server.AddCategoryShortName("RCBldGH", "RCBld");
            server.AddCategorySymbolName("RCBldGH", 'R');
            server.AddCategoryIcon("RCBldGH", Properties.Resources.OIG);

                return GH_LoadingInstruction.Proceed;
        }
    }
}
