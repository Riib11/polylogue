## Module Data.Monoid.Disj

#### `Disj`

``` purescript
newtype Disj a
  = Disj a
```

Monoid and semigroup for disjunction.

``` purescript
Disj x <> Disj y == Disj (x || y)
(mempty :: Disj _) == Disj bottom
```

##### Instances
``` purescript
(Eq a) => Eq (Disj a)
Eq1 Disj
(Ord a) => Ord (Disj a)
Ord1 Disj
(Bounded a) => Bounded (Disj a)
(Show a) => Show (Disj a)
Functor Disj
Apply Disj
Applicative Disj
Bind Disj
Monad Disj
(HeytingAlgebra a) => Semigroup (Disj a)
(HeytingAlgebra a) => Monoid (Disj a)
(HeytingAlgebra a) => Semiring (Disj a)
```


