## Module Data.Semigroup.First

#### `First`

``` purescript
newtype First a
  = First a
```

Semigroup where `append` always takes the first option.

``` purescript
First x <> First y == First x
```

##### Instances
``` purescript
(Eq a) => Eq (First a)
Eq1 First
(Ord a) => Ord (First a)
Ord1 First
(Bounded a) => Bounded (First a)
(Show a) => Show (First a)
Functor First
Apply First
Applicative First
Bind First
Monad First
Semigroup (First a)
```


