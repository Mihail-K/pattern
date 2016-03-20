# Pattern
Templated types for string pattern matching and lexers.

Pattern can be used to construct elaborate and complex pattern matchers that can operate at compile time (`std.regex` currently cannot), and are often faster than both `regex` and `ctRegex` matchers. Pattern was designed with lexers in mind.

## Hello World

```d
import pattern;

void main()
{
    // A pattern for lowercase letters.
    auto letters = repeat!(bracket!('a', 'z'));

    assert(letters("hello world") == "hello");
}
```

Patterns can also be defined from callback functions that accept either `string` or `char` and return `bool`.

```d
import std.ascii : isWhite;

string whitespace(string input)
{
    // A pattern for whitespaces.
    enum pattern = repeat!isWhite;

    return pattern(input);
}
```

## Pattern Types

Here's a short list of pattern types and concise examples of how they behave.

#### Primitive

```d
void keyword()
{
    // A pattern that matches 'this' or 'that'
    enum p = primitive!("this", "that");

    assert(p("this") == "this");
    assert(p("them") is null);
}
```

#### Bracket

```d
void numeric()
{
    // A pattern that behaves like /[0-9]/
    enum p = bracket!('0', '9');

    assert(p("123") == "1");
    assert(p("abc") is null);
}
```

#### Complement

```d
void nonNumeric()
{
    // A pattern that behaves like /[^0-9]/
    enum p = complement!(bracket!('0', '9'));

    assert(p("123") is null);
    assert(p("abc") == "a");
}
```

#### Repeat

```d
void integer()
{
    // A pattern that behaves like /[0-9]+/
    enum p = repeat!(bracket!('0', '9'));

    assert(p("123") == "123");
    assert(p("abc") is null);
}
```

#### Optional

```d
void mightBeInt()
{
    // A pattern that behaves like /[0-9]?/
    enum p = optional!(bracket!('0', '9'));

    assert(p("123") == "123");
    assert(p("abc") == "");
}
```

#### Sequence

```d
void decimal()
{
    // A pattern that behaves like /[0-9]\.[0-9]/
    enum p = sequence!(
        bracket!('0', '9'),
        primitive!("."),
        bracket!('0', '9')
    );

    assert(p("1.5") == "1.5");
    assert(p("1.b") is null);
    assert(p("5")   is null);
}
```

#### Selection

```d
void intOrName()
{
    // A pattern that behaves like /[0-9]+|[a-z]+/
    enum p = selection!(
        repeat!(bracket!('0', '9')),
        repeat!(bracket!('a', 'z'))
    );

    assert(p("123") == "123");
    assert(p("abc") == "abc");
}
```

## License

MIT
