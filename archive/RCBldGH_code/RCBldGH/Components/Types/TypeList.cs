using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Text;
using GH_IO.Serialization;
using Grasshopper.Kernel;
using Grasshopper.Kernel.Types;

namespace RCBldGH.Components.Types
{
    public abstract class TypeList : GH_Param<IGH_Goo>, IGH_StateAwareObject
    {
        protected TypeList(IGH_InstanceDescription tag) : base(tag)
        {
        }

        protected TypeList(IGH_InstanceDescription tag, GH_ParamAccess access) : base(tag, access)
        {
        }

        protected TypeList(string name, string nickname, string description, string category, string subcategory, GH_ParamAccess access) : base(name, nickname, description, category, subcategory, access)
        {
        }

        protected override IGH_Goo InstantiateT()
        {
            return new GH_ObjectWrapper();
        }

        public override void CreateAttributes()
        {
            this.m_attributes = new TypeListAttributes(this);
        }
        public abstract List<TypeListItem> TypeItems { get; }
        // public abstract string DisplayName { get;}

        public virtual string DisplayName
        {
            get
            {
                string result;
                if (string.IsNullOrWhiteSpace(this.NickName))
                {
                    result = null;
                }
                else if (this.NickName.Equals("Type", StringComparison.OrdinalIgnoreCase))
                {
                    result = null;
                }
                else
                {
                    result = this.NickName;
                }
                return result;
            }
        }
        public bool Hidden { get; internal set; }

        public TypeListItem SelectedItem
        {
            get
            {
                TypeListItem selectedItem = null;
                foreach (TypeListItem listItem in this.TypeItems)
                {
                    if (listItem.Selected == true)
                    {
                        selectedItem = listItem;
                        break;
                    }
                }

                if (selectedItem == null)
                {
                    selectedItem = this.TypeItems[0];
                }

                return selectedItem;
            }
        }

        public virtual void SelectItem(int index)
        {
            if (index >= 0 && index < this.TypeItems.Count)
            {
                bool flag = false;
                int num = this.TypeItems.Count - 1;
                for (int i = 0; i <= num; i++)
                {
                    if (i == index)
                    {
                        if (!this.TypeItems[i].Selected)
                        {
                            flag = true;
                            break;
                        }
                    }
                    else if (this.TypeItems[i].Selected)
                    {
                        flag = true;
                        break;
                    }
                }
                if (flag)
                {
                    base.RecordUndoEvent("Select: " + this.TypeItems[index].Name);
                    int num2 = this.TypeItems.Count - 1;
                    for (int j = 0; j <= num2; j++)
                    {
                        this.TypeItems[j].Selected = (j == index);
                    }
                    this.ExpireSolution(true);
                }
            }
        }

        public string SaveState()
        {
            StringBuilder stringBuilder = new StringBuilder(this.TypeItems.Count);
            try
            {
                foreach (var item in TypeItems)
                {
                    stringBuilder.Append(item.Selected ? 'Y' : 'N');
                }
            }
            finally{}
            return stringBuilder.ToString();
        }

        public void LoadState(string state)
        {
            try
            {
                foreach (TypeListItem item in this.TypeItems)
                {
                    item.Selected = false;
                }
            }
            finally
            {
            }
            int num;
            if (int.TryParse(state, out num))
            {
                if (num >= 0 && num < this.TypeItems.Count)
                {
                    this.TypeItems[num].Selected = true;
                }
            }
            else
            {
                int num2 = Math.Min(state.Length, this.TypeItems.Count) - 1;
                for (int i = 0; i <= num2; i++)
                {
                    this.TypeItems[i].Selected = state[i].Equals('Y');
                }
            }
            this.ExpireSolution(false);
        }

        public override bool Write(GH_IWriter writer)
        {
            writer.SetInt32("ListCount", this.TypeItems.Count);
            for (int i = 0; i < TypeItems.Count; i++)
            {
                GH_IWriter iWriter = writer.CreateChunk("TypeListItem", i);
                iWriter.SetString("Name", this.TypeItems[i].Name);
                iWriter.SetBoolean("Selected", this.TypeItems[i].Selected);
            }
            return base.Write(writer);
        }

        public override bool Read(GH_IReader reader)
        {
            int listCount = reader.GetInt32("ListCount");

            for (int i = 0; i < listCount; i++)
            {
                GH_IReader iReader = reader.FindChunk("TypeListItem", i);
                if (iReader == null)
                {
                    reader.AddMessage("Missing chunk for List Value: " + i.ToString(), GH_Message_Type.error);
                }
                else
                {
                    string name = iReader.GetString("Name");
                    bool selected = false;
                    iReader.TryGetBoolean("Selected", ref selected);
                    foreach (var item in this.TypeItems)
                    {
                        if (item.Name == name)
                        {
                            item.Selected = selected;
                        }
                    }
                }
            }
            return base.Read(reader);
        }
    }
}