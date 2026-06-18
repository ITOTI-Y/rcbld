using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Threading;
using GH_IO.Types;
using Grasshopper;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Data;
using Grasshopper.Kernel.Parameters;
using Grasshopper.Kernel.Types;
using Rhino;
using Rhino.Geometry;
using RCBldGH.Components.Envelope;
using RCBldGH.Modules;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using Rhino.Commands;
using System.Linq;
using static Grasshopper.Kernel.GH_FileWatcher;

namespace RCBldGH.Components
{
    public class RunComp : GH_Component
    {
        public RunComp() : base("Run1.2", "Run1.2", "Run1.2", "RCBldGH", "7.Simulation")
        {
        }
        public override Guid ComponentGuid => new Guid("{B870F688-D0F0-431B-9578-08986610BC54}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.Run;
        protected override void RegisterInputParams(GH_Component.GH_InputParamManager pManager)
        {
            pManager.AddGenericParameter("BUS Data", "BUS Data", "BUS Data", GH_ParamAccess.item);
            pManager.AddTextParameter("Project Name", "Project", "Project Name", GH_ParamAccess.item);
            pManager.AddTextParameter("First simulation day of the week", "FirstDay", "Simulation Mode, must be 'sun', 'mon', 'tue', 'wed', 'thr', 'fri' or 'sat'.", GH_ParamAccess.item);
            pManager.AddTextParameter("Model Order", "Order", "Model's order, 1 or 2", GH_ParamAccess.item, "1");
            pManager.AddTextParameter("Number of simulation", "SimNumber", "Number of simulation", GH_ParamAccess.item, "first_run");
            //Param_FilePath refFilePath = new Param_FilePath();
            //pManager.AddParameter(refFilePath, "Reference data file path", "Reference data", "Reference data file path.",
            //    GH_ParamAccess.item);
            //pManager.AddTextParameter("Time Step", "Step", "Time step must be 'H', 'D' or 'M'.", GH_ParamAccess.item);
            //pManager.AddTextParameter("City Name", "CityName", "CityName", GH_ParamAccess.item);
            //pManager.AddIntegerParameter("Number of selected ECMs", "ECMs Number", "Number of selected ECMs, the value cannot be greater than 12.",
            //    GH_ParamAccess.item);
            pManager.AddBooleanParameter("Run", "Run", "Run", GH_ParamAccess.item, false);
            //pManager.AddBooleanParameter("Open", "OpenFolder", "OpenFolder", GH_ParamAccess.item, false);
            pManager[2].Optional = true;
            //pManager[5].Optional = true;
           // pManager[6].Optional = true;
            //pManager[7].Optional = true;
            
        }

        protected override void RegisterOutputParams(GH_Component.GH_OutputParamManager pManager)
        {
            pManager.AddTextParameter("Monthly result", "M", "Simulation result.", GH_ParamAccess.item);
            pManager.AddTextParameter("Indoor temperature", "T", "Simulation result.", GH_ParamAccess.item);
            pManager.AddTextParameter("Hourly result", "H", "Simulation result.", GH_ParamAccess.item);            
            pManager.AddTextParameter("Output Info", "I", "Output information.", GH_ParamAccess.item);
            pManager.AddTextParameter("Output Info", "I", "Output information.", GH_ParamAccess.list);
        }
        private const string Br = "\r\n";
        string hourly;
        string monthly;
        string indoorTemperature;
        protected override void BeforeSolveInstance()
        {
            base.BeforeSolveInstance();
            if (Rhino.RhinoDoc.ActiveDoc.ModelUnitSystem != UnitSystem.Meters)
            {
                this.AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "The current model unit system is not Meters. Change it to Meters please. ");
            }
            if (File.Exists(hourly))
            {               
                File.Delete(hourly);                
            }
            if (File.Exists(monthly))
            {
                File.Delete(monthly);
            }
            if (File.Exists(indoorTemperature))
            {
                File.Delete(indoorTemperature);
            }
            
        }
        protected override void SolveInstance(IGH_DataAccess DA)
        {
            if (this.RunCount > 1)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "This component does not support outputting multiple files. Please check your input data.");
                return;
            }

