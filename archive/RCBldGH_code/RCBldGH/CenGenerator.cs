using RCBldGH.Modules;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using RCBldGH.Utils;

namespace RCBldGH
{
    public class CenGenerator
    {
        private string _fileContent;
        private const string Br = "\r\n";

        public Basics Basics { get; set; }
        public List<Schedule> IndoorTemperatureSetPointSchedules { get;set;}
        public List<Schedule> BuildingUseSchedules { get; set; }
        public List<Schedule> MonthlySchedules { get; set; }
        public List<Material> ExternalWallMaterials { get; set; }
        public List<Material> InternalWallMaterials { get; set; }
        public List<Material> WindowMaterials { get; set; }
        public List<Material> RoofMaterials { get; set; }
        public List<Material> ExternalFloorMaterials { get; set; }
        public List<Material> InternalFloorMaterials { get; set; }

        public List<EnvelopeSetting> EnvelopeSettings { get; set; }
        public List<HVAC> Hvac { get; set; }
        public List<LightingSetting> LightingSettings { get; set; }
        public List<Zone> Zones { get; set; }
        public DHW Dhw { get; set; }
        public Pumps Pumps { get; set; }
        public BEM Bem { get; set; }
        public PV Pv { get; set; }
        public SWH Swh { get; set; }
        public WindTurbines WindTurbines { get; set; }
        public EnergySources EnergySources { get; set; }

        public void Build()
        {
            _fileContent = GetHeader() + Br;

            if (Basics!=null)
            {
                _fileContent += Basics.ToCen() + Br;
            }

            if (IndoorTemperatureSetPointSchedules != null && IndoorTemperatureSetPointSchedules.Count > 0)
            {
                _fileContent +=
                    $"$Indoor Temperature Setpoint Schedules: \t!!! in the form of [From hour To hour, WD_Tset_heat, WE_Tset_heat, WD_Tset_cool, WE_Tset_cool], note: full day is from 0 to 24" +
                    Br + Br;
                foreach (var item in IndoorTemperatureSetPointSchedules)
                {
                    _fileContent += item.ToCen()+Br;
                }

                _fileContent += Br;
            }

            if (BuildingUseSchedules!=null)
            {
                _fileContent +=
                    $"$Building Use Schedules:\t!!! in the form of [From hour To hour, Occ_WD, Occ_WE, App_WD, App_WE, Light_WD, Light_WE, HVAC_WD, HVAC_WE, INFL_WD, INFL_WE]" +
                    Br + Br;
                foreach (var item in BuildingUseSchedules)
                {
                    _fileContent += item.ToCen() + Br;
                }
            }

            if (MonthlySchedules!=null)
            {
                _fileContent +=
                    $"$Monthly Schedules: " + Br + Br;
                foreach (var item in MonthlySchedules)
                {
                    _fileContent += item.ToCen() + Br;
                }

                _fileContent += Br;
            }

            if (ExternalWallMaterials != null)
            {
                _fileContent +=
                    $"$External InternalWall Materials: !!! U-value, absorption coefficient, emissivity" + Br;
                foreach (var item in ExternalWallMaterials)
                {
                    _fileContent += item.ToCen();
                }

                _fileContent += Br;
            }

            if (InternalWallMaterials != null)
            {
                _fileContent +=
                    $"$Internal InternalWall Materials: !!! U-value, absorption coefficient, emissivity" + Br;
                foreach (var item in InternalWallMaterials)
                {
                    _fileContent += item.ToCen();
                }

                _fileContent += Br;
            }

            if (WindowMaterials!=null)
            {
                _fileContent +=
                    $"$Window Materials: !!! U-value, emissivity, SHGC\t" + Br;
                foreach (var item in WindowMaterials)
                {
                    _fileContent += item.ToCen();
                }

                _fileContent += Br;
            }

            if (RoofMaterials!=null)
            {
                _fileContent +=
                    $"$Roof Materials: !!! U-value, absorption coefficient, emissivity" + Br;
                foreach (var item in RoofMaterials)
                {
                    _fileContent += item.ToCen();
                }

                _fileContent += Br;
            }

            if (ExternalFloorMaterials!=null)
            {
                _fileContent +=
                    $"$External InternalFloor Materials: \t!!! U-value including internal and external insulation " + Br;
                foreach (var item in ExternalFloorMaterials)
                {
                    _fileContent += item.ToCen();
                }

                _fileContent += Br;
            }

            if (InternalFloorMaterials!=null)
            {
                _fileContent +=
                    $"$Internal InternalFloor Materials: \t!!! U-value including internal and external insulation" + Br;
                foreach (var item in InternalFloorMaterials)
                {
                    _fileContent += item.ToCen();
                }

                _fileContent += Br;
            }

            if (EnvelopeSettings!=null)
            {
                _fileContent += "$Envelope Setting:" + Br + Br;
                foreach (var item in EnvelopeSettings)
                {
                    _fileContent += item.ToCen();
                    _fileContent += Br;
                }
                _fileContent += Br;
            }

            if (LightingSettings!=null)
            {
                _fileContent += "$Lighting Setting:" + Br + Br;
                foreach (var item in LightingSettings)
                {
                    _fileContent += item.ToCen();
                    _fileContent += Br;
                }

                _fileContent += Br;
            }

            if (Zones!=null)
            {
                _fileContent += "$Zones: !!! (specify each zone information in turn)" + Br + Br;
                foreach (var zone in Zones)
                {
                    _fileContent += zone.ToCen();
                    _fileContent += Br;
                }
                _fileContent += Br;
            }

            if (Dhw!=null)
            {
                _fileContent += Dhw.ToCen() + Br;
            }

            if (Pumps!=null)
            {
                _fileContent += Pumps.ToCen() + Br + Br;
            }

            if (Bem!=null)
            {
                _fileContent += Bem.ToCen();
            }

            if (Pv!=null)
            {
                _fileContent += Pv.ToCen();
            }

            if (Swh!=null)
            {
                _fileContent += Swh.ToCen();
            }

            if (WindTurbines!=null)
            {
                _fileContent += WindTurbines.ToCen();
            }

            if (EnergySources!=null)
            {
                _fileContent += EnergySources.ToCen();
            }
        }

        private string GetHeader()
        {
            return
                "";
        }

        
    }

}
