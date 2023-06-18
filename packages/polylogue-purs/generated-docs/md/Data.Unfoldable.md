## Module Data.Unfoldable

This module provides a type class for _unfoldable functors_, i.e.
functors which support an `unfoldr` operation.

This allows us to unify various operations on arrays, lists,
sequences, etc.

#### `Unfoldable`

``` purescript
class (Unfoldable1 t) <= Unfoldable t  where
  unfoldr :: forall a b. (b -> Maybe (Tuple a b)) -> b -> t a
```

This class identifies (possibly empty) data structures which can be
_unfolded_.

The generating function `f` in `unfoldr f` is understood as follows:

- If `f b` is `Nothing`, then `unfoldr f b` should be empty.
- If `f b` is `Just (Tuple a b1)`, then `unfoldr f b` should consist of `a`
  appended to the result of `unfoldr f b1`.

Note that it is not possible to give `Unfoldable` instances to types which
represent structures which are guaranteed to be non-empty, such as
`NonEmptyArray`: consider what `unfoldr (const Nothing)` should produce.
Structures which are guaranteed to be non-empty can instead be given
`Unfoldable1` instances.

##### Instances
``` purescript
Unfoldable Array
Unfoldable Maybe
```

#### `replicate`

``` purescript
replicate :: forall f a. Unfoldable f => Int -> a -> f a
```

Replicate a value some natural number of times.
For example:

``` purescript
replicate 2 "foo" == (["foo", "foo"] :: Array String)
```

#### `replicateA`

``` purescript
replicateA :: forall m f a. Applicative m => Unfoldable f => Traversable f => Int -> m a -> m (f a)
```

Perform an Applicative action `n` times, and accumulate all the results.

``` purescript
> replicateA 5 (randomInt 1 10) :: Effect (Array Int)
[1,3,2,7,5]
```

#### `none`

``` purescript
none :: forall f a. Unfoldable f => f a
```

The container with no elements - unfolded with zero iterations.
For example:

``` purescript
none == ([] :: Array Unit)
```

#### `fromMaybe`

``` purescript
fromMaybe :: forall f a. Unfoldable f => Maybe a -> f a
```

Convert a Maybe to any Unfoldable, such as lists or arrays.

``` purescript
fromMaybe (Nothing :: Maybe Int) == []
fromMaybe (Just 1) == [1]
```


### Re-exported from Data.Unfoldable1:

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

#### `singleton`

``` purescript
singleton :: forall f a. Unfoldable1 f => a -> f a
```

Contain a single value. For example:

``` purescript
singleton "foo" == (NEL.singleton "foo" :: NEL.NonEmptyList String)
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

