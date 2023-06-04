## Module Data.Ord.Down

#### `Down`

``` purescript
newtype Down a
  = Down a
```

A newtype wrapper which provides a reversed `Ord` instance. For example:

    sortBy (comparing Down) [1,2,3] = [3,2,1]


##### Instances
``` purescript
Newtype (Down a) _
(Eq a) => Eq (Down a)
(Ord a) => Ord (Down a)
(Bounded a) => Bounded (Down a)
(Show a) => Show (Down a)
```


