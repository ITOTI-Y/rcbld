namespace RCBldGH.Domains
{
    /// <summary>
    /// 表示朝向，除了常规的八个方向以外，增加了朝上、朝下以及无效的方向。
    /// </summary>
    public enum Orientation
    {
        S,
        SE,
        E,
        NE,
        N,
        NW,
        W,
        SW,
        UP,
        DOWN,
        InValid
    }
}