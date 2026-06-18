using System;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;
using RCBldGH.Modules;

namespace RCBldGH.Components.Energy
{
    public class EnergySourceComp:GH_Component
    {
        public EnergySourceComp()
            : base("Energy Source", "Energy",
                "Energy Source",
                "RCBldGH", "6.Energy")
        {
        }

        public override Guid ComponentGuid => new Guid("{18789AEF-17EB-4741-95DA-D722973DB141}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.ES;
        public override GH_Exposure Exposure => GH_Exposure.tertiary;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddGenericParameter("Heating Energy Source", "H", "1: 'electricity', 2:'natural gas', 3: 'district cooling', 4: 'district heating', 5: 'steam', 6: 'gasoline', 7: 'diesel', 8: 'coal', 9: 'fuel oil' , 10: 'propane', 11: 'kerosene', 12: 'traditional bio' , 13: 'others'.",
                GH_ParamAccess.item);
            pManager.AddGenericParameter("Cooling Energy Source", "C", "1: 'electricity', 2:'natural gas', 3: 'district cooling', 4: 'district heating', 5: 'steam', 6: 'gasoline', 7: 'diesel', 8: 'coal', 9: 'fuel oil' , 10: 'propane', 11: 'kerosene', 12: 'traditional bio' , 13: 'others'.", GH_ParamAccess.item);
            pManager.AddGenericParameter("DHW Energy Source", "D", "1: 'electricity', 2:'natural gas', 3: 'district cooling', 4: 'district heating', 5: 'steam', 6: 'gasoline', 7: 'diesel', 8: 'coal', 9: 'fuel oil' , 10: 'propane', 11: 'kerosene', 12: 'traditional bio' , 13: 'others'.", GH_ParamAccess.item);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Energy Sources", "E", "Energy Sources", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Energy Sources text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            object heatingObj = null;
            object coolingObj = null;
            object dhwObj = null;
            if (!DA.GetData(0,ref heatingObj)||!DA.GetData(1,ref coolingObj)||!DA.GetData(2,ref dhwObj))
            {
                return;
            }

            EnergySource heating;
            try
            {
                heating = (EnergySource) ((GH_ObjectWrapper) heatingObj).Value;
            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Heating Energy Source.");
                return;
            }
            EnergySource cooling;
            try
            {
                cooling = (EnergySource) ((GH_ObjectWrapper)coolingObj).Value;
            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Cooling Energy Source.");
                return;
            }
            EnergySource dhw;
            try
            {
                dhw = (EnergySource) ((GH_ObjectWrapper) dhwObj).Value;
            }
            catch (Exception )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "DHW Energy Source.");
                return;
            }

            EnergySources sources =new EnergySources
            {
                CoolingEnergySource = cooling,
                DhwEnergySource = dhw,
                HeatingEnergySource = heating
            };
            DA.SetData(0, sources);
            DA.SetData(1, sources.ToCen());
        }
    }
}