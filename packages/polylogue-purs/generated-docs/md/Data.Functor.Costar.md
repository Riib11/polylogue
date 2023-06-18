## Module Data.Functor.Costar

#### `Costar`

``` purescript
newtype Costar f b a
  = Costar (f b -> a)
```

`Costar` turns a `Functor` into a `Profunctor` "backwards".

`Costar f` is also the co-Kleisli category for `f`.

##### Instances
``` purescript
Newtype (Costar f a b) _
(Extend f) => Semigroupoid (Costar f)
(Comonad f) => Category (Costar f)
Functor (Costar f a)
Invariant (Costar f a)
Apply (Costar f a)
Applicative (Costar f a)
Bind (Costar f a)
Monad (Costar f a)
Distributive (Costar f a)
(Contravariant f) => Bifunctor (Costar f)
(Functor f) => Profunctor (Costar f)
(Comonad f) => Strong (Costar f)
(Functor f) => Closed (Costar f)
```

#### `hoistCostar`

``` purescript
hoistCostar :: forall f g a b. (g ~> f) -> Costar f a b -> Costar g a b
```


