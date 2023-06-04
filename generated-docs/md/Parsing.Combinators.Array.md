## Module Parsing.Combinators.Array

These combinators will produce `Array`s, as opposed to the other combinators
of the same names in the __Parsing.Combinators__ module
which mostly produce `List`s. These `Array` combinators will run in a bit
less time (*~85% runtime*) than the similar `List` combinators, and they will run in a
lot less time (*~10% runtime*) than the similar combinators in __Data.Array__.

If there is some other combinator which returns
a `List` but we want an `Array`, and there is no `Array` version of the
combinator in this module, then we can rely on the
[__`Data.Array.fromFoldable`__](https://pursuit.purescript.org/packages/purescript-arrays/docs/Data.Array#v:fromFoldable)
function for a pretty fast transformation from `List` to `Array`.

#### `many`

``` purescript
many :: forall s m a. ParserT s m a -> ParserT s m (Array a)
```

Match the phrase `p` as many times as possible.

If `p` never consumes input when it
fails then `many p` will always succeed,
but may return an empty array.

#### `many1`

``` purescript
many1 :: forall s m a. ParserT s m a -> ParserT s m (NonEmptyArray a)
```

Match the phrase `p` as many times as possible, at least once.

#### `manyTill_`

``` purescript
manyTill_ :: forall s a m e. ParserT s m a -> ParserT s m e -> ParserT s m (Tuple (Array a) e)
```

Parse many phrases until the terminator phrase matches.
Returns the list of phrases and the terminator phrase.

#### `manyIndex`

``` purescript
manyIndex :: forall s m a. Int -> Int -> (Int -> ParserT s m a) -> ParserT s m (Tuple Int (Array a))
```

Parse the phrase as many times as possible, at least *N* times, but no
more than *M* times.
If the phrase can’t parse as least *N* times then the whole
parser fails. If the phrase parses successfully *M* times then stop.
The current phrase index, starting at *0*, is passed to the phrase.

Returns the array of parse results and the number of results.

`manyIndex n n (\_ -> p)` is equivalent to `replicateA n p`.