            bool isRun = false;
            if (!DA.GetData("Run", ref isRun) || !isRun)
            {
                return;
            }

            // 获取环境变量
            string RCBldEngPath = Environment.GetEnvironmentVariable("RCBldEng");
            if (RCBldEngPath == null)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Can't find the environment variable RCBldEng in Windows. Please set up an environment variable RCBldEng to the directory where RCBldEng.exe is located.");
                return;
            }
            string lastChar = RCBldEngPath.Substring(RCBldEngPath.Length);
            if (lastChar == "\\" || lastChar == "/")
            {
                RCBldEngPath = RCBldEngPath.Substring(0, RCBldEngPath.Length - 1);
            }

            if (!Directory.Exists(RCBldEngPath))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "The directory pointed by environment variable RCBldEng does not exist.");
                return;
            }
            string RCBldEngExe = RCBldEngPath + @".\RCBldEng.exe";
            if (!File.Exists(RCBldEngExe))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "The file RCBldEng.exe does not exist in the directory pointed by environment variable RCBldEng.");
                return;
            }
            

            // 获取 BUS Data
            BusData busData = null;
            DA.GetData("BUS Data", ref busData);
            // 获取参考平面
            Plane plane = busData.Plane;

            // 获取根目录
            Directory.SetCurrentDirectory(Directory.GetParent(RCBldEngPath).FullName);
            string rootPath = Directory.GetCurrentDirectory();

            rootPath += "\\Projects\\";

            // 获取项目名称并定位或生成项目目录
            string projectName = string.Empty;
            DA.GetData("Project Name", ref projectName);
            if (projectName == string.Empty)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Project name is invalid.");
                return;
            }
            string simNumb = "1";
            DA.GetData("Number of simulation", ref simNumb);
           

            string projectPath = rootPath + "\\"+ projectName+"\\"+simNumb + "\\";
            if (!Directory.Exists(projectPath))
            {
                DirectoryInfo directoryInfo = Directory.CreateDirectory(projectPath);
                if (!directoryInfo.Exists)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Creating project directory failed.");
                    return;
                }
            }

            // 获取 First Day
            string firstDay = "sun";
            DA.GetData("First simulation day of the week", ref firstDay);
            if (firstDay == String.Empty || (firstDay != "sun" && firstDay != "mon" && firstDay != "tue" && firstDay != "wed" && firstDay != "thr" && firstDay != "fri" && firstDay != "sat"))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "First simulation day of the week is invalid. Must be 'sun', 'mon', 'tue', 'wed', 'thr', 'fri' or 'sat'. ");
                return;
            }

            string modelOrder = "1";
            DA.GetData("Model Order", ref modelOrder);
            if (modelOrder != "1" && modelOrder != "2" )
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Model Order is invalid. Must be 1 or 2. ");
                return;
            }
            // 获取 Mode
            string mode = "sim";
            //DA.GetData("Simulation Mode", ref mode);
            //if (mode == String.Empty || (mode != "sim" && mode != "calib" && mode != "sens" && mode != "opt"))
            //{
            //    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Simulation Mode is invalid. Must be 'sim','calib','sens' or 'opt'.");
            //    return;
            //}

            //string city = string.Empty;
            //if (mode == "sens" || mode == "opt")
            //{
            //    // 获取 CityName

            //    if (!DA.GetData("City Name", ref city) || city == string.Empty)
            //    {
            //        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "The City Name must be set in 'sens' and 'opt' mode.");
            //    }
            //}

            //int ecmNumber = -1;
            //if (mode == "opt")
            //{
            //    // 获取 ECMs Number

            //    if (!DA.GetData("Number of selected ECMs", ref ecmNumber) || ecmNumber < 0)
            //    {
            //        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "The 'Number of selected ECMs' must be set in 'opt' mode.");
            //    }
            //    if (ecmNumber > 12)
            //    {
            //        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "The Number of selected ECMs cannot be greater than 12.");
            //        return;
            //    }
            //}

            // 获取全部 Zone
            var zones = busData.Zones;

            // 设置外墙朝向
            foreach (var zone in zones)
            {
                zone.SetExternalFacade(plane);
            }

            // 获取全部 Monthly Schedules
            List<Schedule> monthlySchedules = busData.MonthlySchedules;

            // 获取全部 Building Use Schedules
            List<Schedule> buildingUseSchedules = busData.BuildingUseSchedules;

            // 获取全部 Indoor Temperature Setpoint Schedules
            List<Schedule> itss = busData.Itss;

            // 获取全部 EnvelopSurfaces 、 HVAC 以及 Lighting Setting
            List<HVAC> hvacList = busData.HvacList;
            List<LightingSetting> lightingSettings = busData.LightingSettings;
            List<EnvelopeSetting> surfaces = busData.Surfaces;

            // 材质分组
            List<Modules.Material> externalWallMaterials = busData.ExternalWallMaterials;
            List<Modules.Material> internalWallMaterials = busData.InternalWallMaterials;
            List<Modules.Material> windowMaterials = busData.WindowMaterials;
            List<Modules.Material> roofMaterials = busData.RoofMaterials;
            List<Modules.Material> externalFloorMaterials = busData.ExternalFloorMaterials;
            List<Modules.Material> internalFloorMaterials = busData.InternalFloorMaterials;

            // 获取 Basics
            Modules.Basics basics = busData.Basics;

            // 获取 DHW
            DHW dhw = busData.Dhw;

            // 获取 Pumps 

            Modules.Pumps pumps = busData.Pumps;

            // 获取 Renewable
            Modules.Renewable renewable = busData.Renewable;

            // 获取 BEM Type 并生成 BEM
            BEM bem = busData.Bem;
            // 获取 Energy Sources
            EnergySources energySources = busData.EnergySources;

            string outputText = "";
            
            string timeStep = string.Empty;
            //string calib_path = projectPath + "calibration_parameter.txt";
            string refFilePath = string.Empty;
            //if (mode == "calib")
            //{
            //    // 获取 Time Step
            //    if (!DA.GetData("Time Step", ref timeStep))
            //    {
            //        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Time Step cannot be none in 'calib' mode.");
            //        return;
            //    }
            //    if (timeStep == String.Empty || (timeStep != "H" && timeStep != "D" && timeStep != "M"))
            //    {
            //        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Time Step is invalid. Must be 'H', 'D' or 'M'.");
            //        return;
            //    }

            //    // 获取 reference data file path
            //    if (!DA.GetData("Reference data file path", ref refFilePath))
            //    {
            //        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Reference data file path cannot be none in 'calib' mode. ");
            //        return;
            //    }
            //    if (refFilePath == string.Empty)
            //    {
            //        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Reference data file path is invalid. ");
            //        return;
            //    }
            //    if (!File.Exists(refFilePath))
            //    {
            //        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Reference data file is not exist.");
            //        return;
            //    }

            //    // 获取 CalibrationPara
            //    Modules.CalibrationPara calibration = busData.Calibration;
            //    if (calibration == null)
            //    {
            //        AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Calibration");
            //        return;
            //    }

            //    // 写入 calibration_parameter.txt
            //    try
            //    {
            //        string calib_text = calibration.ToText();
            //        File.WriteAllText(calib_path, calib_text, Encoding.UTF8);
            //    }
            //    catch (Exception e)
            //    {
            //        DA.SetData(0, e.Message);
            //        throw;
            //    }

            //    outputText += "'calibration_parameter.txt' saved to " + projectPath + "\n";
            //}
            //bool openFolder = false;
            //DA.GetData("Open", ref openFolder);
            //if (openFolder)
            //{
            //    string filePath = @projectPath;

            //    try
            //    {
            //        // 使用 Process.Start 方法打开文件
            //        Process.Start(new ProcessStartInfo(filePath) { UseShellExecute = true });
            //    }
            //    catch
            //    {
            //    }
            //}

            //###############写入文件 辐照
            string cen_path = "";
            string solar_path = projectPath + projectName + "_" + simNumb + ".sol"; 
            string solar = "$"+"solar"+Br;
            foreach (var zone in zones)
            {
                if (zone.SolarOP != null)
                {
                    string[] opArray = zone.SolarOP.Select(n => n.ToString("F2")).ToArray();
                    string[] wArray = zone.SolarW.Select(n => n.ToString("F2")).ToArray();
                    string op = String.Join(",", opArray);
                    string w = String.Join(",",wArray);

                    solar += zone.Name + ": "  + w +";"+ op + Br;                    
                }
                else
                {
                    solar =null;
                }
            }
            File.WriteAllText(solar_path, solar, Encoding.UTF8);
            //#########################

            try
            {
                string totalString ="start" + Br + Br;                    

                if (basics != null)
                {
                    totalString += basics.ToCen() + Br;
                    cen_path = projectPath + projectName +"_"+simNumb+ ".sim";
                }
                else
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Basics is null. Unable to output file.");
                }

                if (itss.Count > 0)
                {
                    totalString +=
                        "$Indoor Temperature Setpoint Schedules: \t!!! in the form of [From hour To hour, WD_Tset_heat, WE_Tset_heat, WD_Tset_cool, WE_Tset_cool], note: full day is from 0 to 24 " + Br + Br;
                    foreach (var schedule in itss)
                    {
                        totalString += schedule.ToCen() + Br;
                    }
                }

                if (buildingUseSchedules.Count > 0)
                {
                    totalString +=
                        "$Building Use Schedules:\t!!! in the form of [From hour To hour, Occ_WD, Occ_WE, App_WD, App_WE, Light_WD, Light_WE, HVAC_WD, HVAC_WE, INFL_WD, INFL_WE]" + Br +
                        Br;
                    foreach (var schedule in buildingUseSchedules)
                    {
                        totalString += schedule.ToCen() + Br;
                    }
                }

                if (monthlySchedules.Count > 0)
                {
                    totalString += "$Monthly Schedules: " + Br + Br;
                    foreach (var schedule in monthlySchedules)
                    {
                        totalString += schedule.ToCen();
                    }
                }

                if (externalWallMaterials.Count > 0)
                {
                    totalString += "$External Wall Materials: !!! U-value, absorption coefficient, emissivity" + Br;
                    foreach (var material in externalWallMaterials)
                    {
                        totalString += material.ToCen();
                    }

                    totalString += Br;
                }

                if (internalWallMaterials.Count > 0)
                {
                    totalString += "$Internal Wall Materials: !!! U-value, absorption coefficient, emissivity" + Br;
                    foreach (var material in internalWallMaterials)
                    {
                        totalString += material.ToCen();
                    }

                    totalString += Br;
                }

                if (windowMaterials.Count > 0)
                {
                    totalString += "$Window Materials: !!! U-value, emissivity, SHGC" + Br;
                    foreach (var material in windowMaterials)
                    {
                        totalString += material.ToCen();
                    }

                    totalString += Br;
                }
                if (windowMaterials.Count == 0)
                {
                    totalString += "$Window Materials: !!! U-value, emissivity, SHGC" + Br;                    
                    totalString += "window_1: 0, 0, 0"; 
                    totalString += Br;
                }

                if (roofMaterials.Count > 0)
                {
                    totalString += "$Roof Materials: !!! U-value, absorption coefficient, emissivity 	#3.086" + Br;
                    foreach (var material in roofMaterials)
                    {
                        totalString += material.ToCen();
                    }

                    totalString += Br;
                }

                if (externalFloorMaterials.Count > 0)
                {
                    totalString +=
                        "$External Floor Materials: 	!!! U-value including internal and external insulation 	#0.307" +
                        Br;
                    foreach (var material in externalFloorMaterials)
                    {
                        totalString += material.ToCen();
                    }

                    totalString += Br;
                }

                if (internalFloorMaterials.Count > 0)
                {
                    totalString +=
                        "$Internal Floor Materials: \t!!! U-value including internal and external insulation \t#0.307" +
                        Br;
                    foreach (var material in internalFloorMaterials)
                    {
                        totalString += material.ToCen();
                    }

                    totalString += Br;
                }
                totalString += Br;

                if (surfaces.Count > 0)
                {
                    totalString += "$Envelope Setting:" + Br + Br;
                    foreach (var surface in surfaces)
                    {
                        totalString += surface.ToCen() + Br;
                    }
                }

                totalString += "$HVAC:" + Br + Br;
                foreach (var hvac in hvacList)
                {
                    totalString += hvac.ToCen() + Br;
                }

                totalString += Br;

                totalString += "$Lighting Setting:" + Br + Br;
                foreach (var lightingSetting in lightingSettings)
                {
                    totalString += lightingSetting.ToCen() + Br;
                }

                totalString += Br;
                totalString +=
                    "$Zones: !!! (specify each zone information in turn, unconditioned zones need not to be specified here)" + Br + Br;

                foreach (var zone in zones)
                {
                    totalString += zone.ToCen() + Br;
                }

                if (dhw != null)
                {
                    totalString += dhw.ToCen() + Br;
                }
                if (pumps != null)
                {
                    totalString += pumps.ToCen() + Br;
                }

                if (bem != null)
                {
                    totalString += bem.ToCen() + Br;
                }

                if (renewable != null)
                {
                    totalString += renewable.ToCen() + Br;
                }

                if (energySources != null)
                {
                    totalString += energySources.ToCen() + Br;
                }

                File.WriteAllText(cen_path, totalString, Encoding.UTF8);
                
                outputText += basics.BuildingName + ".sim" + " has been saved to " + projectPath + "\n";
            }
            catch (Exception e)
            {
                DA.SetData(0, e.Message);
                return;
            }
            // 调用 RCBldEng
            RunCMD cmd = new RunCMD() { cmdExe = RCBldEngExe, cmdCwd = RCBldEngPath };
             //string cmdPara = projectName + " " + modelOrder + " " + firstDay;
            string cmdPara = projectName + " " + firstDay;
            if (mode == "sim")
            {
                cmdPara += " -sim";
            }
            cmdPara = cmdPara + " " + simNumb;
           // if (mode == "calib")
           //{
           //   cmdPara += " -calib " + refFilePath + " -" + timeStep;
           // }

            //if (mode == "sens")
            //{
            //    cmdPara += " -sens " + city;
            //}

            //if (mode == "opt")
            //{
            //    cmdPara += " -opt " + city + " " + ecmNumber.ToString();
            //}

           
            string monthly = "";
            string hourly = "";
            string indoorTemperature = "";

            monthly = projectPath + projectName + "_" + simNumb + "_monthly" + ".csv";
            hourly = projectPath + projectName + "_" + simNumb + "_hourly" + ".csv";
            indoorTemperature = projectPath + projectName + "_" + simNumb + "_indoor_temperature" + ".csv";

            this.monthly = monthly;
            this.hourly = hourly;
            this.indoorTemperature = indoorTemperature;


            //Thread thread = new Thread(() =>
            //{
            cmd.cmdStr = cmdPara;
            cmd.Run();

            DA.SetData("Monthly result", monthly);
            DA.SetData("Hourly result", hourly);
            DA.SetData("Indoor temperature", indoorTemperature);
                   // AddRuntimeMessage(GH_RuntimeMessageLevel.Warning, "Files created and paths set!"); 
            //});
            //thread.Start();


            outputText += "CMD: " + cmdPara + "\n";
            outputText += "RCBldEng started.";
            DA.SetData(3, outputText);




            List<string> result = new List<string>();
            foreach (var zone in zones)
            {
                string zoneName = zone.ToCen();
                result.Add(zoneName);
            }
            DA.SetDataList(4, result);
        }

    }
    class RunCMD
    {
        public string cmdExe = "";
        public string cmdStr = "";
        public string cmdCwd = "";
        public void Run()
        {
            //bool result = false;
            try
            {
                using (Process myPro = new Process())
                {
                    ProcessStartInfo psi = new ProcessStartInfo(cmdExe, cmdStr)
                    {
                        UseShellExecute = false
                    };
                    myPro.StartInfo = psi;
                    if (cmdCwd != "")
                    {
                        myPro.StartInfo.WorkingDirectory = cmdCwd;
                    }
                    myPro.Start();
                    myPro.WaitForExit();
                }
            }
            catch
            {

            }
            //return result;
        }
    }

}