namespace RCBldGH.Modules
{
    public enum BemType
    {
        D=1,
        C=2,
        B=3,
        A=4
    }
    public class BEM
    {
        private const string Br = "\r\n";
        public BemType Type { get; set; }

        public string ToCen()
        {
            string result = "$BEM: \t!!! Building Energy Management System" + Br + Br;
            result +=
                $"BEM Type: {(int)Type} \t!!! 1. Class D: No building automation function,  2. Class C: adapting the operation of the building and technical systems to users needs, 3. Class B: optimizing the operation by the tuning of the different controllers and standard alarming and monitoring functions, 4. Class A: detecting faults of building and technical systems and providing support to the diagnosis of these faults, Reporting information regarding energy consumption, indoor conditions, and possibilities for improvement" +
                Br;
            return result;
        }
    }
}