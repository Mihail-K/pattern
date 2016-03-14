
module pattern.selections;

import pattern.base;

import std.meta;

template selection(patterns...)
    if(__traits(compiles, staticMap!(asPattern, patterns)))
{
    enum selection = function string(string input)
    {
        foreach(pattern; staticMap!(asPattern, patterns))
        {
            string result = pattern(input);
            if(result !is null) return result;
        }

        return null;
    };
}

version(unittest)
{
    import pattern.brackets;
    import pattern.primitives;
    import pattern.repeats;
}

unittest
{
    enum s = selection!(
        primitive!("a", "b", "c"),
        repeat!(bracket!('0', '9'))
    );

    assert(s("a") == "a");
    assert(s("0") == "0");
    assert(s("F") is null);

    assert(s("010") == "010");
    assert(s("abf") == "a");
    assert(s("d14") is null);
}
