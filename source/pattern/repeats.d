
module pattern.repeats;

import pattern.base;

import std.algorithm;
import std.array;
import std.conv;
import std.range;

template repeat(alias pattern) if(__traits(compiles, asPattern!pattern))
{
    enum repeat = function string(string input)
    {
        return std.range.repeat(0)
            .map!(iterator => asPattern!pattern(input))
            .tee!(result   => input = input[result.length .. $])
            .until!(result => result is null)
            .joiner
            .text;
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
    assert(r("dfeafsdc") is null);
}

unittest
{
    enum r = repeat!isAlpha;

    assert(r("abcdef") == "abcdef");
    assert(r("ab d f") == "ab");
    assert(r("abzd01") == "abzd");
}
