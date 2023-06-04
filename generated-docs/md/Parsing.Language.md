## Module Parsing.Language

This module is a port of the Haskell
[__Text.Parsec.Language__](https://hackage.haskell.org/package/parsec/docs/Text-Parsec-Language.html)
module.

#### `haskellDef`

``` purescript
haskellDef :: LanguageDef
```

The language definition for the Haskell language.

#### `haskell`

``` purescript
haskell :: TokenParser
```

A lexer for the haskell language.

#### `emptyDef`

``` purescript
emptyDef :: LanguageDef
```

This is the most minimal token definition. It is recommended to use
this definition as the basis for other definitions. `emptyDef` has
no reserved names or operators, is case sensitive and doesn't accept
comments, identifiers or operators.

#### `haskellStyle`

``` purescript
haskellStyle :: LanguageDef
```

This is a minimal token definition for Haskell style languages. It
defines the style of comments, valid identifiers and case
sensitivity. It does not define any reserved words or operators.

#### `javaStyle`

``` purescript
javaStyle :: LanguageDef
```

This is a minimal token definition for Java style languages. It
defines the style of comments, valid identifiers and case
sensitivity. It does not define any reserved words or operators.


