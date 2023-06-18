## Module Data.Maybe.Last

#### `Last`

``` purescript
newtype Last a
  = Last (Maybe a)
```

Monoid returning the last (right-most) non-`Nothing` value.

``` purescript
Last (Just x) <> Last (Just y) == Last (Just y)
Last (Just x) <> Last Nothing == Last (Just x)
Last Nothing <> Last Nothing == Last Nothing
mempty :: Last _ == Last Nothing
```

##### Instances
``` purescript
Newtype (Last a) _
(Eq a) => Eq (Last a)
Eq1 Last
(Ord a) => Ord (Last a)
Ord1 Last
(Bounded a) => Bounded (Last a)
Functor Last
Invariant Last
Apply Last
Applicative Last
Bind Last
Monad Last
Extend Last
(Show a) => Show (Last a)
Semigroup (Last a)
Monoid (Last a)
Alt Last
Plus Last
Alternative Last
```


