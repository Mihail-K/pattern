
module pattern.complements;

import pattern.base;

template complement(alias pattern) if(__traits(compiles, asPattern!pattern))
{
    enum complement = function string(string input)
    {
        if(input.length)
        {
            string result = asPattern!pattern(input);
            return result ? null : [ input[0] ];
        }

        return null;
    };
}

version(unittest)
{
    import pattern.primitives;
}

unittest
{
    enum c = complement!(primitive!("a", "b", "c"));

    assert(c("cat") == null);
    assert(c("dog") == "d");
}
