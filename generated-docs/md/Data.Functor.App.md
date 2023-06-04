## Module Data.Functor.App

#### `App`

``` purescript
newtype App f a
  = App (f a)
```

##### Instances
``` purescript
Newtype (App f a) _
(Eq1 f, Eq a) => Eq (App f a)
(Eq1 f) => Eq1 (App f)
(Ord1 f, Ord a) => Ord (App f a)
(Ord1 f) => Ord1 (App f)
(Show (f a)) => Show (App f a)
(Apply f, Semigroup a) => Semigroup (App f a)
(Applicative f, Monoid a) => Monoid (App f a)
(Functor f) => Functor (App f)
(Apply f) => Apply (App f)
(Applicative f) => Applicative (App f)
(Bind f) => Bind (App f)
(Monad f) => Monad (App f)
(Alt f) => Alt (App f)
(Plus f) => Plus (App f)
(Alternative f) => Alternative (App f)
(MonadPlus f) => MonadPlus (App f)
(Lazy (f a)) => Lazy (App f a)
(Extend f) => Extend (App f)
(Comonad f) => Comonad (App f)
```

#### `hoistApp`

``` purescript
hoistApp :: forall f g. (f ~> g) -> (App f) ~> (App g)
```

#### `hoistLiftApp`

``` purescript
hoistLiftApp :: forall f g a. f (g a) -> f (App g a)
```

#### `hoistLowerApp`

``` purescript
hoistLowerApp :: forall f g a. f (App g a) -> f (g a)
```


