
module pattern.repeats;

import pattern.base;

import std.array;

template repeat(alias pattern) if(isPattern!pattern)
{
    enum repeat = function string(string input)
    {
        string result;
        Appender!string buffer;

        while((result = pattern(input)).length)
        {
            buffer ~= result;
            input   = input[result.length .. $];
        }

        return buffer.data;
    };
}

version(unittest)
{
    import pattern.brackets;
    import pattern.optionals;
    import pattern.primitives;
}

unittest
{
    enum r = repeat!(primitive!("a", "b", "c"));

    assert(r("aabbccdd") == "aabbcc");
    assert(r("acbadeac") == "acba");
    assert(r("")         == "");
}
