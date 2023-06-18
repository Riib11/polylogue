## Module Control.Extend

#### `Extend`

``` purescript
class (Functor w) <= Extend w  where
  extend :: forall b a. (w a -> b) -> w a -> w b
```

The `Extend` class defines the extension operator `(<<=)`
which extends a local context-dependent computation to
a global computation.

`Extend` is the dual of `Bind`, and `(<<=)` is the dual of
`(>>=)`.

Laws:

- Associativity: `extend f <<< extend g = extend (f <<< extend g)`

##### Instances
``` purescript
(Semigroup w) => Extend (Function w)
Extend Array
```

#### `(<<=)`

``` purescript
infixr 1 extend as <<=
```

#### `extendFlipped`

``` purescript
extendFlipped :: forall b a w. Extend w => w a -> (w a -> b) -> w b
```

A version of `extend` with its arguments flipped.

#### `(=>>)`

``` purescript
infixl 1 extendFlipped as =>>
```

#### `composeCoKleisli`

``` purescript
composeCoKleisli :: forall b a w c. Extend w => (w a -> b) -> (w b -> c) -> w a -> c
```

Forwards co-Kleisli composition.

#### `(=>=)`

``` purescript
infixr 1 composeCoKleisli as =>=
```

#### `composeCoKleisliFlipped`

``` purescript
composeCoKleisliFlipped :: forall b a w c. Extend w => (w b -> c) -> (w a -> b) -> w a -> c
```

Backwards co-Kleisli composition.

#### `(=<=)`

``` purescript
infixr 1 composeCoKleisliFlipped as =<=
```

#### `duplicate`

``` purescript
duplicate :: forall a w. Extend w => w a -> w (w a)
```

Duplicate a comonadic context.

`duplicate` is dual to `Control.Bind.join`.


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

