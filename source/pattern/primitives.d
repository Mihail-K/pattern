
module pattern.primitives;

template primitive(primitives...) if(primitives.length > 0)
{
    enum primitive = function string(string input)
    {
        foreach(primitive; primitives)
        {
            if(primitive.length <= input.length && primitive == input[0 .. primitive.length])
            {
                return primitive;
            }
        }

        return null;
    };
}

unittest
{
    enum p = primitive!("a", "b", "c");

    assert(p("cat") == "c");
    assert(p("dog") == null);
}
