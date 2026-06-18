using System;
using System.Collections.Generic;
using Grasshopper.Kernel;
using Rhino.Geometry;
using SimBldPyUI.Modules;
using SimBldPyUI.Utils;

namespace SimBldPyUI.Components
{
    public class CalibrationParaComp : GH_Component
    {
        public CalibrationParaComp()
            : base("Calibration Parameter", "Calibration",
                "Calibration Parameter",
                "SimBldPy", "Others")
        {
        }
        public override Guid ComponentGuid => new Guid("{08473D6E-13BD-4F4F-92D7-CB5250BC3F5B}");

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddIntegerParameter("Building Heat Capacity", "Building Heat Capacity", "Building Heat Capacity",
                GH_ParamAccess.list,new List<int> {10000,800000 });
            pManager.AddNumberParameter("Effective Mass Area", "Effective Mass Area", "Effective Mass Area",
                GH_ParamAccess.list,new List<double> { 1, 5 });
            pManager.AddNumberParameter("External Wall Material U-value", "External Wall Material U-value",
                "External Wall Material U-value",
                GH_ParamAccess.list,new List<double> { 0.3, 5});
            pManager.AddNumberParameter("External Wall Material Absorpsivity", "External Wall Material Absorpsivity",
                "External Wall Material Absorpsivity",
                GH_ParamAccess.list, new List<double> { 0.2, 0.95 });
            pManager.AddNumberParameter("Internal Wall Material U-value", "Internal Wall Material U-value",
                "Internal Wall Material U-value",
                GH_ParamAccess.list, new List<double> { 0.3, 5 });
            pManager.AddNumberParameter("Window Material U-value", "Window Material U-value",
                "Window Material U-value",GH_ParamAccess.list, new List<double> { 0.5, 6 });
            pManager.AddNumberParameter("Window Material Emissivity", "Window Material Emissivity",
                "Window Material Emissivity",GH_ParamAccess.list, new List<double> { 0.2, 0.95});
            pManager.AddNumberParameter("Window Material SHGC", "Window Material SHGC",
                "Window Material SHGC",GH_ParamAccess.list, new List<double> { 0.3, 0.95 });
            pManager.AddNumberParameter("Roof Material U-value", "Roof Material U-value",
                "Roof Material U-value",GH_ParamAccess.list, new List<double> { 0.3, 6 });
            pManager.AddNumberParameter("Roof Material Absorptivity", "Roof Material Absorptivity",
                "Roof Material Absorptivity",GH_ParamAccess.list, new List<double> { 0.2, 0.95 });
            pManager.AddNumberParameter("External Floor Material U-value", "External Floor Material U-value",
                "External Floor Material U-value",GH_ParamAccess.list, new List<double> { 0.3, 6 });
            pManager.AddNumberParameter("Internal Floor Material U-value", "Internal Floor Material U-value",
                "Internal Floor Material U-value",GH_ParamAccess.list, new List<double> { 0.3, 6 });
            pManager.AddNumberParameter("Air Infiltration Rate", "Air Infiltration Rate",
                "Air Infiltration Rate", GH_ParamAccess.list, new List<double> { 0.4, 4 });
            pManager.AddNumberParameter("Air Infiltration Style", "Air Infiltration Style",
                "Air Infiltration Style",GH_ParamAccess.list, new List<double> { 0, 1 });
            pManager.AddNumberParameter("At", "At", "At", GH_ParamAccess.list, new List<double> { 2, 5 });
            pManager.AddNumberParameter("Lighting Load", "Lighting Load", "Lighting Load",GH_ParamAccess.list, new List<double> { 2, 20 });
            pManager.AddNumberParameter("Plug Load", "Plug Load", "Plug Load",GH_ParamAccess.list, new List<double> { 5, 3 });
            pManager.AddNumberParameter("Heating COP", "Heating COP", "Heating COP",GH_ParamAccess.list, new List<double> { 0.5, 0.99 });
            pManager.AddNumberParameter("Cooling COP", "Cooling COP", "Cooling COP",GH_ParamAccess.list, new List<double> {2, 6 });
            pManager.AddNumberParameter("Heating Supply Air Temperature", "Heating Supply Air Temperature","Heating Supply Air Temperature",
                GH_ParamAccess.list, new List<double> { 20, 40 });
            pManager.AddNumberParameter("Cooling Supply Air Temperature", "Cooling Supply Air Temperature",
                "Cooling Supply Air Temperature",
                GH_ParamAccess.list, new List<double> {15, 26 });
            pManager.AddNumberParameter("HVAC Distribution Loss Coefficient", "HVAC Distribution Loss Coefficient",
                "HVAC Distribution Loss Coefficient",
                GH_ParamAccess.list, new List<double> { 0, 0.3 });

