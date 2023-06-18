## Module Data.Either

#### `Either`

``` purescript
data Either a b
  = Left a
  | Right b
```

The `Either` type is used to represent a choice between two types of value.

A common use case for `Either` is error handling, where `Left` is used to
carry an error value and `Right` is used to carry a success value.

##### Instances
``` purescript
Functor (Either a)
Generic (Either a b) _
Invariant (Either a)
Apply (Either e)
Applicative (Either e)
Alt (Either e)
Bind (Either e)
Monad (Either e)
Extend (Either e)
(Show a, Show b) => Show (Either a b)
(Eq a, Eq b) => Eq (Either a b)
(Eq a) => Eq1 (Either a)
(Ord a, Ord b) => Ord (Either a b)
(Ord a) => Ord1 (Either a)
(Bounded a, Bounded b) => Bounded (Either a b)
(Semigroup b) => Semigroup (Either a b)
```

#### `either`

``` purescript
either :: forall a b c. (a -> c) -> (b -> c) -> Either a b -> c
```

Takes two functions and an `Either` value, if the value is a `Left` the
inner value is applied to the first function, if the value is a `Right`
the inner value is applied to the second function.

``` purescript
either f g (Left x) == f x
either f g (Right y) == g y
```

#### `choose`

``` purescript
choose :: forall m a b. Alt m => m a -> m b -> m (Either a b)
```

Combine two alternatives.

#### `isLeft`

``` purescript
isLeft :: forall a b. Either a b -> Boolean
```

Returns `true` when the `Either` value was constructed with `Left`.

#### `isRight`

``` purescript
isRight :: forall a b. Either a b -> Boolean
```

Returns `true` when the `Either` value was constructed with `Right`.

#### `fromLeft`

``` purescript
fromLeft :: forall a b. a -> Either a b -> a
```

A function that extracts the value from the `Left` data constructor.
The first argument is a default value, which will be returned in the
case where a `Right` is passed to `fromLeft`.

#### `fromLeft'`

``` purescript
fromLeft' :: forall a b. (Unit -> a) -> Either a b -> a
```

Similar to `fromLeft` but for use in cases where the default value may be
expensive to compute. As PureScript is not lazy, the standard `fromLeft`
has to evaluate the default value before returning the result,
whereas here the value is only computed when the `Either` is known
to be `Right`.

#### `fromRight`

``` purescript
fromRight :: forall a b. b -> Either a b -> b
```

A function that extracts the value from the `Right` data constructor.
The first argument is a default value, which will be returned in the
case where a `Left` is passed to `fromRight`.

#### `fromRight'`

``` purescript
fromRight' :: forall a b. (Unit -> b) -> Either a b -> b
```

Similar to `fromRight` but for use in cases where the default value may be
expensive to compute. As PureScript is not lazy, the standard `fromRight`
has to evaluate the default value before returning the result,
whereas here the value is only computed when the `Either` is known
to be `Left`.

#### `note`

``` purescript
note :: forall a b. a -> Maybe b -> Either a b
```

Takes a default and a `Maybe` value, if the value is a `Just`, turn it into
a `Right`, if the value is a `Nothing` use the provided default as a `Left`

```purescript
note "default" Nothing = Left "default"
note "default" (Just 1) = Right 1
```

#### `note'`

``` purescript
note' :: forall a b. (Unit -> a) -> Maybe b -> Either a b
```

Similar to `note`, but for use in cases where the default value may be
expensive to compute.

```purescript
note' (\_ -> "default") Nothing = Left "default"
note' (\_ -> "default") (Just 1) = Right 1
```

#### `hush`

``` purescript
hush :: forall a b. Either a b -> Maybe b
```

Turns an `Either` into a `Maybe`, by throwing potential `Left` values away and converting
them into `Nothing`. `Right` values get turned into `Just`s.

```purescript
hush (Left "ParseError") = Nothing
hush (Right 42) = Just 42
```

#### `blush`

``` purescript
blush :: forall a b. Either a b -> Maybe a
```

Turns an `Either` into a `Maybe`, by throwing potential `Right` values away and converting
them into `Nothing`. `Left` values get turned into `Just`s.

```purescript
blush (Left "ParseError") = Just "Parse Error"
blush (Right 42) = Nothing
```


