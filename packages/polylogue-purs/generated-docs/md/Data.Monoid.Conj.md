## Module Data.Monoid.Conj

#### `Conj`

``` purescript
newtype Conj a
  = Conj a
```

Monoid and semigroup for conjunction.

``` purescript
Conj x <> Conj y == Conj (x && y)
(mempty :: Conj _) == Conj tt
```

##### Instances
``` purescript
(Eq a) => Eq (Conj a)
Eq1 Conj
(Ord a) => Ord (Conj a)
Ord1 Conj
(Bounded a) => Bounded (Conj a)
(Show a) => Show (Conj a)
Functor Conj
Apply Conj
Applicative Conj
Bind Conj
Monad Conj
(HeytingAlgebra a) => Semigroup (Conj a)
(HeytingAlgebra a) => Monoid (Conj a)
(HeytingAlgebra a) => Semiring (Conj a)
```


