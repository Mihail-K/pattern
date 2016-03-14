
module pattern.base;

template isPattern(alias pattern)
{
    enum isPattern = __traits(compiles,
    {
        string input  = void;
        string result = pattern(input);
    });
}

template isCharCallback(alias callback)
{
    enum isCharCallback = __traits(compiles,
    {
        char input  = void;
        bool output = callback(input);
    });
}

template isStringCallback(alias callback)
{
    enum isStringCallback = __traits(compiles,
    {
        string input = void;
        bool  output = callback(input);
    });
}

template asPattern(alias pattern) if(isPattern!pattern)
{
    alias asPattern = pattern;
}

template asPattern(alias callback) if(isCharCallback!callback)
{
    enum asPattern = function string(string input)
    {
        return input.length && callback(input[0]) ? input[0 .. 1] : null;
    };
}

template asPattern(alias callback) if(isStringCallback!callback)
{
    enum asPattern = function string(string input)
    {
        return input.length && callback(input) ? input[0 .. 1] : null;
    };
}
