## Module Data.Profunctor.Star

#### `Star`

``` purescript
newtype Star f a b
  = Star (a -> f b)
```

`Star` turns a `Functor` into a `Profunctor`.

`Star f` is also the Kleisli category for `f`

##### Instances
``` purescript
Newtype (Star f a b) _
(Bind f) => Semigroupoid (Star f)
(Monad f) => Category (Star f)
(Functor f) => Functor (Star f a)
(Invariant f) => Invariant (Star f a)
(Apply f) => Apply (Star f a)
(Applicative f) => Applicative (Star f a)
(Bind f) => Bind (Star f a)
(Monad f) => Monad (Star f a)
(Alt f) => Alt (Star f a)
(Plus f) => Plus (Star f a)
(Alternative f) => Alternative (Star f a)
(MonadPlus f) => MonadPlus (Star f a)
(Distributive f) => Distributive (Star f a)
(Functor f) => Profunctor (Star f)
(Functor f) => Strong (Star f)
(Applicative f) => Choice (Star f)
(Distributive f) => Closed (Star f)
```

#### `hoistStar`

``` purescript
hoistStar :: forall f g a b. (f ~> g) -> Star f a b -> Star g a b
```


