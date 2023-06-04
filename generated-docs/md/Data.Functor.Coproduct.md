## Module Data.Functor.Coproduct

#### `Coproduct`

``` purescript
newtype Coproduct f g a
  = Coproduct (Either (f a) (g a))
```

`Coproduct f g` is the coproduct of two functors `f` and `g`

##### Instances
``` purescript
Newtype (Coproduct f g a) _
(Eq1 f, Eq1 g, Eq a) => Eq (Coproduct f g a)
(Eq1 f, Eq1 g) => Eq1 (Coproduct f g)
(Ord1 f, Ord1 g, Ord a) => Ord (Coproduct f g a)
(Ord1 f, Ord1 g) => Ord1 (Coproduct f g)
(Show (f a), Show (g a)) => Show (Coproduct f g a)
(Functor f, Functor g) => Functor (Coproduct f g)
(Extend f, Extend g) => Extend (Coproduct f g)
(Comonad f, Comonad g) => Comonad (Coproduct f g)
```

#### `left`

``` purescript
left :: forall f g a. f a -> Coproduct f g a
```

Left injection

#### `right`

``` purescript
right :: forall f g a. g a -> Coproduct f g a
```

Right injection

#### `coproduct`

``` purescript
coproduct :: forall f g a b. (f a -> b) -> (g a -> b) -> Coproduct f g a -> b
```

Eliminate a coproduct by providing eliminators for the left and
right components

#### `bihoistCoproduct`

``` purescript
bihoistCoproduct :: forall f g h i. (f ~> h) -> (g ~> i) -> (Coproduct f g) ~> (Coproduct h i)
```

Change the underlying functors in a coproduct


