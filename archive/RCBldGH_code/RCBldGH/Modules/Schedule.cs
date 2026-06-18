using RCBldGH.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RCBldGH.Modules
{
    /// <summary>
    /// Basic 类型的 Schedule 包含 Domain 和数据列表键值对。
    /// Related 类型的 Schedule 包含 Domain 和关联的 Schedule 名称。
    /// </summary>
    public enum ScheduleType
    {
        Basic,
        BuildingUse,
        MonthlyCoefficient,
        MonthlyItss,
        MonthlyBus,
    }

    public class Schedule
    {
        // fields
        private const string Br = "\r\n";

        // props
        public string Name { get; set; }
        public ScheduleType ScheduleType { get; set; }
        public List<TimespanSchedulePair> RelatedSchedules { get; set; }
        public List<TimespanDataPair> DataDetails { get; set; }

        // public methods
        public string ToCen()
        {
            if (ScheduleType==ScheduleType.BuildingUse)
            {
                return this.BuildUseToCen();
            }

            if (ScheduleType == ScheduleType.MonthlyCoefficient)
            {
                return this.MonthCoefficientToCen();
            }

            if (ScheduleType == ScheduleType.MonthlyItss)
            {
                return this.MonthSetPointToCen();
            }

            if (ScheduleType == ScheduleType.MonthlyBus)
            {
                return this.MonthUseToCen();
            }

            return this.BasicToCen();
        }

        public class ScheduleSetting
        {
            public Schedule AirInfiltrationSchedule { get; set; }
            public Schedule IndoorTemperatureSetPointSchedule { get; set; }
            public Schedule BuildingUseSchedule { get; set; }
        }
        private string MonthUseToCen()
        {
            var result = $"Schedule Name: {Name} \t!!! specify each month's use schedule" + Br;
            foreach (var schedule in RelatedSchedules)
            {
                result += schedule.ToCen();
            }

            return result + Br;
        }

        // private methods
        private string BasicToCen()
        {
            var result = $"Schedule Name: {Name}\t\t!!! specify the schedule name" + Br;
            foreach (var domainDataPair in DataDetails)
            {
                result += domainDataPair.ToCen();
            }

            return result + Br;
        }

        private string BuildUseToCen()
        {
            string result = $"Schedule Name: {Name}\t!!! specify the zone name, must be one designated in previous Building Zone Information" + Br;
            foreach (var domainDataPair in DataDetails)
            {
                result += domainDataPair.ToCen();
            }

            return result + Br;
        }

        private string MonthCoefficientToCen()
        {
            string result = $"Schedule Name: {Name} \t!!! specify the coefficient of air infiltration for each month" + Br;
            foreach (var domainDataPair in DataDetails)
            {
                result += domainDataPair.ToCen();
            }

            return result + Br;
        }
        private string MonthSetPointToCen()
        {
            string result = $"Schedule Name: {Name} \t!!! specify each month's setpoint" + Br;
            foreach (var schedule in RelatedSchedules)
            {
                result += schedule.ToCen();
            }

            return result + Br;
        }

        public override string ToString()
        {
            return $"Schedule: {this.Name}";
        }
    }
}
