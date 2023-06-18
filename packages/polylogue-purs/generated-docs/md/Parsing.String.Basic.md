## Module Parsing.String.Basic

Basic `String` parsers derived from primitive `String` parsers.

#### unicode dependency

Some of the parsers in this module depend on the
[__unicode__](https://pursuit.purescript.org/packages/purescript-unicode)
package.
The __unicode__ package is large; about half a megabyte unminified.
If code which depends on __parsing__ is “tree-shaken”
“dead-code-eliminated,” then
all of the __unicode__ package will be eliminated.

The __unicode__-dependent parsers in this module will call functions
which use large lookup tables from the __unicode__ package.
Using any of these __unicode__-dependent parsers
may result in a minified, dead-code-eliminated bundle size increase
of over 100 kilobytes.

#### `digit`

``` purescript
digit :: forall m. ParserT String m Char
```

Parse a digit.  Matches any char that satisfies `Data.CodePoint.Unicode.isDecDigit`.

#### `hexDigit`

``` purescript
hexDigit :: forall m. ParserT String m Char
```

Parse a hex digit.  Matches any char that satisfies `Data.CodePoint.Unicode.isHexDigit`.

#### `octDigit`

``` purescript
octDigit :: forall m. ParserT String m Char
```

Parse an octal digit.  Matches any char that satisfies `Data.CodePoint.Unicode.isOctDigit`.

#### `letter`

``` purescript
letter :: forall m. ParserT String m Char
```

Parse an alphabetical character.  Matches any char that satisfies `Data.CodePoint.Unicode.isAlpha`.

#### `space`

``` purescript
space :: forall m. ParserT String m Char
```

Parse a space character.  Matches any char that satisfies `Data.CodePoint.Unicode.isSpace`.

#### `lower`

``` purescript
lower :: forall m. ParserT String m Char
```

Parse a lowercase letter.  Matches any char that satisfies `Data.CodePoint.Unicode.isLower`.

#### `upper`

``` purescript
upper :: forall m. ParserT String m Char
```

Parse an uppercase letter.  Matches any char that satisfies `Data.CodePoint.Unicode.isUpper`.

#### `alphaNum`

``` purescript
alphaNum :: forall m. ParserT String m Char
```

Parse an alphabetical or numerical character.
Matches any char that satisfies `Data.CodePoint.Unicode.isAlphaNum`.

#### `intDecimal`

``` purescript
intDecimal :: forall m. ParserT String m Int
```

Parser based on the __Data.Int.fromString__ function.

This should be the inverse of `show :: Int -> String`.

Examples of strings which can be parsed by this parser:
* `"3"`
* `"-3"`
* `"+300"`

#### `number`

``` purescript
number :: forall m. ParserT String m Number
```

Parser based on the __Data.Number.fromString__ function.

This should be the inverse of `show :: Number -> String`.

Examples of strings which can be parsed by this parser:
* `"3"`
* `"3.0"`
* `".3"`
* `"-0.3"`
* `"+0.3"`
* `"-3e-1"`
* `"-3.0E-1.0"`
* `"NaN"`
* `"-Infinity"`

#### `takeWhile`

``` purescript
takeWhile :: forall m. (CodePoint -> Boolean) -> ParserT String m String
```

Take the longest `String` for which the characters satisfy the
predicate.

See [__`Data.CodePoint.Unicode`__](https://pursuit.purescript.org/packages/purescript-unicode/docs/Data.CodePoint.Unicode)
for useful predicates.

Example:

```
runParser "Tackling the Awkward Squad" do
  takeWhile Data.CodePoint.Unicode.isLetter
```
---
```
Right "Tackling"
```

You should prefer `takeWhile isLetter` to
`fromCharArray <$> Data.Array.many letter`.

#### `takeWhile1`

``` purescript
takeWhile1 :: forall m. (CodePoint -> Boolean) -> ParserT String m String
```

Take the longest `String` for which the characters satisfy the
predicate. Require at least 1 character. You should supply an
expectation description for the error
message for when the predicate fails on the first character.

See [__`Data.CodePoint.Unicode`__](https://pursuit.purescript.org/packages/purescript-unicode/docs/Data.CodePoint.Unicode)
for useful predicates.

Example:

```
runParser "Tackling the Awkward Squad" do
  takeWhile1 Data.CodePoint.Unicode.isLetter <?> "a letter"
```
---
```
Right "Tackling"
```

#### `whiteSpace`

``` purescript
whiteSpace :: forall m. ParserT String m String
```

Match zero or more whitespace characters satisfying
`Data.CodePoint.Unicode.isSpace`.

Always succeeds. Will consume only when matched whitespace string
is non-empty.

#### `skipSpaces`

``` purescript
skipSpaces :: forall m. ParserT String m Unit
```

Skip whitespace characters satisfying `Data.CodePoint.Unicode.isSpace`
and throw them away.

Always succeeds. Will only consume when some characters are skipped.

#### `oneOf`

``` purescript
oneOf :: forall m. Array Char -> ParserT String m Char
```

Match one of the BMP `Char`s in the array.

#### `oneOfCodePoints`

``` purescript
oneOfCodePoints :: forall m. Array CodePoint -> ParserT String m CodePoint
```

Match one of the Unicode characters in the array.

#### `noneOf`

``` purescript
noneOf :: forall m. Array Char -> ParserT String m Char
```

Match any BMP `Char` not in the array.

#### `noneOfCodePoints`

``` purescript
noneOfCodePoints :: forall m. Array CodePoint -> ParserT String m CodePoint
```

Match any Unicode character not in the array.