            pManager.AddNumberParameter("Heating Temperature Setpoint", "Heating Temperature Setpoint",
                "Heating Temperature Setpoint",
                GH_ParamAccess.item,20);
            pManager.AddNumberParameter("Cooling Temperature Setpoint", "Cooling Temperature Setpoint",
                "Cooling Temperature Setpoint",
                GH_ParamAccess.item,25);
            pManager.AddNumberParameter("Mutation Rate", "Mutation Rate", "Mutation Rate", GH_ParamAccess.list, new List<double> { 0.7, 1 });
            pManager.AddNumberParameter("Recombination Rate", "Recombination Rate", "Recombination Rate",
                GH_ParamAccess.item, 0.8);
            pManager.AddNumberParameter("Population Multiplier", "Population Multiplier", "Population Multiplier",
                GH_ParamAccess.item,20);
            pManager.AddNumberParameter("Maximum Iteration", "Maximum Iteration", "Maximum Iteration",
                GH_ParamAccess.item,30);
            pManager.AddNumberParameter("Convergence Tolerance", "Convergence Tolerance", "Convergence Tolerance",
                GH_ParamAccess.item,0.01);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Calibration Parameter", "P", "Calibration Parameter", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            CalibrationPara para = new CalibrationPara();

            if (!DA.GetDataList("Building Heat Capacity", para.BuildingHeatCapacity))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Building Heat Capacity Error!");
            }

            if (!DA.GetDataList("Effective Mass Area", para.EffectiveMassArea))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Effective Mass Area Error!");
            }

            if (!DA.GetDataList("External Wall Material U-value", para.ExternalWallMaterialU))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "External Wall Material U-value Error!");
            }

            if (!DA.GetDataList("External Wall Material Absorpsivity", para.ExternalWallMaterialA))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "External Wall Material Absorpsivity Error!");
            }

            if (!DA.GetDataList("Internal Wall Material U-value", para.InternalWallMaterialU))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Internal Wall Material U-value Error!");
            }

            if (!DA.GetDataList("Window Material U-value", para.WindowMaterialU))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Window Material U-value Error!");
            }

            if (!DA.GetDataList("Window Material Emissivity", para.WindowMaterialE))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Window Material Emissivity Error!");
            }

            if (!DA.GetDataList("Window Material SHGC", para.WindowMaterialShgc))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Window Material SHGC Error!");
            }

            if (!DA.GetDataList("Roof Material U-value", para.RoofMaterialU))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Roof Material U-value Error!");
            }

            if (!DA.GetDataList("Roof Material Absorptivity", para.RoofMaterialA))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Roof Material Absorptivity Error!");
            }

            if (!DA.GetDataList("External Floor Material U-value", para.ExternalFloorMaterialU))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "External Floor Material U-value Error!");
            }

            if (!DA.GetDataList("Internal Floor Material U-value", para.InternalFloorMaterialU))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Internal Floor Material U-value Error!");
            }

            if (!DA.GetDataList("Air Infiltration Rate", para.AirInfiltrationRate))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Air Infiltration Rate Error!");
            }

            if (!DA.GetDataList("Air Infiltration Style", para.AirInfiltrationStyle))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Air Infiltration Style Error!");
            }

            if (!DA.GetDataList("At", para.At))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "At Error!");
            }

            if (!DA.GetDataList("Lighting Load", para.LightingLoad))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Lighting Load Error!");
            }

            if (!DA.GetDataList("Plug Load", para.PlugLoad))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Plug Load Error!");
            }

            if (!DA.GetDataList("Heating COP", para.HeatingCop))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Heating COP Error!");
            }

            if (!DA.GetDataList("Cooling COP", para.CoolingCop))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Cooling COP Error!");
            }

            if (!DA.GetDataList("Heating Supply Air Temperature", para.HeatingSupplyAirTemperature))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Heating Supply Air Temperature Error!");
            }

            if (!DA.GetDataList("Cooling Supply Air Temperature", para.CoolingSupplyAirTemperature))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Cooling Supply Air Temperature Error!");
            }

            if (!DA.GetDataList("HVAC Distribution Loss Coefficient", para.HvacDistributionLossCoefficient))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "HVAC Distribution Loss Coefficient Error!");
            }

            double heatingTemperatureSetpoint = Double.NaN;
            if (!DA.GetData("Heating Temperature Setpoint", ref heatingTemperatureSetpoint))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Heating Temperature Setpoint Error!");
            }
            para.HeatingTemperatureSetPoint = heatingTemperatureSetpoint;

            double coolingTemperatureSetpoint = Double.NaN;
            if (!DA.GetData("Cooling Temperature Setpoint", ref coolingTemperatureSetpoint))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Cooling Temperature Setpoint Error!");
            }
            para.CoolingTemperatureSetPoint = coolingTemperatureSetpoint;


            if (!DA.GetDataList("Mutation Rate", para.MutationRate))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Mutation Rate Error!");
            }

            double recombinationRate = Double.NaN;
            if (!DA.GetData("Recombination Rate", ref recombinationRate))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Recombination Rate Error!");
            }
            para.RecombinationRate = recombinationRate;

            double populationMultiplier = Double.NaN;
            if (!DA.GetData("Population Multiplier", ref populationMultiplier))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Population Multiplier Error!");
            }
            para.PopulationMultiplier = populationMultiplier;

            double maximumIteration = Double.NaN;
            if (!DA.GetData("Maximum Iteration", ref maximumIteration))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Maximum Iteration Error!");
            }
            para.MaximumIteration = maximumIteration;

            double convergenceTolerance = Double.NaN;
            if (!DA.GetData("Convergence Tolerance", ref convergenceTolerance))
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Convergence Tolerance Error!");
            }
            para.ConvergenceTolerance = convergenceTolerance;

            string text = string.Empty;
            try
            {
                text = para.ToText();
            }
            catch (Exception)
            {
                throw ;
            }

            DA.SetData(0, para);
            DA.SetData(1, text);
        }
    }
}