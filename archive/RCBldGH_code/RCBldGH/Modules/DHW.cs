namespace RCBldGH.Modules
{
    public enum DhwDistributionSystem
    {
        TapsWithin3M=1,
        TapsMoreThan3M = 2,
        CirculationSysOrUnknown=3
    }

    public enum DhwGenerationSystem
    {
        ElectricGeneration=1,
        VrBoiler=2,
        GasOrHrBoiler=3,
        CoGeneration=4,
        DistrictHeating=5,
        HeatPump=6,
        Steam=7,
    }
    public class DHW
    {
        private const string Br = "\r\n";
        public DhwDistributionSystem DhwDistributionSystem { get; set; }
        public DhwGenerationSystem DhwGenerationSystem { get; set; }

        public string ToCen()
        {
            var result = "$DHW: \t!!! domestic hot water" + Br + Br;
            result +=
                $"DHW Distribution System: {(int)DhwDistributionSystem} \t!!! 1. taps within 3m from heat generation, 2. taps more than 3m from heat generation, 3. circulation system or unknown" +
                Br;
            result +=
                $"DHW Generation System: {(int)DhwGenerationSystem} \t!!! 1. electric generation, 2. VR-boiler, 3. gas_boiler or HR-boiler, 4. co-generation, 5. district heating, 6. heat pump, 7. steam" + Br;
            return result;
        }

        public override string ToString()
        {
            return "DHW";
        }
    }
}