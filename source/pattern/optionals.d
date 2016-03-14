
module pattern.optionals;

import pattern.base;

template optional(alias pattern) if(isPattern!pattern)
{
    enum optional = function string(string input)
    {
        string result = pattern(input);
        return result ? result : "";
    };
}

version(unittest)
{
    import pattern.primitives;
}

unittest
{
    enum c = optional!(primitive!("a", "b", "c"));

    assert(c("cat") == "c");
    assert(c("dog") == "");
}
