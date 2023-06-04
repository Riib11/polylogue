## Module Data.Semigroup.Last

#### `Last`

``` purescript
newtype Last a
  = Last a
```

Semigroup where `append` always takes the second option.

``` purescript
Last x <> Last y == Last y
```

##### Instances
``` purescript
(Eq a) => Eq (Last a)
Eq1 Last
(Ord a) => Ord (Last a)
Ord1 Last
(Bounded a) => Bounded (Last a)
(Show a) => Show (Last a)
Functor Last
Apply Last
Applicative Last
Bind Last
Monad Last
Semigroup (Last a)
```


