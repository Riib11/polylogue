## Module Data.Functor.Clown

#### `Clown`

``` purescript
newtype Clown f a b
  = Clown (f a)
```

This advanced type's usage and its relation to `Joker` is best understood
by reading through "Clowns to the Left, Jokers to the Right (Functional
Pearl)"
https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.475.6134&rep=rep1&type=pdf

##### Instances
``` purescript
Newtype (Clown f a b) _
(Eq (f a)) => Eq (Clown f a b)
(Ord (f a)) => Ord (Clown f a b)
(Show (f a)) => Show (Clown f a b)
Functor (Clown f a)
(Functor f) => Bifunctor (Clown f)
(Apply f) => Biapply (Clown f)
(Applicative f) => Biapplicative (Clown f)
(Contravariant f) => Profunctor (Clown f)
```

#### `hoistClown`

``` purescript
hoistClown :: forall f g a b. (f ~> g) -> Clown f a b -> Clown g a b
```


