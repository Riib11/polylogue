## Module Parsing.String

Primitive parsers, combinators and functions for working with an input
stream of type `String`.

All of these primitive parsers will consume when they succeed.

All of these primitive parsers will not consume and will automatically
backtrack when they fail.

The behavior of these primitive parsers is based on the behavior of the
`Data.String` module in the __strings__ package.
In most JavaScript runtime environments, the `String`
is little-endian [UTF-16](https://en.wikipedia.org/wiki/UTF-16).

The primitive parsers which return `Char` will only succeed when the character
being parsed is a code point in the
[Basic Multilingual Plane](https://en.wikipedia.org/wiki/Plane_(Unicode)#Basic_Multilingual_Plane)
(the “BMP”). These parsers can be convenient because of the good support
that PureScript has for writing `Char` literals like `'あ'`, `'β'`, `'C'`.

The other primitive parsers, which return `CodePoint` and `String` types,
can parse the full Unicode character set. All of the primitive parsers
in this module can be used together.

### Position

In a `String` parser, the `Position {index}` counts the number of
unicode `CodePoint`s since the beginning of the input string.

Each tab character (`0x09`) encountered in a `String` parser will advance
the `Position {column}` by 8.

These patterns will advance the `Position {line}` by 1 and reset
the `Position {column}` to 1:
- newline (`0x0A`)
- carriage-return (`0x0D`)
- carriage-return-newline (`0x0D 0x0A`)

#### `char`

``` purescript
char :: forall m. Char -> ParserT String m Char
```

Match the specified BMP `Char`.

#### `string`

``` purescript
string :: forall m. String -> ParserT String m String
```

Match the specified string.

#### `anyChar`

``` purescript
anyChar :: forall m. ParserT String m Char
```

Match any BMP `Char`.
Parser will fail if the character is not in the Basic Multilingual Plane.

#### `anyCodePoint`

``` purescript
anyCodePoint :: forall m. ParserT String m CodePoint
```

Match any Unicode character.
Always succeeds when any input remains.

#### `satisfy`

``` purescript
satisfy :: forall m. (Char -> Boolean) -> ParserT String m Char
```

Match a BMP `Char` satisfying the predicate.

#### `satisfyCodePoint`

``` purescript
satisfyCodePoint :: forall m. (CodePoint -> Boolean) -> ParserT String m CodePoint
```

Match a Unicode character satisfying the predicate.

#### `takeN`

``` purescript
takeN :: forall m. Int -> ParserT String m String
```

Match a `String` exactly *N* characters long.

#### `rest`

``` purescript
rest :: forall m. ParserT String m String
```

Match the entire rest of the input stream. Always succeeds.

#### `eof`

``` purescript
eof :: forall m. ParserT String m Unit
```

Match “end-of-file,” the end of the input stream.

#### `match`

``` purescript
match :: forall m a. ParserT String m a -> ParserT String m (Tuple String a)
```

Combinator which returns both the result of a parse and the slice of
the input that was consumed while it was being parsed.

#### `regex`

``` purescript
regex :: forall m. String -> RegexFlags -> Either String (ParserT String m String)
```

Compile a regular expression `String` into a regular expression parser.

This function will use the `Data.String.Regex.regex` function to compile
and return a parser which can be used
in a `ParserT String m` monad.
If compilation fails then this function will return `Left` a compilation
error message.

The returned parser will try to match the regular expression pattern once,
starting at the current parser position. On success, it will return
the matched substring.

If the RegExp `String` is constant then we can assume that compilation will
always succeed and `unsafeCrashWith` if it doesn’t. If we dynamically
generate the RegExp `String` at runtime then we should handle the
case where compilation of the RegExp fails.

This function should be called outside the context of a `ParserT String m`
monad for two reasons:
1. If we call this function inside of the `ParserT String m` monad and
   then `fail` the parse when the compilation fails,
   then that could be confusing because a parser failure is supposed to
   indicate an invalid input string.
   If the compilation failure occurs in an `alt` then the compilation
   failure might not be reported at all and instead
   the input string would be parsed incorrectly.
2. Compiling a RegExp is expensive and it’s better to do it
   once in advance and then use the compiled RegExp many times than
   to compile the RegExp many times during the parse.

This parser may be useful for quickly consuming a large section of the
input `String`, because in a JavaScript runtime environment a compiled
RegExp is a lot faster than a monadic parser built from parsing primitives.

[*MDN Regular Expressions Cheatsheet*](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions/Cheatsheet)

#### Example

This example shows how to compile and run the `xMany` parser which will
capture the regular expression pattern `x*`.

```purescript
case regex "x*" noFlags of
  Left compileError -> unsafeCrashWith $ "xMany failed to compile: " <> compileError
  Right xMany -> runParser "xxxZ" do
    xMany
```

#### Flags

Set `RegexFlags` with the `Semigroup` instance like this.

```purescript
regex "x*" (dotAll <> ignoreCase)
```

The `dotAll`, `unicode`, and `ignoreCase` flags might make sense for
a `regex` parser. The other flags will
probably cause surprising behavior and you should avoid them.

[*MDN Advanced searching with flags*](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions#advanced_searching_with_flags)

#### `anyTill`

``` purescript
anyTill :: forall m a. Monad m => ParserT String m a -> ParserT String m (Tuple String a)
```

Combinator which finds the first position in the input `String` where the
phrase can parse. Returns both the
parsed result and the unparsable input section searched before the parse.
Will fail if no section of the input is parseable. To backtrack the input
stream on failure, combine with `tryRethrow`.

This combinator works like
[Data.String.takeWhile](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String#v:takeWhile)
or
[Data.String.Regex.search](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String.Regex#v:search)
and it allows using a parser for the pattern search.

This combinator is equivalent to `manyTill_ anyCodePoint`, but it will be
faster because it returns a slice of the input `String` for the
section preceding the parse instead of a `List CodePoint`.

Be careful not to look too far
ahead; if the phrase parser looks to the end of the input then `anyTill`
could be *O(n²)*.

#### `consumeWith`

``` purescript
consumeWith :: forall m a. (String -> Either String { consumed :: String, remainder :: String, value :: a }) -> ParserT String m a
```

Consume a portion of the input string while yielding a value.

Takes a consumption function which takes the remaining input `String`
as its argument and returns either an error message, or three fields:

* `value` is the value to return.
* `consumed` is the input `String` that was consumed. It is used to update the parser position.
  If the `consumed` `String` is non-empty then the `consumed` flag will
  be set to true. (Confusing terminology.)
* `remainder` is the new remaining input `String`.

This function is used internally to construct primitive `String` parsers.

#### `parseErrorHuman`

``` purescript
parseErrorHuman :: String -> Int -> ParseError -> Array String
```

Returns three `String`s which, when printed line-by-line, will show
a human-readable parsing error message with context.

#### Input arguments

* The first argument is the input `String` given to the parser which
errored.
* The second argument is a positive `Int` which indicates how many
characters of input `String` context are wanted around the parsing error.
* The third argument is the `ParseError` for the input `String`.

#### Output `String`s

1. The parse error message and the parsing position.
2. A string with an arrow that points to the error position in the
   input context (in a fixed-width font).
3. The input context. A substring of the input which tries to center
   the error position and have the wanted length and not include
   any newlines or carriage returns.

   If the parse error occurred on a carriage return or newline character,
   then that character will be included at the end of the input context.

#### Example

```
let input = "12345six789"
case runParser input (replicateA 9 String.Basic.digit) of
  Left err ->
    log $ String.joinWith "\n" $ parseErrorHuman input 20 err
```
---
```
Expected digit at position index:5 (line:1, column:6)
     ▼
12345six789
```


