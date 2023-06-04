## Module Data.Monoid.Alternate

#### `Alternate`

``` purescript
newtype Alternate f a
  = Alternate (f a)
```

Monoid and semigroup instances corresponding to `Plus` and `Alt` instances
for `f`

``` purescript
Alternate fx <> Alternate fy == Alternate (fx <|> fy)
mempty :: Alternate _ == Alternate empty
```

##### Instances
``` purescript
Newtype (Alternate f a) _
(Eq (f a)) => Eq (Alternate f a)
(Eq1 f) => Eq1 (Alternate f)
(Ord (f a)) => Ord (Alternate f a)
(Ord1 f) => Ord1 (Alternate f)
(Bounded (f a)) => Bounded (Alternate f a)
(Functor f) => Functor (Alternate f)
(Apply f) => Apply (Alternate f)
(Applicative f) => Applicative (Alternate f)
(Alt f) => Alt (Alternate f)
(Plus f) => Plus (Alternate f)
(Alternative f) => Alternative (Alternate f)
(Bind f) => Bind (Alternate f)
(Monad f) => Monad (Alternate f)
(Extend f) => Extend (Alternate f)
(Comonad f) => Comonad (Alternate f)
(Show (f a)) => Show (Alternate f a)
(Alt f) => Semigroup (Alternate f a)
(Plus f) => Monoid (Alternate f a)
```


