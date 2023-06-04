## Module Control.Apply

#### `Apply`

``` purescript
class (Functor f) <= Apply f  where
  apply :: forall a b. f (a -> b) -> f a -> f b
```

The `Apply` class provides the `(<*>)` which is used to apply a function
to an argument under a type constructor.

`Apply` can be used to lift functions of two or more arguments to work on
values wrapped with the type constructor `f`. It might also be understood
in terms of the `lift2` function:

```purescript
lift2 :: forall f a b c. Apply f => (a -> b -> c) -> f a -> f b -> f c
lift2 f a b = f <$> a <*> b
```

`(<*>)` is recovered from `lift2` as `lift2 ($)`. That is, `(<*>)` lifts
the function application operator `($)` to arguments wrapped with the
type constructor `f`.

Put differently...
```
foo =
  functionTakingNArguments <$> computationProducingArg1
                           <*> computationProducingArg2
                           <*> ...
                           <*> computationProducingArgN
```

Instances must satisfy the following law in addition to the `Functor`
laws:

- Associative composition: `(<<<) <$> f <*> g <*> h = f <*> (g <*> h)`

Formally, `Apply` represents a strong lax semi-monoidal endofunctor.

##### Instances
``` purescript
Apply (Function r)
Apply Array
Apply Proxy
```

#### `(<*>)`

``` purescript
infixl 4 apply as <*>
```

#### `applyFirst`

``` purescript
applyFirst :: forall a b f. Apply f => f a -> f b -> f a
```

Combine two effectful actions, keeping only the result of the first.

#### `(<*)`

``` purescript
infixl 4 applyFirst as <*
```

#### `applySecond`

``` purescript
applySecond :: forall a b f. Apply f => f a -> f b -> f b
```

Combine two effectful actions, keeping only the result of the second.

#### `(*>)`

``` purescript
infixl 4 applySecond as *>
```

#### `lift2`

``` purescript
lift2 :: forall a b c f. Apply f => (a -> b -> c) -> f a -> f b -> f c
```

Lift a function of two arguments to a function which accepts and returns
values wrapped with the type constructor `f`.

```purescript
lift2 add (Just 1) (Just 2) == Just 3
lift2 add Nothing (Just 2) == Nothing
```


#### `lift3`

``` purescript
lift3 :: forall a b c d f. Apply f => (a -> b -> c -> d) -> f a -> f b -> f c -> f d
```

Lift a function of three arguments to a function which accepts and returns
values wrapped with the type constructor `f`.

#### `lift4`

``` purescript
lift4 :: forall a b c d e f. Apply f => (a -> b -> c -> d -> e) -> f a -> f b -> f c -> f d -> f e
```

Lift a function of four arguments to a function which accepts and returns
values wrapped with the type constructor `f`.

#### `lift5`

``` purescript
lift5 :: forall a b c d e f g. Apply f => (a -> b -> c -> d -> e -> g) -> f a -> f b -> f c -> f d -> f e -> f g
```

Lift a function of five arguments to a function which accepts and returns
values wrapped with the type constructor `f`.


### Re-exported from Data.Functor:

#### `Functor`

``` purescript
class Functor f  where
  map :: forall a b. (a -> b) -> f a -> f b
```

A `Functor` is a type constructor which supports a mapping operation
`map`.

`map` can be used to turn functions `a -> b` into functions
`f a -> f b` whose argument and return types use the type constructor `f`
to represent some computational context.

Instances must satisfy the following laws:

- Identity: `map identity = identity`
- Composition: `map (f <<< g) = map f <<< map g`

##### Instances
``` purescript
Functor (Function r)
Functor Array
Functor Proxy
```

#### `void`

``` purescript
void :: forall f a. Functor f => f a -> f Unit
```

The `void` function is used to ignore the type wrapped by a
[`Functor`](#functor), replacing it with `Unit` and keeping only the type
information provided by the type constructor itself.

`void` is often useful when using `do` notation to change the return type
of a monadic computation:

```purescript
main = forE 1 10 \n -> void do
  print n
  print (n * n)
```

#### `(<$>)`

``` purescript
infixl 4 map as <$>
```

#### `(<$)`

``` purescript
infixl 4 voidRight as <$
```

#### `(<#>)`

``` purescript
infixl 1 mapFlipped as <#>
```

#### `($>)`

``` purescript
infixl 4 voidLeft as $>
```

