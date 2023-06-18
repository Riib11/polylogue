## Module Data.Functor.Compose

#### `Compose`

``` purescript
newtype Compose f g a
  = Compose (f (g a))
```

`Compose f g` is the composition of the two functors `f` and `g`.

##### Instances
``` purescript
Newtype (Compose f g a) _
(Eq1 f, Eq1 g, Eq a) => Eq (Compose f g a)
(Eq1 f, Eq1 g) => Eq1 (Compose f g)
(Ord1 f, Ord1 g, Ord a) => Ord (Compose f g a)
(Ord1 f, Ord1 g) => Ord1 (Compose f g)
(Show (f (g a))) => Show (Compose f g a)
(Functor f, Functor g) => Functor (Compose f g)
(Apply f, Apply g) => Apply (Compose f g)
(Applicative f, Applicative g) => Applicative (Compose f g)
(Alt f, Functor g) => Alt (Compose f g)
(Plus f, Functor g) => Plus (Compose f g)
(Alternative f, Applicative g) => Alternative (Compose f g)
```

#### `bihoistCompose`

``` purescript
bihoistCompose :: forall f g h i. Functor f => (f ~> h) -> (g ~> i) -> (Compose f g) ~> (Compose h i)
```


