## Module Parsing.Combinators

A “parser combinator” is a function which takes some
parsers as arguments and returns a new parser.

## Combinators in other packages

Many variations of well-known monadic and applicative combinators used for parsing are
defined in other PureScript packages. We list some of them here.

If you use a combinator from some other package for parsing, keep in mind
this surprising truth about the __parsing__ package:
All other combinators used with this package will be stack-safe,
but usually the combinators with a `MonadRec` constraint will run faster.
So you should prefer `MonadRec` versions of combinators, but for reasons
of speed, not stack-safety.

### Data.Array

The `many` and `many1` combinators in the __Parsing.Combinators.Array__
module are faster.

* [Data.Array.many](https://pursuit.purescript.org/packages/purescript-arrays/docs/Data.Array#v:many)
* [Data.Array.some](https://pursuit.purescript.org/packages/purescript-arrays/docs/Data.Array#v:some)
* [Data.Array.NonEmpty.some](https://pursuit.purescript.org/packages/purescript-arrays/docs/Data.Array.NonEmpty#v:some)

### Data.List

The `many` and `many1` combinators in this package
are redeclarations of
the `manyRec` and `someRec` combinators in __Data.List__.

### Data.List.Lazy

* [Data.List.Lazy.many](https://pursuit.purescript.org/packages/purescript-lists/docs/Data.List.Lazy#v:many)
* [Data.List.Lazy.some](https://pursuit.purescript.org/packages/purescript-lists/docs/Data.List.Lazy#v:some)

## Combinators in this package

the __replicateA__ and __replicateM__ combinators are re-exported from
this module. `replicateA n p` or `replicateM n p`
will repeat parser `p` exactly `n` times. The `replicateA` combinator can
produce either an `Array` or a `List`.

#### `try`

``` purescript
try :: forall m s a. ParserT s m a -> ParserT s m a
```

If the parser fails then backtrack the input stream to the unconsumed state.

One use for this combinator is to ensure that the right parser of an
alternative will always be tried when the left parser fails.
```
>>> runParser "ac" ((char 'a' *> char 'b') <|> (char 'a' *> char 'c'))
Left (ParseError "Expected 'b'" (Position { line: 1, column: 2 }))
```
---
```
>>> runParser "ac" (try (char 'a' *> char 'b') <|> (char 'a' *> char 'c'))
Right 'c'
```

#### `tryRethrow`

``` purescript
tryRethrow :: forall m s a. ParserT s m a -> ParserT s m a
```

If the parser fails then backtrack the input stream to the unconsumed state.

Like `try`, but will reposition the error to the `try` point.

```
>>> runParser "ac" (try (char 'a' *> char 'b'))
Left (ParseError "Expected 'b'" (Position { index: 1, line: 1, column: 2 }))
```
---
```
>>> runParser "ac" (tryRethrow (char 'a' *> char 'b'))
Left (ParseError "Expected 'b'" (Position { index: 0, line: 1, column: 1 }))
```

#### `lookAhead`

``` purescript
lookAhead :: forall s a m. ParserT s m a -> ParserT s m a
```

Parse a phrase, without modifying the consumed state or stream position.

#### `choice`

``` purescript
choice :: forall f m s a. Foldable f => f (ParserT s m a) -> ParserT s m a
```

Parse one of a set of alternatives.

#### `between`

``` purescript
between :: forall m s a open close. ParserT s m open -> ParserT s m close -> ParserT s m a -> ParserT s m a
```

Wrap a parser with opening and closing markers.

For example:

```purescript
parens = between (string "(") (string ")")
```

#### `notFollowedBy`

``` purescript
notFollowedBy :: forall s a m. ParserT s m a -> ParserT s m Unit
```

Fail if the parser succeeds.

Will never consume input.

#### `option`

``` purescript
option :: forall m s a. a -> ParserT s m a -> ParserT s m a
```

Provide a default result in the case where a parser fails without consuming input.

#### `optionMaybe`

``` purescript
optionMaybe :: forall m s a. ParserT s m a -> ParserT s m (Maybe a)
```

pure `Nothing` in the case where a parser fails without consuming input.

#### `optional`

``` purescript
optional :: forall m s a. ParserT s m a -> ParserT s m Unit
```

Optionally parse something, failing quietly.

To optionally parse `p` and never fail: `optional (try p)`.

#### `many`

``` purescript
many :: forall s m a. ParserT s m a -> ParserT s m (List a)
```

Match the phrase `p` as many times as possible.

If `p` never consumes input when it
fails then `many p` will always succeed,
but may return an empty list.

#### `many1`

``` purescript
many1 :: forall m s a. ParserT s m a -> ParserT s m (NonEmptyList a)
```

Match the phrase `p` as many times as possible, at least once.

#### `manyTill`

``` purescript
manyTill :: forall s a m e. ParserT s m a -> ParserT s m e -> ParserT s m (List a)
```

Parse many phrases until the terminator phrase matches.

#### `manyTill_`

``` purescript
manyTill_ :: forall s a m e. ParserT s m a -> ParserT s m e -> ParserT s m (Tuple (List a) e)
```

Parse many phrases until the terminator phrase matches.
Returns the list of phrases and the terminator phrase.

#### Non-greedy repetition

Use the __manyTill_ __ combinator
to do non-greedy repetition of a pattern `p`, like we would in Regex
by writing `p*?`.
To repeat pattern `p` non-greedily, write
`manyTill_ p q` where `q` is the entire rest of the parser.

For example, this parse fails because `many` repeats the pattern `letter`
greedily.

```
runParser "aab" do
  a <- many letter
  b <- char 'b'
  pure (Tuple a b)
```
```
(ParseError "Expected 'b'" (Position { line: 1, column: 4 }))
```

To repeat pattern `letter` non-greedily, use `manyTill_`.

```
runParser "aab" do
  Tuple a b <- manyTill_ letter do
    char 'b'
  pure (Tuple a b)
```
```
(Tuple ('a' : 'a' : Nil) 'b')
```

#### `many1Till`

``` purescript
many1Till :: forall s a m e. ParserT s m a -> ParserT s m e -> ParserT s m (NonEmptyList a)
```

Parse at least one phrase until the terminator phrase matches.

#### `many1Till_`

``` purescript
many1Till_ :: forall s a m e. ParserT s m a -> ParserT s m e -> ParserT s m (Tuple (NonEmptyList a) e)
```

Parse many phrases until the terminator phrase matches, requiring at least one match.
Returns the list of phrases and the terminator phrase.

#### `manyIndex`

``` purescript
manyIndex :: forall s m a. Int -> Int -> (Int -> ParserT s m a) -> ParserT s m (Tuple Int (List a))
```

Parse the phrase as many times as possible, at least *N* times, but no
more than *M* times.
If the phrase can’t parse as least *N* times then the whole
parser fails. If the phrase parses successfully *M* times then stop.
The current phrase index, starting at *0*, is passed to the phrase.

Returns the list of parse results and the number of results.

`manyIndex n n (\_ -> p)` is equivalent to `replicateA n p`.

#### `skipMany`

``` purescript
skipMany :: forall s a m. ParserT s m a -> ParserT s m Unit
```

Skip many instances of a phrase.

#### `skipMany1`

``` purescript
skipMany1 :: forall s a m. ParserT s m a -> ParserT s m Unit
```

Skip at least one instance of a phrase.

#### `sepBy`

``` purescript
sepBy :: forall m s a sep. ParserT s m a -> ParserT s m sep -> ParserT s m (List a)
```

Parse phrases delimited by a separator.

For example:

```purescript
digit `sepBy` string ","
```

#### `sepBy1`

``` purescript
sepBy1 :: forall m s a sep. ParserT s m a -> ParserT s m sep -> ParserT s m (NonEmptyList a)
```

Parse phrases delimited by a separator, requiring at least one match.

#### `sepEndBy`

``` purescript
sepEndBy :: forall m s a sep. ParserT s m a -> ParserT s m sep -> ParserT s m (List a)
```

Parse phrases delimited and optionally terminated by a separator.

#### `sepEndBy1`

``` purescript
sepEndBy1 :: forall m s a sep. ParserT s m a -> ParserT s m sep -> ParserT s m (NonEmptyList a)
```

Parse phrases delimited and optionally terminated by a separator, requiring at least one match.

#### `endBy`

``` purescript
endBy :: forall m s a sep. ParserT s m a -> ParserT s m sep -> ParserT s m (List a)
```

Parse phrases delimited and terminated by a separator.

#### `endBy1`

``` purescript
endBy1 :: forall m s a sep. ParserT s m a -> ParserT s m sep -> ParserT s m (NonEmptyList a)
```

Parse phrases delimited and terminated by a separator, requiring at least one match.

#### `chainl`

``` purescript
chainl :: forall m s a. ParserT s m a -> ParserT s m (a -> a -> a) -> a -> ParserT s m a
```

`chainl p f` parses one or more occurrences of `p`, separated by operator `f`.

Returns a value
obtained by a left-associative application of the functions returned by
`f` to the values returned by `p`. This combinator can be used to
eliminate left-recursion in expression grammars.

For example:

```purescript
chainl digit (string "+" $> add) 0
```

#### `chainl1`

``` purescript
chainl1 :: forall m s a. ParserT s m a -> ParserT s m (a -> a -> a) -> ParserT s m a
```

`chainl` requiring at least one match.

#### `chainr`

``` purescript
chainr :: forall m s a. ParserT s m a -> ParserT s m (a -> a -> a) -> a -> ParserT s m a
```

`chainr p f` parses one or more occurrences of `p`, separated by operator `f`.

Returns a value
obtained by a right-associative application of the functions returned by
`f` to the values returned by `p`. This combinator can be used to
eliminate right-recursion in expression grammars.

For example:

```purescript
chainr digit (string "+" $> add) 0
```

#### `chainr1`

``` purescript
chainr1 :: forall m s a. ParserT s m a -> ParserT s m (a -> a -> a) -> ParserT s m a
```

`chainr` requiring at least one match.

#### `advance`

``` purescript
advance :: forall s m a. ParserT s m a -> ParserT s m a
```

If the parser succeeds without advancing the input stream position,
then force the parser to fail.

This combinator can be used to prevent infinite parser repetition.

Does not depend on or effect the `consumed` flag which indicates whether
we are committed to this parsing branch.

#### `withErrorMessage`

``` purescript
withErrorMessage :: forall m s a. ParserT s m a -> String -> ParserT s m a
```

Provide an error message in the case of failure.

#### `(<?>)`

``` purescript
infixl 4 withErrorMessage as <?>
```

#### `withLazyErrorMessage`

``` purescript
withLazyErrorMessage :: forall m s a. ParserT s m a -> (Unit -> String) -> ParserT s m a
```

Provide an error message in the case of failure, but lazily. This is handy
in cases where constructing the error message is expensive, so it's
preferable to defer it until an error actually happens.

```purescript
parseBang :: Parser Char
parseBang = char '!' <~?> \_ -> "a bang"
```

#### `(<~?>)`

``` purescript
infixl 4 withLazyErrorMessage as <~?>
```

#### `asErrorMessage`

``` purescript
asErrorMessage :: forall m s a. String -> ParserT s m a -> ParserT s m a
```

Flipped `(<?>)`.

#### `(<??>)`

``` purescript
infixr 3 asErrorMessage as <??>
```


### Re-exported from Control.Plus:

#### `alt`

``` purescript
alt :: forall f a. Alt f => f a -> f a -> f a
```

#### `empty`

``` purescript
empty :: forall f a. Plus f => f a
```

#### `(<|>)`

``` purescript
infixr 3 alt as <|>
```

### Re-exported from Data.List.Lazy:

#### `replicateM`

``` purescript
replicateM :: forall m a. Monad m => Int -> m a -> m (List a)
```

Perform a monadic action `n` times collecting all of the results.

### Re-exported from Data.Unfoldable:

#### `replicateA`

``` purescript
replicateA :: forall m f a. Applicative m => Unfoldable f => Traversable f => Int -> m a -> m (f a)
```

Perform an Applicative action `n` times, and accumulate all the results.

``` purescript
> replicateA 5 (randomInt 1 10) :: Effect (Array Int)
[1,3,2,7,5]
```

### Re-exported from Data.Unfoldable1:

#### `replicate1A`

``` purescript
replicate1A :: forall m f a. Apply m => Unfoldable1 f => Traversable1 f => Int -> m a -> m (f a)
```

Perform an `Apply` action `n` times (at least once, so values `n` less
than 1 will be treated as 1), and accumulate the results.

``` purescript
> replicate1A 2 (randomInt 1 10) :: Effect (NEL.NonEmptyList Int)
(NonEmptyList (NonEmpty 8 (2 : Nil)))
> replicate1A 0 (randomInt 1 10) :: Effect (NEL.NonEmptyList Int)
(NonEmptyList (NonEmpty 4 Nil))
```

