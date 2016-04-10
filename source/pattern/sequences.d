
module pattern.sequences;

import pattern.base;

import std.algorithm;
import std.conv;
import std.meta;
import std.range;

import core.exception;

template sequence(patterns...)
    if(__traits(compiles, staticMap!(asPattern, patterns)))
{
    enum sequence = function string(string input)
    {
        auto result = staticMap!(asPattern, patterns).only
            .map!(pattern => pattern(input))
            .tee!(result  => input = input[result.length .. $])
            .array;

        return result.all ? result.joiner.text : null;
    };
}

version(unittest)
{
    import pattern.primitives;
}

unittest
{
    enum s = sequence!(
        primitive!("a", "b", "c"),
        primitive!("+", "-"),
        primitive!("a", "b", "c")
    );

    assert(s("a+b") == "a+b");
    assert(s("c-a") == "c-a");
    assert(s("a*b") is null);
    assert(s("d-e") is null);
    assert(s("")    is null);
}
