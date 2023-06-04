## Module Data.Monoid.Multiplicative

#### `Multiplicative`

``` purescript
newtype Multiplicative a
  = Multiplicative a
```

Monoid and semigroup for semirings under multiplication.

``` purescript
Multiplicative x <> Multiplicative y == Multiplicative (x * y)
(mempty :: Multiplicative _) == Multiplicative one
```

##### Instances
``` purescript
(Eq a) => Eq (Multiplicative a)
Eq1 Multiplicative
(Ord a) => Ord (Multiplicative a)
Ord1 Multiplicative
(Bounded a) => Bounded (Multiplicative a)
(Show a) => Show (Multiplicative a)
Functor Multiplicative
Apply Multiplicative
Applicative Multiplicative
Bind Multiplicative
Monad Multiplicative
(Semiring a) => Semigroup (Multiplicative a)
(Semiring a) => Monoid (Multiplicative a)
```


