## Module Data.Functor.Joker

#### `Joker`

``` purescript
newtype Joker g a b
  = Joker (g b)
```

This advanced type's usage and its relation to `Clown` is best understood
by reading through "Clowns to the Left, Jokers to the Right (Functional
Pearl)"
https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.475.6134&rep=rep1&type=pdf

##### Instances
``` purescript
Newtype (Joker f a b) _
(Eq (f b)) => Eq (Joker f a b)
(Ord (f b)) => Ord (Joker f a b)
(Show (f b)) => Show (Joker f a b)
(Functor f) => Functor (Joker f a)
(Apply f) => Apply (Joker f a)
(Applicative f) => Applicative (Joker f a)
(Bind f) => Bind (Joker f a)
(Monad m) => Monad (Joker m a)
(Functor g) => Bifunctor (Joker g)
(Apply g) => Biapply (Joker g)
(Applicative g) => Biapplicative (Joker g)
(Functor f) => Profunctor (Joker f)
(Functor f) => Choice (Joker f)
```

#### `hoistJoker`

``` purescript
hoistJoker :: forall f g a b. (f ~> g) -> Joker f a b -> Joker g a b
```


