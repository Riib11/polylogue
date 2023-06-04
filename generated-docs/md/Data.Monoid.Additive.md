## Module Data.Monoid.Additive

#### `Additive`

``` purescript
newtype Additive a
  = Additive a
```

Monoid and semigroup for semirings under addition.

``` purescript
Additive x <> Additive y == Additive (x + y)
(mempty :: Additive _) == Additive zero
```

##### Instances
``` purescript
(Eq a) => Eq (Additive a)
Eq1 Additive
(Ord a) => Ord (Additive a)
Ord1 Additive
(Bounded a) => Bounded (Additive a)
(Show a) => Show (Additive a)
Functor Additive
Apply Additive
Applicative Additive
Bind Additive
Monad Additive
(Semiring a) => Semigroup (Additive a)
(Semiring a) => Monoid (Additive a)
```


