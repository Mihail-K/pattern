
module pattern.brackets;

template bracket(char min, char max)
{
    enum bracket = function string(string input)
    {
        if(input.length && input[0] >= min && input[0] <= max)
        {
            return input[0 .. 1];
        }

        return null;
    };
}

unittest
{
    enum b = bracket!('a', 'f');

    assert(b("cat") == "c");
    assert(b("dog") == "d");
    assert(b("log") == null);
    assert(b("")    == null);
}
