## Module Data.Identity

#### `Identity`

``` purescript
newtype Identity a
  = Identity a
```

##### Instances
``` purescript
Newtype (Identity a) _
(Eq a) => Eq (Identity a)
(Ord a) => Ord (Identity a)
(Bounded a) => Bounded (Identity a)
(HeytingAlgebra a) => HeytingAlgebra (Identity a)
(BooleanAlgebra a) => BooleanAlgebra (Identity a)
(Semigroup a) => Semigroup (Identity a)
(Monoid a) => Monoid (Identity a)
(Semiring a) => Semiring (Identity a)
(EuclideanRing a) => EuclideanRing (Identity a)
(Ring a) => Ring (Identity a)
(CommutativeRing a) => CommutativeRing (Identity a)
(Lazy a) => Lazy (Identity a)
(Show a) => Show (Identity a)
Eq1 Identity
Ord1 Identity
Functor Identity
Invariant Identity
Alt Identity
Apply Identity
Applicative Identity
Bind Identity
Monad Identity
Extend Identity
Comonad Identity
```


