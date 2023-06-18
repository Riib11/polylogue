## Module Parsing.Token

Primitive parsers for an input stream of type
`(`[__List__](https://pursuit.purescript.org/packages/purescript-lists/docs/Data.List.Types#t:List) `a)`
for working with streams of tokens.

This module is a port of the Haskell
[__Text.Parsec.Token__](https://hackage.haskell.org/package/parsec/docs/Text-Parsec-Token.html)
module.

#### `token`

``` purescript
token :: forall m a. (a -> Position) -> ParserT (List a) m a
```

A parser which returns the first token in the stream.

#### `when`

``` purescript
when :: forall m a. (a -> Position) -> (a -> Boolean) -> ParserT (List a) m a
```

A parser which matches any token satisfying the predicate.

#### `match`

``` purescript
match :: forall a m. Eq a => (a -> Position) -> a -> ParserT (List a) m a
```

Match the specified token at the head of the stream.

#### `eof`

``` purescript
eof :: forall a m. ParserT (List a) m Unit
```

Match the “end-of-file,” the end of the input stream.

#### `LanguageDef`

``` purescript
type LanguageDef = GenLanguageDef String Identity
```

#### `GenLanguageDef`

``` purescript
newtype GenLanguageDef s m
  = LanguageDef { caseSensitive :: Boolean, commentEnd :: String, commentLine :: String, commentStart :: String, identLetter :: ParserT s m Char, identStart :: ParserT s m Char, nestedComments :: Boolean, opLetter :: ParserT s m Char, opStart :: ParserT s m Char, reservedNames :: Array String, reservedOpNames :: Array String }
```

The `GenLanguageDef` type is a record that contains all parameterizable
features of the "Text.Parsec.Token" module. The module `Text.Parsec.Language`
contains some default definitions.

#### `unGenLanguageDef`

``` purescript
unGenLanguageDef :: forall s m. GenLanguageDef s m -> { caseSensitive :: Boolean, commentEnd :: String, commentLine :: String, commentStart :: String, identLetter :: ParserT s m Char, identStart :: ParserT s m Char, nestedComments :: Boolean, opLetter :: ParserT s m Char, opStart :: ParserT s m Char, reservedNames :: Array String, reservedOpNames :: Array String }
```

#### `TokenParser`

``` purescript
type TokenParser = GenTokenParser String Identity
```

#### `GenTokenParser`

``` purescript
type GenTokenParser s m = { angles :: forall a. ParserT s m a -> ParserT s m a, braces :: forall a. ParserT s m a -> ParserT s m a, brackets :: forall a. ParserT s m a -> ParserT s m a, charLiteral :: ParserT s m Char, colon :: ParserT s m String, comma :: ParserT s m String, commaSep :: forall a. ParserT s m a -> ParserT s m (List a), commaSep1 :: forall a. ParserT s m a -> ParserT s m (NonEmptyList a), decimal :: ParserT s m Int, dot :: ParserT s m String, float :: ParserT s m Number, hexadecimal :: ParserT s m Int, identifier :: ParserT s m String, integer :: ParserT s m Int, lexeme :: forall a. ParserT s m a -> ParserT s m a, natural :: ParserT s m Int, naturalOrFloat :: ParserT s m (Either Int Number), octal :: ParserT s m Int, operator :: ParserT s m String, parens :: forall a. ParserT s m a -> ParserT s m a, reserved :: String -> ParserT s m Unit, reservedOp :: String -> ParserT s m Unit, semi :: ParserT s m String, semiSep :: forall a. ParserT s m a -> ParserT s m (List a), semiSep1 :: forall a. ParserT s m a -> ParserT s m (NonEmptyList a), stringLiteral :: ParserT s m String, symbol :: String -> ParserT s m String, whiteSpace :: ParserT s m Unit }
```

The type of the record that holds lexical parsers that work on
`s` streams over a monad `m`.

#### `makeTokenParser`

``` purescript
makeTokenParser :: forall m. GenLanguageDef String m -> GenTokenParser String m
```

The expression `makeTokenParser language` creates a `GenTokenParser`
record that contains lexical parsers that are
defined using the definitions in the `language` record.

The use of this function is quite stylized - one imports the
appropiate language definition and selects the lexical parsers that
are needed from the resulting `GenTokenParser`.

```purescript
module Main where

import Parsing.Language (haskellDef)
import Parsing.Token (makeTokenParser)

-- The parser
expr = parens expr
   <|> identifier
   <|> ...


-- The lexer
tokenParser = makeTokenParser haskellDef
parens      = tokenParser.parens
braces      = tokenParser.braces
identifier  = tokenParser.identifier
reserved    = tokenParser.reserved
...
```


### Re-exported from Parsing.String.Basic:

#### `upper`

``` purescript
upper :: forall m. ParserT String m Char
```

Parse an uppercase letter.  Matches any char that satisfies `Data.CodePoint.Unicode.isUpper`.

#### `space`

``` purescript
space :: forall m. ParserT String m Char
```

Parse a space character.  Matches any char that satisfies `Data.CodePoint.Unicode.isSpace`.

#### `oneOf`

``` purescript
oneOf :: forall m. Array Char -> ParserT String m Char
```

Match one of the BMP `Char`s in the array.

#### `octDigit`

``` purescript
octDigit :: forall m. ParserT String m Char
```

Parse an octal digit.  Matches any char that satisfies `Data.CodePoint.Unicode.isOctDigit`.

#### `noneOf`

``` purescript
noneOf :: forall m. Array Char -> ParserT String m Char
```

Match any BMP `Char` not in the array.

#### `letter`

``` purescript
letter :: forall m. ParserT String m Char
```

Parse an alphabetical character.  Matches any char that satisfies `Data.CodePoint.Unicode.isAlpha`.

#### `hexDigit`

``` purescript
hexDigit :: forall m. ParserT String m Char
```

Parse a hex digit.  Matches any char that satisfies `Data.CodePoint.Unicode.isHexDigit`.

#### `digit`

``` purescript
digit :: forall m. ParserT String m Char
```

Parse a digit.  Matches any char that satisfies `Data.CodePoint.Unicode.isDecDigit`.

#### `alphaNum`

``` purescript
alphaNum :: forall m. ParserT String m Char
```

Parse an alphabetical or numerical character.
Matches any char that satisfies `Data.CodePoint.Unicode.isAlphaNum`.

