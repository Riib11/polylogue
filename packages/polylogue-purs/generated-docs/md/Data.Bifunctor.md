## Module Data.Bifunctor

#### `Bifunctor`

``` purescript
class Bifunctor f  where
  bimap :: forall a b c d. (a -> b) -> (c -> d) -> f a c -> f b d
```

A `Bifunctor` is a `Functor` from the pair category `(Type, Type)` to `Type`.

A type constructor with two type arguments can be made into a `Bifunctor` if
both of its type arguments are covariant.

The `bimap` function maps a pair of functions over the two type arguments
of the bifunctor.

Laws:

- Identity: `bimap identity identity == identity`
- Composition: `bimap f1 g1 <<< bimap f2 g2 == bimap (f1 <<< f2) (g1 <<< g2)`


##### Instances
``` purescript
Bifunctor Either
Bifunctor Tuple
Bifunctor Const
```

#### `lmap`

``` purescript
lmap :: forall f a b c. Bifunctor f => (a -> b) -> f a c -> f b c
```

Map a function over the first type argument of a `Bifunctor`.

#### `rmap`

``` purescript
rmap :: forall f a b c. Bifunctor f => (b -> c) -> f a b -> f a c
```

Map a function over the second type arguments of a `Bifunctor`.


