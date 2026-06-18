using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Parameters;
using Grasshopper.Kernel.Types;
using Rhino;
using RCBldGH.Modules;


namespace RCBldGH.Components
{

    public class DataRecordComp : GH_Component, IGH_VariableParameterComponent
    {
        List<List<double>> allDoublesLists = new List<List<double>>();
        bool reset = false;
        double[] previousData;
        int a;


        public DataRecordComp() : base("DataRecord", "DataRecord", "DataRecord", "RCBldGH", "ParametricTool") { }

        public override GH_Exposure Exposure => GH_Exposure.primary;

        public override Guid ComponentGuid => new Guid("{21ae88f1-81bf-4e54-aa18-de6879cce1a2}");
        protected override System.Drawing.Bitmap Icon => RCBldGH.Properties.Resources.dataRecord;

        public bool CanInsertParameter(GH_ParameterSide side, int index)
        {
            if (index > 0)
                return true;
            else return false;
        }

        public bool CanRemoveParameter(GH_ParameterSide side, int index)
        {
            if (index > 0)
                return true;
            else
                return false;
        }

        public IGH_Param CreateParameter(GH_ParameterSide side, int index)
        {
            if (side == GH_ParameterSide.Input)
            {
                var p = new Param_Number();
                p.NickName = string.Format("data{0}", index);
                return p;
            }
            else
            {
                var p = new Param_Number();
                p.NickName = string.Format("dataList{0}", index);
                return p;
            }
        }

        public bool DestroyParameter(GH_ParameterSide side, int index)
        {
            return true;
        }

        public void VariableParameterMaintenance()
        {
            allDoublesLists = new List<List<double>>();

            for (int i = 0; i < Params.Input.Count - 1; i++)
            {
                List<double> doubles = new List<double>();
                allDoublesLists.Add(doubles);
            }
            a = Params.Input.Count-1;
            previousData = new double[a];
        }

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddBooleanParameter("Reset", "R", "Reset value.", GH_ParamAccess.item);
            pManager.AddNumberParameter("Data0", "D", "Data.", GH_ParamAccess.item);
            pManager[1].Optional = true;
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddNumberParameter("Value", "V", "Value", GH_ParamAccess.list);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
           
            DA.GetData(0, ref reset);
            if (reset)
            {
                allDoublesLists = new List<List<double>>();
                // 遍历所有输入参数
                for (int i = 0; i < a; i++)
                {                   
                    List<double> doubles = new List<double>();                    
                    allDoublesLists.Add(doubles);
                }
                previousData = new double[a];
            }            

            for (int i = 0; i < a; i++)
            {
                double data = 0;
                int input = i + 1;
                if (DA.GetData(input, ref data))
                {
                    // 检查当前数据是否与上一次的数据不同
                    if (data != previousData[i])
                    {
                        allDoublesLists[i].Add(data);
                        // 更新上一次的数据
                        previousData[i] = data;
                    }
                }
                DA.SetDataList(i, allDoublesLists[i]);
            }            
        }
    }
}
