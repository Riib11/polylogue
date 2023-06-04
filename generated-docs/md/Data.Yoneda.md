## Module Data.Yoneda

#### `Yoneda`

``` purescript
newtype Yoneda f a
  = Yoneda (forall b. (a -> b) -> f b)
```

The Yoneda `Functor`

`Yoneda f` is a `Functor` for any type constructor `f`.

##### Instances
``` purescript
(Eq1 f, Eq a) => Eq (Yoneda f a)
(Eq1 f) => Eq1 (Yoneda f)
(Ord1 f, Ord a) => Ord (Yoneda f a)
(Ord1 f) => Ord1 (Yoneda f)
Functor (Yoneda f)
(Apply f) => Apply (Yoneda f)
(Applicative f) => Applicative (Yoneda f)
(Bind f) => Bind (Yoneda f)
(Monad f) => Monad (Yoneda f)
MonadTrans Yoneda
(Extend w) => Extend (Yoneda w)
(Comonad w) => Comonad (Yoneda w)
```

#### `runYoneda`

``` purescript
runYoneda :: forall f a b. Yoneda f a -> (a -> b) -> f b
```

Run a computation of type `Yoneda f a`.

#### `liftYoneda`

``` purescript
liftYoneda :: forall f a. Functor f => f a -> Yoneda f a
```

Lift a value described by the `Functor` `f` to the `Functor` `Yoneda f`.

#### `lowerYoneda`

``` purescript
lowerYoneda :: forall f a. Yoneda f a -> f a
```

Lower a value of type `Yoneda f a` to the type constructor `f`.

#### `hoistYoneda`

``` purescript
hoistYoneda :: forall f g a. (f ~> g) -> Yoneda f a -> Yoneda g a
```

Use a natural transformation to change the generating type constructor of a
`Yoneda`.


