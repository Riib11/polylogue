## Module Data.Lazy

#### `Lazy`

``` purescript
data Lazy t0
```

`Lazy a` represents lazily-computed values of type `a`.

A lazy value is computed at most once - the result is saved
after the first computation, and subsequent attempts to read
the value simply return the saved value.

`Lazy` values can be created with `defer`, or by using the provided
type class instances.

`Lazy` values can be evaluated by using the `force` function.

##### Instances
``` purescript
(Semiring a) => Semiring (Lazy a)
(Ring a) => Ring (Lazy a)
(CommutativeRing a) => CommutativeRing (Lazy a)
(EuclideanRing a) => EuclideanRing (Lazy a)
(Eq a) => Eq (Lazy a)
Eq1 Lazy
(Ord a) => Ord (Lazy a)
Ord1 Lazy
(Bounded a) => Bounded (Lazy a)
(Semigroup a) => Semigroup (Lazy a)
(Monoid a) => Monoid (Lazy a)
(HeytingAlgebra a) => HeytingAlgebra (Lazy a)
(BooleanAlgebra a) => BooleanAlgebra (Lazy a)
Functor Lazy
FunctorWithIndex Unit Lazy
Foldable Lazy
FoldableWithIndex Unit Lazy
Foldable1 Lazy
Traversable Lazy
TraversableWithIndex Unit Lazy
Traversable1 Lazy
Invariant Lazy
Apply Lazy
Applicative Lazy
Bind Lazy
Monad Lazy
Extend Lazy
Comonad Lazy
(Show a) => Show (Lazy a)
Lazy (Lazy a)
```

#### `defer`

``` purescript
defer :: forall a. (Unit -> a) -> Lazy a
```

Defer a computation, creating a `Lazy` value.

#### `force`

``` purescript
force :: forall a. Lazy a -> a
```

Force evaluation of a `Lazy` value.


