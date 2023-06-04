## Module Data.Ord.Min

#### `Min`

``` purescript
newtype Min a
  = Min a
```

Provides a `Semigroup` based on the `min` function. If the type has a
`Bounded` instance, then a `Monoid` instance is provided too. For example:

    unwrap (Min 5 <> Min 6) = 5
    mempty :: Min Ordering = Min GT


##### Instances
``` purescript
Newtype (Min a) _
(Eq a) => Eq (Min a)
(Ord a) => Ord (Min a)
(Ord a) => Semigroup (Min a)
(Bounded a) => Monoid (Min a)
(Show a) => Show (Min a)
```


