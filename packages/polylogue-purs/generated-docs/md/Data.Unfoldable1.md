## Module Data.Unfoldable1

#### `Unfoldable1`

``` purescript
class Unfoldable1 t  where
  unfoldr1 :: forall a b. (b -> Tuple a (Maybe b)) -> b -> t a
```

This class identifies data structures which can be _unfolded_.

The generating function `f` in `unfoldr1 f` corresponds to the `uncons`
operation of a non-empty list or array; it always returns a value, and
then optionally a value to continue unfolding from.

Note that, in order to provide an `Unfoldable1 t` instance, `t` need not
be a type which is guaranteed to be non-empty. For example, the fact that
lists can be empty does not prevent us from providing an
`Unfoldable1 List` instance. However, the result of `unfoldr1` should
always be non-empty.

Every type which has an `Unfoldable` instance can be given an
`Unfoldable1` instance (and, in fact, is required to, because
`Unfoldable1` is a superclass of `Unfoldable`). However, there are types
which have `Unfoldable1` instances but cannot have `Unfoldable` instances.
In particular, types which are guaranteed to be non-empty, such as
`NonEmptyList`, cannot be given `Unfoldable` instances.

The utility of this class, then, is that it provides an `Unfoldable`-like
interface while still permitting instances for guaranteed-non-empty types
like `NonEmptyList`.

##### Instances
``` purescript
Unfoldable1 Array
Unfoldable1 Maybe
```

#### `replicate1`

``` purescript
replicate1 :: forall f a. Unfoldable1 f => Int -> a -> f a
```

Replicate a value `n` times. At least one value will be produced, so values
`n` less than 1 will be treated as 1.

``` purescript
replicate1 2 "foo" == (NEL.cons "foo" (NEL.singleton "foo") :: NEL.NonEmptyList String)
replicate1 0 "foo" == (NEL.singleton "foo" :: NEL.NonEmptyList String)
```

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

#### `singleton`

``` purescript
singleton :: forall f a. Unfoldable1 f => a -> f a
```

Contain a single value. For example:

``` purescript
singleton "foo" == (NEL.singleton "foo" :: NEL.NonEmptyList String)
```

#### `range`

``` purescript
range :: forall f. Unfoldable1 f => Int -> Int -> f Int
```

Create an `Unfoldable1` containing a range of values, including both
endpoints.

``` purescript
range 0 0 == (NEL.singleton 0 :: NEL.NonEmptyList Int)
range 1 2 == (NEL.cons 1 (NEL.singleton 2) :: NEL.NonEmptyList Int)
range 2 0 == (NEL.cons 2 (NEL.cons 1 (NEL.singleton 0)) :: NEL.NonEmptyList Int)
```

#### `iterateN`

``` purescript
iterateN :: forall f a. Unfoldable1 f => Int -> (a -> a) -> a -> f a
```

Create an `Unfoldable1` by repeated application of a function to a seed value.
For example:

``` purescript
(iterateN 5 (_ + 1) 0 :: Array Int) == [0, 1, 2, 3, 4]
(iterateN 5 (_ + 1) 0 :: NonEmptyArray Int) == NonEmptyArray [0, 1, 2, 3, 4]

(iterateN 0 (_ + 1) 0 :: Array Int) == [0]
(iterateN 0 (_ + 1) 0 :: NonEmptyArray Int) == NonEmptyArray [0]
```


