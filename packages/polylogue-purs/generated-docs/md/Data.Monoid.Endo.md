## Module Data.Monoid.Endo

#### `Endo`

``` purescript
newtype Endo c a
  = Endo (c a a)
```

Monoid and semigroup for category endomorphisms.

When `c` is instantiated with `->` this composes functions of type
`a -> a`:

``` purescript
Endo f <> Endo g == Endo (f <<< g)
(mempty :: Endo _) == Endo identity
```

##### Instances
``` purescript
(Eq (c a a)) => Eq (Endo c a)
(Ord (c a a)) => Ord (Endo c a)
(Bounded (c a a)) => Bounded (Endo c a)
(Show (c a a)) => Show (Endo c a)
(Semigroupoid c) => Semigroup (Endo c a)
(Category c) => Monoid (Endo c a)
```


