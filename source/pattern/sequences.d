
module pattern.sequences;

import pattern.base;

import std.array;
import std.meta;

template sequence(patterns...) if(allSatisfy!(isPattern, patterns))
{
    enum sequence = function string(string input)
    {
        Appender!string buffer;

        foreach(pattern; patterns)
        {
            string result = pattern(input);
            if(result is null) return null;

            buffer ~= result;
            input   = input[result.length .. $];
        }

        return buffer.data;
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
