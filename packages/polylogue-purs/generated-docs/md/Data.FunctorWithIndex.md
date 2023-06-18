## Module Data.FunctorWithIndex

#### `FunctorWithIndex`

``` purescript
class (Functor f) <= FunctorWithIndex i f | f -> i where
  mapWithIndex :: forall a b. (i -> a -> b) -> f a -> f b
```

A `Functor` with an additional index.
Instances must satisfy a modified form of the `Functor` laws
```purescript
mapWithIndex (\_ a -> a) = identity
mapWithIndex f . mapWithIndex g = mapWithIndex (\i -> f i <<< g i)
```
and be compatible with the `Functor` instance
```purescript
map f = mapWithIndex (const f)
```

##### Instances
``` purescript
FunctorWithIndex Int Array
FunctorWithIndex Unit Maybe
FunctorWithIndex Unit First
FunctorWithIndex Unit Last
FunctorWithIndex Unit Additive
FunctorWithIndex Unit Dual
FunctorWithIndex Unit Conj
FunctorWithIndex Unit Disj
FunctorWithIndex Unit Multiplicative
FunctorWithIndex Unit (Either a)
FunctorWithIndex Unit (Tuple a)
FunctorWithIndex Unit Identity
FunctorWithIndex Void (Const a)
(FunctorWithIndex a f, FunctorWithIndex b g) => FunctorWithIndex (Either a b) (Product f g)
(FunctorWithIndex a f, FunctorWithIndex b g) => FunctorWithIndex (Either a b) (Coproduct f g)
(FunctorWithIndex a f, FunctorWithIndex b g) => FunctorWithIndex (Tuple a b) (Compose f g)
(FunctorWithIndex a f) => FunctorWithIndex a (App f)
```

#### `mapDefault`

``` purescript
mapDefault :: forall i f a b. FunctorWithIndex i f => (a -> b) -> f a -> f b
```

A default implementation of Functor's `map` in terms of `mapWithIndex`


