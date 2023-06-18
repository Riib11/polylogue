## Module Parsing.Indent

This module is a port of the Haskell
[__Text.Parsec.Indent__](https://hackage.haskell.org/package/indents-0.3.3/docs/Text-Parsec-Indent.html)
module from 2016-05-07.

A module to construct indentation aware parsers. Many programming
language have indentation based syntax rules e.g. python and Haskell.
This module exports combinators to create such parsers.

The input source can be thought of as a list of tokens. Abstractly
each token occurs at a line and a column and has a width. The column
number of a token measures is indentation. If t1 and t2 are two tokens
then we say that indentation of t1 is more than t2 if the column
number of occurrence of t1 is greater than that of t2.

Currently this module supports two kind of indentation based syntactic
structures which we now describe:

- **Block**

  A block of indentation /c/ is a sequence of tokens with
  indentation at least /c/.  Examples for a block is a where clause of
  Haskell with no explicit braces.

- **Line fold**

  A line fold starting at line /l/ and indentation /c/ is a
  sequence of tokens that start at line /l/ and possibly continue to
  subsequent lines as long as the indentation is greater than /c/. Such
  a sequence of lines need to be /folded/ to a single line. An example
  is MIME headers. Line folding based binding separation is used in
  Haskell as well.

#### `IndentParser`

``` purescript
type IndentParser s a = ParserT s (State Position) a
```

Indentation sensitive parser type. Usually @ m @ will
be @ Identity @ as with any @ ParserT @

#### `runIndent`

``` purescript
runIndent :: forall a. State Position a -> a
```

Run the result of an indentation sensitive parse

#### `withBlock`

``` purescript
withBlock :: forall a b c s. (a -> List b -> c) -> IndentParser s a -> IndentParser s b -> IndentParser s c
```

`withBlock f a p` parses `a`
followed by an indented block of `p`
combining them with `f`.

#### `withBlock'`

``` purescript
withBlock' :: forall a b s. IndentParser s a -> IndentParser s b -> IndentParser s (List b)
```

Like 'withBlock', but throws away initial parse result

#### `block`

``` purescript
block :: forall s a. IndentParser s a -> IndentParser s (List a)
```

Parses a block of lines at the same indentation level , empty Blocks allowed

#### `block1`

``` purescript
block1 :: forall s a. IndentParser s a -> IndentParser s (List a)
```

Parses a block of lines at the same indentation level

#### `indented`

``` purescript
indented :: forall s. IndentParser s Unit
```

Parses only when indented past the level of the reference

#### `indented'`

``` purescript
indented' :: forall s. IndentParser s Unit
```

Same as `indented`, but does not change internal state

#### `sameLine`

``` purescript
sameLine :: forall s. IndentParser s Unit
```

Parses only on the same line as the reference

#### `sameOrIndented`

``` purescript
sameOrIndented :: forall s. IndentParser s Unit
```

Parses only when indented past the level of the reference or on the same line

#### `checkIndent`

``` purescript
checkIndent :: forall s. IndentParser s Unit
```

Ensures the current indentation level matches that of the reference

#### `withPos`

``` purescript
withPos :: forall s a. IndentParser s a -> IndentParser s a
```

Parses using the current location for indentation reference

#### `indentAp`

``` purescript
indentAp :: forall s a b. IndentParser s (a -> b) -> IndentParser s a -> IndentParser s b
```

`<+/>` is to indentation sensitive parsers what `ap` is to monads

#### `(<+/>)`

``` purescript
infixl 9 indentAp as <+/>
```

#### `indentNoAp`

``` purescript
indentNoAp :: forall s a b. IndentParser s a -> IndentParser s b -> IndentParser s a
```

Like `<+/>` but doesn't apply the function to the parsed value

#### `(<-/>)`

``` purescript
infixl 10 indentNoAp as <-/>
```

#### `indentMany`

``` purescript
indentMany :: forall s a b. IndentParser s (List a -> b) -> IndentParser s a -> IndentParser s b
```

Like `<+/>` but applies the second parser many times

#### `(<*/>)`

``` purescript
infixl 11 indentMany as <*/>
```

#### `indentOp`

``` purescript
indentOp :: forall s a b. IndentParser s (a -> b) -> Optional s a -> IndentParser s b
```

Like `<+/>` but applies the second parser optionally using the `Optional` datatype

#### `(<?/>)`

``` purescript
infixl 12 indentOp as <?/>
```

#### `indentBrackets`

``` purescript
indentBrackets :: forall a. IndentParser String a -> IndentParser String a
```

Parses with surrounding brackets

#### `indentAngles`

``` purescript
indentAngles :: forall a. IndentParser String a -> IndentParser String a
```

Parses with surrounding angle brackets

#### `indentBraces`

``` purescript
indentBraces :: forall a. IndentParser String a -> IndentParser String a
```

Parses with surrounding braces

#### `indentParens`

``` purescript
indentParens :: forall a. IndentParser String a -> IndentParser String a
```

Parses with surrounding parentheses

#### `Optional`

``` purescript
data Optional s a
  = Opt a (IndentParser s a)
```

Data type used to optional parsing


