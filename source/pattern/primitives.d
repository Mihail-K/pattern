
module pattern.primitives;

import std.algorithm;
import std.range;
import std.string;

template primitive(primitives...) if(primitives.length > 0)
{
    enum primitive = function string(string input)
    {
        return primitives.only
            .filter!(primitive => input.startsWith(primitive))
            .chain(null.only)
            .takeOne
            .front;
    };
}

unittest
{
    enum p = primitive!("a", "b", "c");

    assert(p("cat") == "c");
    assert(p("dog") == null);
}
