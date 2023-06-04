## Module Data.Maybe.First

#### `First`

``` purescript
newtype First a
  = First (Maybe a)
```

Monoid returning the first (left-most) non-`Nothing` value.

``` purescript
First (Just x) <> First (Just y) == First (Just x)
First Nothing <> First (Just y) == First (Just y)
First Nothing <> First Nothing == First Nothing
mempty :: First _ == First Nothing
```

##### Instances
``` purescript
Newtype (First a) _
(Eq a) => Eq (First a)
Eq1 First
(Ord a) => Ord (First a)
Ord1 First
(Bounded a) => Bounded (First a)
Functor First
Invariant First
Apply First
Applicative First
Bind First
Monad First
Extend First
(Show a) => Show (First a)
Semigroup (First a)
Monoid (First a)
Alt First
Plus First
Alternative First
```


