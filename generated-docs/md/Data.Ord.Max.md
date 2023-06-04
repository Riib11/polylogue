## Module Data.Ord.Max

#### `Max`

``` purescript
newtype Max a
  = Max a
```

Provides a `Semigroup` based on the `max` function. If the type has a
`Bounded` instance, then a `Monoid` instance is provided too. For example:

    unwrap (Max 5 <> Max 6) = 6
    mempty :: Max Ordering = Max LT


##### Instances
``` purescript
Newtype (Max a) _
(Eq a) => Eq (Max a)
(Ord a) => Ord (Max a)
(Ord a) => Semigroup (Max a)
(Bounded a) => Monoid (Max a)
(Show a) => Show (Max a)
```


