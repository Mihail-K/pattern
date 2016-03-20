
module pattern.base;

alias Pattern = string function(string input);

template isPattern(alias pattern)
{
    enum bool isPattern = __traits(compiles,
    {
        string input  = void;
        string result = pattern(input);
    });
}

template isCharCallback(alias callback)
{
    enum bool isCharCallback = __traits(compiles,
    {
        char input  = void;
        bool output = callback(input);
    });
}

template isStringCallback(alias callback)
{
    enum bool isStringCallback = __traits(compiles,
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
    enum Pattern asPattern = function string(string input)
    {
        return input.length && callback(input[0]) ? input[0 .. 1] : null;
    };
}

template asPattern(alias callback) if(isStringCallback!callback)
{
    enum Pattern asPattern = function string(string input)
    {
        return input.length && callback(input) ? input[0 .. 1] : null;
    };
}
