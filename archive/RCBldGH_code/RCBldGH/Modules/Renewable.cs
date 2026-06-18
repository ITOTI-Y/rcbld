namespace RCBldGH.Modules
{
    public class Renewable
    {
        public PV Pv { get; set; }
        public SWH Swh { get; set; }
        public WindTurbines WindTurbines { get; set; }
        private const string Br = "\r\n";

        public override string ToString()
        {
            return "Building renewable system";
        }

        public string ToCen()
        {
            string text = "";
            text += Pv.ToCen()+Br;
            text += Swh.ToCen() + Br;
            text += WindTurbines.ToCen() + Br;
            return text;
        }
    }
}