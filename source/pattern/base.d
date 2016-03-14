
module pattern.base;

template isPattern(alias T)
{
    enum isPattern = __traits(compiles,
    {
        string input  = void;
        string result = T(input);
    });
}
