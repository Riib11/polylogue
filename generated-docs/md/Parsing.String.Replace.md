## Module Parsing.String.Replace

This module is for finding patterns in a `String`, and also
replacing or splitting on the found patterns.
This activity is traditionally done with
[__Regex__](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String.Regex),
but this module uses parsers instead for the pattern matching.

Functions in this module are *ways to run a parser* on an input `String`,
like `runParser` or `runParserT`.

#### Why would we want to do pattern matching and substitution with parsers instead of regular expressions?

* Monadic parsers have a nicer syntax than
  [regular expressions](https://en.wikipedia.org/wiki/Regular_expression),
  which are notoriously
  [difficult to read](https://en.wikipedia.org/wiki/Write-only_language).
  With monadic parsers we can perform textual pattern-matching in plain
  PureScript rather than using a special regex domain-specific
  programming language.

* Regular expressions can do “group capture” on sections of the matched
  pattern, but they can only return stringy lists of the capture groups. Parsers
  can construct typed data structures based on the capture groups, guaranteeing
  no disagreement between the pattern rules and the rules that we're using
  to build data structures based on the pattern matches.

  For example, consider
  scanning a string for numbers. A lot of different things can look like a number,
  and can have leading plus or minus signs, or be in scientific notation, or
  have commas, or whatever. If we try to parse all of the numbers out of a string
  using regular expressions, then we have to make sure that the regular expression
  and the string-to-number conversion function agree about exactly what is
  and what isn't a numeric string. We can get into an awkward situation in which
  the regular expression says it has found a numeric string but the
  string-to-number conversion function fails. A typed parser will perform both
  the pattern match and the conversion, so it will never be in that situation.
  [Parse, don't validate.](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/)

* Regular expressions are only able to pattern-match
  [regular grammars](https://en.wikipedia.org/wiki/Chomsky_hierarchy#The_hierarchy).
  Monadic parsers are able pattern-match context-free (by recursion)
  or context-sensitive (by monad transformer) grammars.

* The replacement expression for a traditional regular expression-based
  substitution command is usually just a string template in which
  the *Nth* “capture group” can be inserted with the syntax `\N`. With
  this library, instead of a template, we
  can perform any replacement computation, including `Effect`s.

#### Implementation Notes

All of the functions in this module work by calling `runParserT`
with the `anyTill` combinator.
We can expect the speed of parser-based pattern matching to be
about 10× worse than regex-based pattern matching in a JavaScript
runtime environment.
This module is based on the Haskell packages
[__replace-megaparsec__](https://hackage.haskell.org/package/replace-megaparsec)
and
[__replace-attoparsec__](https://hackage.haskell.org/package/replace-attoparsec).


#### `breakCap`

``` purescript
breakCap :: forall a. String -> Parser String a -> Maybe (T3 String a String)
```

#### Break on and capture one pattern

Find the first occurence of a pattern in the input `String`, capture the found
pattern, and break the input `String` on the found pattern.

This function can be used instead of
[Data.String.indexOf](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String#v:indexOf)
or
[Data.String.Regex.search](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String.Regex#v:search)
or
[Data.String.Regex.replace](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String.Regex#v:replace)
and it allows using a parser for the pattern search.

This function can be used instead of
[Data.String.takeWhile](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String#v:takeWhile)
or
[Data.String.dropWhile](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String#v:dropWhile)
and it is predicated beyond more than just the next single `CodePoint`.

#### Output

- `Nothing` when no pattern match was found.
- `Just (prefix /\ parse_result /\ suffix)` for the result of parsing the
  pattern match, and the `prefix` string before and the `suffix` string
  after the pattern match. `prefix` and `suffix` may be zero-length strings.

#### Access the matched section of text

To capture the matched string combine the pattern
parser `sep` with the `match` combinator.

With the matched string, we can reconstruct the input string.
For all `input`, `sep`, if

```purescript
let (Just (prefix /\ (infix /\ _) /\ suffix)) =
      breakCap input (match sep)
```

then

```purescript
input == prefix <> infix <> suffix
```
#### Example

Find the first pattern match and break the input string on the pattern.

```purescript
breakCap "hay needle hay" (string "needle")
```

Result:

```purescript
Just ("hay " /\ "needle" /\ " hay")
```

#### Example

Find the first pattern match, capture the matched text and the parsed result.

```purescript
breakCap "abc 123 def" (match intDecimal)
```

Result:

```purescript
Just ("abc " /\ ("123" /\ 123) /\ " def")
```

#### `breakCapT`

``` purescript
breakCapT :: forall m a. Monad m => MonadRec m => String -> ParserT String m a -> m (Maybe (T3 String a String))
```

Monad transformer version of `breakCap`. The `sep` parser will run
in the monad context.

#### `splitCap`

``` purescript
splitCap :: forall a. String -> Parser String a -> NonEmptyList (Either String a)
```

#### Split on and capture all patterns

Find all occurences of the pattern parser `sep`, split the
input `String`, capture all the matched patterns and the splits.

This function can be used instead of
[Data.String.Common.split](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String.Common#v:split)
or
[Data.String.Regex.split](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String.Regex#v:split)
or
[Data.String.Regex.match](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String.Regex#v:match)
or
[Data.String.Regex.search](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String.Regex#v:search).

The input string will be split on every leftmost non-overlapping occurence
of the pattern `sep`. The output list will contain
the parsed result of input string sections which match the `sep` pattern
in `Right a`, and non-matching sections in `Left String`.

#### Access the matched section of text

To capture the matched strings combine the pattern
parser `sep` with the `match` combinator.

With the matched strings, we can reconstruct the input string.
For all `input`, `sep`, if

```purescript
let output = splitCap input (match sep)
```

then

```purescript
input == fold (either identity fst <$> output)
```

#### Example

Split the input string on all `Int` pattern matches.

```purescript
splitCap "hay 1 straw 2 hay" intDecimal
```

Result:

```
[Left "hay ", Right 1, Left " straw ", Right 2, Left " hay"]
```

#### Example

Find the beginning positions of all pattern matches in the input.

```purescript
catMaybes $ hush <$> splitCap ".𝝺...\n...𝝺." (position <* string "𝝺")
```

Result:

```purescript
[ Position {index: 1, line: 1, column: 2 }
, Position { index: 9, line: 2, column: 4 }
]
```

#### Example

Find groups of balanced nested parentheses. This pattern is an example of
a “context-free” grammar, a pattern that
[can't be expressed by a regular expression](https://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags/1732454#1732454).
We can express the pattern with a recursive parser.

```purescript
balancedParens :: Parser String Unit
balancedParens = do
  void $ char '('
  void $ manyTill (balancedParens <|> void anyCodePoint) (char ')')

rmap fst <$> splitCap "((🌼)) (()())" (match balancedParens)
```

Result:

```purescript
[Right "((🌼))", Left " ", Right "(()())"]
```

#### `splitCapT`

``` purescript
splitCapT :: forall m a. Monad m => MonadRec m => String -> ParserT String m a -> m (NonEmptyList (Either String a))
```

Monad transformer version of `splitCap`. The `sep` parser will run in the
monad context.

#### Example

Count the pattern matches.

Parse in a `State` monad to remember state in the parser. This
stateful `letterCount` parser counts
the number of pattern matches which occur in the input, and also
tags each match with its index.


```purescript
letterCount :: ParserT String (State Int) (Tuple Char Int)
letterCount = do
  x <- letter
  i <- modify (_+1)
  pure (x /\ i)

flip runState 0 $ splitCapT "A B" letterCount
```

Result:

```purescript
[Right ('A' /\ 1), Left " ", Right ('B' /\ 2)] /\ 2
```

#### `replace`

``` purescript
replace :: String -> Parser String String -> String
```


#### Find-and-replace

Also called “match-and-substitute”. Find all
of the leftmost non-overlapping sections of the input string which match
the pattern parser `sep`, and
replace them with the result of the parser.
The `sep` parser must return a result of type `String` for the replacement.

This function can be used instead of
[Data.String.replaceAll](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String#v:replaceAll)
or
[Data.String.Regex.replace'](https://pursuit.purescript.org/packages/purescript-strings/docs/Data.String.Regex#v:replace').

#### Access the matched section of the input string

To get access to the matched string for calculating the replacement,
combine the pattern parser `sep`
with the `match` combinator.
This allows us to write a `sep` parser which can choose to not
replace the match and just leave it as it is.

So, for all `sep`:

```purescript
replace input (fst <$> match sep) == input
```

#### Example

Find and uppercase the `"needle"` pattern.

```purescript
replace "hay needle hay" (toUpper <$> string "needle")
```

Result:

```purescript
"hay NEEDLE hay"
```

#### Example

Find integers and double them.

```purescript
replace "1 6 21 107" (show <$> (_*2) <$> intDecimal)
```

Result:

```purescript
"2 12 42 214"
```

#### `replaceT`

``` purescript
replaceT :: forall m. Monad m => MonadRec m => String -> ParserT String m String -> m String
```

Monad transformer version of `replace`.

#### Example

Find an environment variable in curly braces and replace it with its value
from the environment.
We can read from the environment with `lookupEnv` because `replaceT` is
running the `sep` parser in `Effect`.

```purescript
replaceT "◀ {HOME} ▶" do
  _ <- string "{"
  Tuple variable _ <- anyTill (string "}")
  lift (lookupEnv variable) >>= maybe empty pure
```

Result:

```purescript
"◀ /home/jbrock ▶"
```

[![Perl Problems](https://imgs.xkcd.com/comics/perl_problems.png)](https://xkcd.com/1171/)


