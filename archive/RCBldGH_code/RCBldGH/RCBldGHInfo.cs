using System;
using System.Drawing;
using Grasshopper.Kernel;

namespace RCBldGH
{
    public class RCBldGHInfo : GH_AssemblyInfo
    {
        public override string Name
        {
            get
            {
                return "RCBldGH";
            }
        }
        public override Bitmap Icon
        {
            get
            {
                //Return a 24x24 pixel bitmap to represent this GHA library.
                return null;
            }
        }
        public override string Description
        {
            get
            {
                //Return a short string describing the purpose of this GHA library.
                return "";
            }
        }
        public override Guid Id
        {
            get
            {
                return new Guid("7ad4028f-a394-4dac-8d88-e34c8bcbab67");
            }
        }

        public override string AuthorName
        {
            get
            {
                //Return a string identifying you or your company.
                return "";
            }
        }
        public override string AuthorContact
        {
            get
            {
                //Return a string representing your preferred contact details.
                return "";
            }
        }
    }
}
