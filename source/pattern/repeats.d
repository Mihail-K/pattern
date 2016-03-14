
module pattern.repeats;

import pattern.base;

import std.array;

template repeat(alias pattern) if(__traits(compiles, asPattern!pattern))
{
    enum repeat = function string(string input)
    {
        string result;
        Appender!string buffer;

        while((result = asPattern!pattern(input)).length)
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

    import std.ascii;
}

unittest
{
    enum r = repeat!(primitive!("a", "b", "c"));

    assert(r("aabbccdd") == "aabbcc");
    assert(r("acbadeac") == "acba");
    assert(r("")         == "");
}

unittest
{
    enum r = repeat!isAlpha;

    assert(r("abcdef") == "abcdef");
    assert(r("ab d f") == "ab");
    assert(r("abzd01") == "abzd");
}
