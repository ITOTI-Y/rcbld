using System;
using System.IO;
using System.Text;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Parameters;
using Grasshopper.Kernel.Types;
using Rhino;
using RCBldGH.Modules;

namespace RCBldGH.Components.Basics
{
    public class BasicsCompNew:GH_Component
    {
        public BasicsCompNew(): base("Basics1.1", "Basics", "Building information","RCBldGH", "5.Basics")
        {
        }

        public override Guid ComponentGuid => new Guid("{34be6a0c-9d9b-4573-8132-1892e8100e37}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.basic;
        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            Param_FilePath path = new Param_FilePath();
            pManager.AddParameter(path, "Weather File", "F", "only supports .epw file, the file should be under \\\\Weather_Files\\\\",
                GH_ParamAccess.item);
            pManager.AddTextParameter("Building Name", "N", "Specify the building name", GH_ParamAccess.item,"building");
            pManager.AddGenericParameter("Building Type", "T", "1. residential, 2. commercial, 3. industrial.Default:Commercial.", GH_ParamAccess.item);
            pManager.AddGenericParameter("Terrain Class", "TC", "1. open terrain, 2. country 3. urban/city,default:UrbanCity.", GH_ParamAccess.item);
            pManager.AddGenericParameter("Ground Type", "GT", "1. clay or silt, 2. sand or gravel 3. homogeneous rock.Default:Homogeneous rock", GH_ParamAccess.item);
           
            pManager.AddIntegerParameter("Envelope Heat Capacity Type", "CT", "Envelope Heat Capacity Type. Cm in unit (J/K m2), 1:10000, 2: 15000, 3: 25000, 4: 40000, 5: 60000, 6: 80000, 7: 115000, 8: 165000, 9: 260000, 10: 300000; 11. 370000, if empty, envelope heat capacity should be given", GH_ParamAccess.item);
            pManager.AddIntegerParameter("Envelope Heat Capacity", "C", "Envelope Heat Capacity. Unit: J/K m2", GH_ParamAccess.item);
            pManager.AddNumberParameter("Effective Mass Area", "MA", "Effective Mass Area. Unit: area per floor area.",GH_ParamAccess.item);
            pManager.AddTextParameter("Ground temperture", "GT", "Effective Mass Area. Unit: area per floor area.", GH_ParamAccess.item);

            pManager[2].Optional = true;
            pManager[3].Optional = true;
            pManager[4].Optional = true;
            pManager[5].Optional = true;
            pManager[6].Optional = true;
            pManager[7].Optional = true;
            pManager[8].Optional = true;
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddGenericParameter("Basics", "B", "Basics", GH_ParamAccess.item);
            pManager.AddTextParameter("Text", "T", "Basics text", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            string path = string.Empty;
            if (!DA.GetData("Weather File", ref path))
            {
                return;
            }

            if (!File.Exists(path))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Weather File is not a existed file. ");
                return;
            }
            string extension = Path.GetExtension(path);
            if (extension.ToLower() != ".epw")
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Weather File is not a *.epw file.");
                return;
            }          
            
            
            string groundSurfaceTemperatureStr = "18,18,18,18,18,18,18,18,18,18,18,18";
            try
            {
                DA.GetData("Ground temperture", ref groundSurfaceTemperatureStr);
            }
            catch (Exception e)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, e.ToString());
            }

            if (groundSurfaceTemperatureStr == string.Empty)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, $"Unable to get Monthly Ground Surface Temperature from {path}.");
                return;
            }

            string name = string.Empty;
            if (!DA.GetData("Building Name", ref name))
            {
                return;
            }

            object buildingTypeObj = null;
            BuildingType buildingType;
            if (!DA.GetData("Building Type", ref buildingTypeObj))
            {
                buildingType = BuildingType.Commercial;
            }
            else
            {
                try
                {
                    buildingType = (BuildingType)((GH_ObjectWrapper)buildingTypeObj).Value;
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Building Type");
                    return;
                }
            }

            TerrainClass terrainClass;
            object terrainClassObj = null;
            if (!DA.GetData("Terrain Class", ref terrainClassObj))
            {
                terrainClass = TerrainClass.UrbanCity;
            }
            else
            {
                try
                {
                    terrainClass = (TerrainClass)((GH_ObjectWrapper)terrainClassObj).Value;
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Terrain Class");
                    return;
                }
            }

            GroundType groundType;
            object groundTypeObj = null;
            if (!DA.GetData("Ground Type", ref groundTypeObj))
            {
                groundType = GroundType.HomegeneousRock;
            }
            else
            {
                try
                {
                    groundType = (GroundType)((GH_ObjectWrapper)groundTypeObj).Value;
                }
                catch (Exception)
                {
                    AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Invalid Ground Type");
                    return;
                }
            }
            Modules.Basics basics = new Modules.Basics
            {
                WeatherFile = path,
                BuildingName = name,
                BuildingType = buildingType,
                TerrainClass = terrainClass,
                GroundType = groundType,
                MonthlyGroundSurfaceTemperatureStr = groundSurfaceTemperatureStr,
            };

            int type = -1;
            bool hasType = DA.GetData("Envelope Heat Capacity Type", ref type);
            if (hasType && (type < 1 || type > 11))
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "Envelope Heat Capacity Type cannot be less than 1 or greater than 11.");
                return;
            }

            if (hasType)
            {
                basics.EnvelopeHeatCapacityType = type;
                DA.SetData(0, basics);
                DA.SetData(1, basics.ToCen());
                return;
            }

            int envelopeHeatCapacity = -1;
            bool hasEnvelopHeatCapacity = DA.GetData("Envelope Heat Capacity", ref envelopeHeatCapacity);
            double effectiveMassArea = double.NaN;
            bool hasEffectiveMassArea = DA.GetData("Effective Mass Area", ref effectiveMassArea);

            if (!hasEnvelopHeatCapacity || !hasEffectiveMassArea)
            {
                AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "if \"Envelope Heat Capacity Type\" is Empty, then \"Envelope Heat Capacity\" and \"Effective Mass Area\"should be given.");
                return;
            }

            basics.EnvelopeHeatCapacity = envelopeHeatCapacity;
            basics.EffectiveMassArea = effectiveMassArea;
            DA.SetData(0, basics);
            DA.SetData(1, basics.ToCen());
        }

        public string ReadTemperatureFromEpw(string path)
        {
            StreamReader sr = new StreamReader(path, Encoding.UTF8);
            String line;
            while ((line = sr.ReadLine()) != null)
            {
                if (!line.Contains("GROUND TEMPERATURES"))
                {
                    continue;
                }

                var tempStrings = line.Split(',');
                if (tempStrings.Length < 18)
                {
                    return string.Empty;
                }

                string result = "";
                for (int i = 6; i < 18; i++)
                {
                    if (i != 17)
                    {
                        result += tempStrings[i] + ",";
                        continue;
                    }
                    result += tempStrings[i];
                }

                return result;
            }

            return string.Empty;
        }
    }
}