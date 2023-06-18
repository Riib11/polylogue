## Module Data.Monoid.Dual

#### `Dual`

``` purescript
newtype Dual a
  = Dual a
```

The dual of a monoid.

``` purescript
Dual x <> Dual y == Dual (y <> x)
(mempty :: Dual _) == Dual mempty
```

##### Instances
``` purescript
(Eq a) => Eq (Dual a)
Eq1 Dual
(Ord a) => Ord (Dual a)
Ord1 Dual
(Bounded a) => Bounded (Dual a)
(Show a) => Show (Dual a)
Functor Dual
Apply Dual
Applicative Dual
Bind Dual
Monad Dual
(Semigroup a) => Semigroup (Dual a)
(Monoid a) => Monoid (Dual a)
```


