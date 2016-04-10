
module pattern.selections;

import pattern.base;

import std.algorithm;
import std.meta;
import std.range;

template selection(patterns...)
    if(__traits(compiles, staticMap!(asPattern, patterns)))
{
    enum selection = function string(string input)
    {
        return staticMap!(asPattern, patterns).only
            .map!(pattern   => pattern(input))
            .filter!(result => result !is null)
            .chain(null.only)
            .takeOne
            .front;
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
