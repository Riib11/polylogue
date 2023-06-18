## Module Data.List.ZipList

This module defines the type of _zip lists_, i.e. linked lists
with a zippy `Applicative` instance.

#### `ZipList`

``` purescript
newtype ZipList a
  = ZipList (List a)
```

`ZipList` is a newtype around `List` which provides a zippy
`Applicative` instance.

##### Instances
``` purescript
(Show a) => Show (ZipList a)
Newtype (ZipList a) _
(Eq a) => Eq (ZipList a)
(Ord a) => Ord (ZipList a)
Semigroup (ZipList a)
Monoid (ZipList a)
Foldable ZipList
Traversable ZipList
Functor ZipList
Apply ZipList
Applicative ZipList
Alt ZipList
Plus ZipList
Alternative ZipList
(Fail (Text "\n    ZipList is not Bind. Any implementation would break the associativity law.\n\n    Possible alternatives:\n        Data.List.List\n        Data.List.Lazy.List\n    ")) => Bind ZipList
```


