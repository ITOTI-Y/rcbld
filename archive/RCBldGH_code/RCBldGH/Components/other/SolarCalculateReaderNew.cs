using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Grasshopper;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using Grasshopper.Kernel.Parameters;
using Grasshopper.Kernel.Types;
using Microsoft.VisualBasic;
using Rhino.Geometry;
using RCBldGH.Modules;
using RCBldGH.Utils;

namespace RCBldGH.Components.Reader
{
    public class SolarCalculateReaderNew:GH_Component
    {
        public SolarCalculateReaderNew(): base("SolarCalculateReader_beta", "SolarCalculate_beta", "SolarData", "RCBldGH", "Other"){}
        
        public override Guid ComponentGuid => new Guid("{df53dcaa-5617-4087-acb9-943a5c4704d5}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddGenericParameter("SolarData", "S", " SolarData form SolarDataFromEPW Component", GH_ParamAccess.item);                        
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddNumberParameter("azimuth", "occupants", "occupants", GH_ParamAccess.list);
            //pManager.AddNumberParameter("time angle", "occupants", "occupants", GH_ParamAccess.list);
            pManager.AddNumberParameter("solartime", "occupants", "occupants", GH_ParamAccess.list);
            pManager.AddNumberParameter("zenith", "occupants", "occupants", GH_ParamAccess.list);
            //pManager.AddNumberParameter("delta", "occupants", "occupants", GH_ParamAccess.list);
            //pManager.AddPointParameter("DayPoint", "Point", "Point", GH_ParamAccess.tree);
            //pManager.AddPointParameter("HourPoint", "Point", "Point", GH_ParamAccess.tree);
            //pManager.AddNumberParameter("RSE", "rse", "rse", GH_ParamAccess.list);
            //pManager[4].Optional = true;

        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            Dictionary<string, List<double>> Solardata = new Dictionary<string, List<double>> { };
            DA.GetData(0, ref Solardata);

            var zeniths = Solardata["zenith"];
            var azimuths = Solardata["azimuth"];
            var solartime = Solardata["solar_time"];

            //List<double> azimuth = new List<double>();
            //List<double> omega = new List<double>();
            //List<double> solartime = new List<double>();
            //List<double> zenith = new List<double>();
            
            DA.SetDataList("azimuth", azimuths);
            //DA.SetDataList("time angle", omega);
            DA.SetDataList("solartime", solartime);
            DA.SetDataList("zenith", zeniths);
            //DA.SetDataList("delta", delta);
            //DA.SetDataTree(5, dayTree);
            //DA.SetDataTree(6, hourTree);
            //DA.SetDataList("RSE", rse);
        }


    }
}