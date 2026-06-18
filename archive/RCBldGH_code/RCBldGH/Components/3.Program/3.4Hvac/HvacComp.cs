using System;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using RCBldGH.Domains;
using RCBldGH.Modules;

namespace RCBldGH.Components.Hvac
{
    public class HvacComp: GH_Component
    {
        public HvacComp()
            : base("HVAC", "HVAC",
                "HVAC",
                "RCBldGH", "3.Program")
        {
        }
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.HAVC;
        public override GH_Exposure Exposure => GH_Exposure.quarternary;
        public override Guid ComponentGuid
        {
            get { return new Guid("{CF55D59D-87FF-42D4-9E4F-FF252F198D43}"); }
        }

        protected override void RegisterInputParams(GH_Component.GH_InputParamManager pManager)
        {
            pManager.AddTextParameter("Name", "Name", "HVAC Name", GH_ParamAccess.item);
            pManager.AddBooleanParameter("Reheat Used in Summer", "Summer", "Reheat Used in Summer",
                GH_ParamAccess.item,false);
            pManager.AddNumberParameter("Reheat Temperature Delta", "Delta",
                "Reheat Temperature Delta", GH_ParamAccess.item);
            pManager.AddBooleanParameter("Reheat Used in Winter", "Reheat Used in Winter", "Reheat Used in Winter",
                GH_ParamAccess.item,false);
            pManager.AddNumberParameter("Heating Nominal Efficiency", "Heating Nominal Efficiency", "Heating Nominal Efficiency",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("Heating COP", "Heating COP", "", GH_ParamAccess.item);
            
            pManager.AddNumberParameter("Cooling Nominal COP", "Cooling Nominal COP", "", GH_ParamAccess.item);
            pManager.AddGenericParameter("Cooling COP", "Cooling COP", "", GH_ParamAccess.item);
            pManager.AddIntegerParameter("HVAC System Type", "HVAC System Type", "Refer to HVAC system type table.",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("Heat Recovery Type", "Heat Recovery Type", "1. no heat recovery, 2. heat change plates or pipes, 3. two-element-system, 4. loading cold with air-conditioning, 5. heat pipes, 6. slow rotating or intermittent heat exchanger.",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("Exhaust Air Recirculation Type", "Exhaust Air Recirculation Type",
                "1. no exhaust air recirculation, 2. exhaust air recirculation 20%, 3. exhaust air recirculation 40%, 4. exhaust air recirculation 60%.", GH_ParamAccess.item);
            pManager.AddNumberParameter("Design Heating Supply Air Temperature",
                "Design Heating Supply Air Temperature", "Determine the heating supply air temperature in Celsius, if left '-', default value will be used, unit: Celsius.", GH_ParamAccess.item);
            pManager.AddNumberParameter("Design Cooling Supply Air Temperature",
                "Design Cooling Supply Air Temperature", "Determine the cooling supply air temperature in Celsius, if left '-', default value will be used, unit: Celsius.", GH_ParamAccess.item);
            pManager.AddNumberParameter("Design Heating Hot Water Supply Temperature",
                "Design Heating Hot Water Supply Temperature", "unit: Celsius",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("Design Heating Hot Water Return Temperature",
                "Design Heating Hot Water Return Temperature", "unit: Celsius",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("Design Cooling Chilled Water Supply Temperature",
                "Design Cooling Chilled Water Supply Temperature", "unit: Celsius",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("Design Cooling Chilled Water Return Temperature",
                "Design Cooling Chilled Water Return Temperature", "unit: Celsius",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("Specific Fan Power", "Specific Fan Power", "Average electro-motor efficiency, unit: W/(m3/s).",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("Fan Flow Control Factor", "Fan Flow Control Factor", "Average control reduction factor.",
                GH_ParamAccess.item);
            pManager.AddNumberParameter("Heating Capacity", "Heating Capacity", "Define the heating capacity of the HVAC system, in kW, if '-' used then, the capacity if unlimited.", GH_ParamAccess.item);
            pManager.AddNumberParameter("Cooling Capacity", "Cooling Capacity", "Define the cooling capacity of the HVAC system, in kW, if '-' used then, the capacity if unlimited.", GH_ParamAccess.item);

            pManager[11].Optional = true;
            pManager[12].Optional = true;
            pManager[13].Optional = true;
            pManager[14].Optional = true;
            pManager[15].Optional = true;
            pManager[16].Optional = true;
            pManager[19].Optional = true;
            pManager[20].Optional = true;
        }

        protected override void RegisterOutputParams(GH_Component.GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("HVAC", "HVAC", "HVAC", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "HVAC Text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string name = string.Empty;
            if (!DA.GetData("Name", ref name))
            {
                return;
            }

            bool useInSummer = false;
            if (!DA.GetData("Reheat Used in Summer", ref useInSummer))
            {
                return;
            }

            double reheatTempDelta = double.NaN;
            if (!DA.GetData("Reheat Temperature Delta", ref reheatTempDelta))
            {
                return;
            }

            bool useInWinter = false;
            if (!DA.GetData("Reheat Used in Winter", ref useInWinter))
            {
                return;
            }

            double heatingNominalEfficiency = double.NaN;
            if (!DA.GetData("Heating Nominal Efficiency", ref heatingNominalEfficiency))
            {
                return;
            }

            object heatingCopObj = null;
            if (!DA.GetData("Heating COP", ref heatingCopObj))
            {
                return;
            }

            CopPairGroup heatingCops = new CopPairGroup();
            try
            {
                heatingCops = (CopPairGroup) ((GH_ObjectWrapper) heatingCopObj).Value;
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Heating COP Group.");
                return;
            }


            double coolingNominalCop = double.NaN;
            if (!DA.GetData("Cooling Nominal COP", ref coolingNominalCop))
            {
                return;
            }

            object coolingCopObj = null;
            if (!DA.GetData("Cooling COP", ref coolingCopObj))
            {
                return;
            }

            CopPairGroup coolingCops = new CopPairGroup();
            try
            {
                coolingCops = (CopPairGroup) ((GH_ObjectWrapper)coolingCopObj).Value;
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Cooling COP Group.");
                return;
            }

            int systemType = 0;
            if (!DA.GetData("HVAC System Type", ref systemType))
            {
                return;
            }

            object heatRecoveryTypeObj = null;
            if (!DA.GetData("Heat Recovery Type", ref heatRecoveryTypeObj))
            {
                return;
            }

            HeatRecoveryType heatRecoveryType;
            try
            {
                heatRecoveryType = (HeatRecoveryType) ((GH_ObjectWrapper) heatRecoveryTypeObj).Value;
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Heat Recovery Type");
                return;
            }

            object exhaustAirRecirculationTypeObj = null;
            if (!DA.GetData("Exhaust Air Recirculation Type", ref exhaustAirRecirculationTypeObj))
            {
                return;
            }

            ExhaustAirRecirculationType exhaustAirRecirculationType;
            try
            {
                exhaustAirRecirculationType =
                    (ExhaustAirRecirculationType) ((GH_ObjectWrapper) exhaustAirRecirculationTypeObj).Value;
            }
            catch (Exception)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Exhaust Air Recirculation Type");
                return;
            }

            double designHeatingAirTemp = double.NaN;
            DA.GetData("Design Heating Supply Air Temperature", ref designHeatingAirTemp);

            double designCoolingAirTemp = double.NaN;
            DA.GetData("Design Cooling Supply Air Temperature", ref designCoolingAirTemp);

            double designHotWaterSupplyTemp = double.NaN;
            DA.GetData("Design Heating Hot Water Supply Temperature", ref designHotWaterSupplyTemp);

            double designHotWaterReturnTemp = double.NaN;
            DA.GetData("Design Heating Hot Water Return Temperature", ref designHotWaterReturnTemp);

            double designCoolingWaterSupplyTemp = double.NaN;
            DA.GetData("Design Cooling Chilled Water Supply Temperature", ref designCoolingWaterSupplyTemp);

            double designCoolingWaterReturnTemp = double.NaN;
            DA.GetData("Design Cooling Chilled Water Return Temperature", ref designCoolingWaterReturnTemp);


            double specificFanPower = double.NaN;
            if (!DA.GetData("Specific Fan Power", ref specificFanPower))
            {
                return;
            }

            double fanFlowControlFactor = double.NaN;
            if (!DA.GetData("Fan Flow Control Factor", ref fanFlowControlFactor))
            {
                return;
            }

            double heatingCapacity = double.NaN;
            DA.GetData("Heating Capacity", ref heatingCapacity);
            double coolingCapacity = double.NaN;
            DA.GetData("Cooling Capacity", ref coolingCapacity);

            Modules.HVAC hvac = new HVAC
            {
                Name = name,
                ReheatUsedInSummer = useInSummer,
                ReheatTemperatureDelta = reheatTempDelta,
                ReheatUsedInWinter = useInWinter,
                HeatingNominalEfficiency = heatingNominalEfficiency,
                HeatingCops = heatingCops,
                CoolingNominalCop = coolingNominalCop,
                CoolingCops = coolingCops,
                HvacSystemType = systemType,
                HeatRecoveryType = heatRecoveryType,
                ExhaustAirRecirculationType = exhaustAirRecirculationType,
                DesignHeatingSupplyAirTemperature = designHeatingAirTemp,
                DesignCoolingSupplyAirTemperature = designCoolingAirTemp,
                DesignHeatingHotWaterSupplyTemperature = designHotWaterSupplyTemp,
                DesignHeatingHotWaterReturnTemperature = designHotWaterReturnTemp,
                DesignCoolingChilledWaterSupplyTemperature = designCoolingWaterSupplyTemp,
                DesignCoolingChilledWaterReturnTemperature = designCoolingWaterReturnTemp,
                SpecificFanPower = specificFanPower,
                FanFlowControlFactor = fanFlowControlFactor,
                HeatingCapacity = heatingCapacity,
                CoolingCapacity = coolingCapacity
            };

            DA.SetData(0, hvac);
            DA.SetData(1, hvac.ToCen());
        }
    }
}