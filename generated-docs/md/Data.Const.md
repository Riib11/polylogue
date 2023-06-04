## Module Data.Const

#### `Const`

``` purescript
newtype Const a b
  = Const a
```

The `Const` type constructor, which wraps its first type argument
and ignores its second. That is, `Const a b` is isomorphic to `a`
for any `b`.

`Const` has some useful instances. For example, the `Applicative`
instance allows us to collect results using a `Monoid` while
ignoring return values.

##### Instances
``` purescript
Newtype (Const a b) _
(Eq a) => Eq (Const a b)
(Eq a) => Eq1 (Const a)
(Ord a) => Ord (Const a b)
(Ord a) => Ord1 (Const a)
(Bounded a) => Bounded (Const a b)
(Show a) => Show (Const a b)
Semigroupoid Const
(Semigroup a) => Semigroup (Const a b)
(Monoid a) => Monoid (Const a b)
(Semiring a) => Semiring (Const a b)
(Ring a) => Ring (Const a b)
(EuclideanRing a) => EuclideanRing (Const a b)
(CommutativeRing a) => CommutativeRing (Const a b)
(HeytingAlgebra a) => HeytingAlgebra (Const a b)
(BooleanAlgebra a) => BooleanAlgebra (Const a b)
Functor (Const a)
Invariant (Const a)
(Semigroup a) => Apply (Const a)
(Monoid a) => Applicative (Const a)
```


