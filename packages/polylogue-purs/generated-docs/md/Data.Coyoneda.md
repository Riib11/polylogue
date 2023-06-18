## Module Data.Coyoneda

#### `Coyoneda`

``` purescript
newtype Coyoneda f a
  = Coyoneda (Exists (CoyonedaF f a))
```

The `Coyoneda` `Functor`.

`Coyoneda f` is a `Functor` for any type constructor `f`. In fact,
it is the _free_ `Functor` for `f`, i.e. any natural transformation
`nat :: f ~> g`, can be factor through `liftCoyoneda`.  The natural
transformation from `Coyoneda f ~> g` is given by `lowerCoyoneda <<<
hoistCoyoneda nat`:
```purescript
lowerCoyoneda <<< hoistCoyoneda nat <<< liftCoyoneda $ fi
= lowerCoyoneda (hoistCoyoneda nat (Coyoneda $ mkExists $ CoyonedaF identity fi))    (by definition of liftCoyoneda)
= lowerCoyoneda (coyoneda identity (nat fi))                                         (by definition of hoistCoyoneda)
= unCoyoneda map (coyoneda identity (nat fi))                                        (by definition of lowerCoyoneda)
= unCoyoneda map (Coyoneda $ mkExists $ CoyonedaF  identity (nat fi))                (by definition of coyoneda)
= map identity (nat fi)                                                              (by definition of unCoyoneda)
= nat fi                                                                       (since g is a Functor)
```

##### Instances
``` purescript
(Functor f, Eq1 f, Eq a) => Eq (Coyoneda f a)
(Functor f, Eq1 f) => Eq1 (Coyoneda f)
(Functor f, Ord1 f, Ord a) => Ord (Coyoneda f a)
(Functor f, Ord1 f) => Ord1 (Coyoneda f)
Functor (Coyoneda f)
Invariant (Coyoneda f)
(Apply f) => Apply (Coyoneda f)
(Applicative f) => Applicative (Coyoneda f)
(Alt f) => Alt (Coyoneda f)
(Plus f) => Plus (Coyoneda f)
(Alternative f) => Alternative (Coyoneda f)
(Bind f) => Bind (Coyoneda f)
(Monad f) => Monad (Coyoneda f)
MonadTrans Coyoneda
(MonadPlus f) => MonadPlus (Coyoneda f)
(Extend w) => Extend (Coyoneda w)
(Comonad w) => Comonad (Coyoneda w)
(Foldable f) => Foldable (Coyoneda f)
(Traversable f) => Traversable (Coyoneda f)
(Foldable1 f) => Foldable1 (Coyoneda f)
(Traversable1 f) => Traversable1 (Coyoneda f)
(Distributive f) => Distributive (Coyoneda f)
```

#### `CoyonedaF`

``` purescript
data CoyonedaF f a i
```

`Coyoneda` is encoded as an existential type using `Data.Exists`.

This type constructor encodes the contents of the existential package.

#### `coyoneda`

``` purescript
coyoneda :: forall f a b. (a -> b) -> f a -> Coyoneda f b
```

Construct a value of type `Coyoneda f b` from a mapping function and a
value of type `f a`.

#### `unCoyoneda`

``` purescript
unCoyoneda :: forall f a r. (forall b. (b -> a) -> f b -> r) -> Coyoneda f a -> r
```

Deconstruct a value of `Coyoneda a` to retrieve the mapping function and
original value.

#### `liftCoyoneda`

``` purescript
liftCoyoneda :: forall f. f ~> (Coyoneda f)
```

Lift a value described by the type constructor `f` to `Coyoneda f`.

Note that for any functor `f` `liftCoyoneda` has a right inverse
`lowerCoyoneda`:
```purescript
liftCoyoneda <<< lowerCoyoneda $ (Coyoneda e)
= liftCoyoneda <<< unCoyoneda map $ (Coyoneda e)
= liftCoyonead (runExists (\(CoyonedaF k fi) -> map k fi) e)
= liftCoyonead (Coyoneda e)
= coyoneda identity (Coyoneda e)
= Coyoneda e
```
Moreover if `f` is a `Functor` then `liftCoyoneda` is an isomorphism of
functors with inverse `lowerCoyoneda`:  we already showed that
`lowerCoyoneda <<< hoistCoyoneda identity = lowerCoyoneda` is its left inverse
whenever `f` is a functor.

#### `lowerCoyoneda`

``` purescript
lowerCoyoneda :: forall f. Functor f => (Coyoneda f) ~> f
```

Lower a value of type `Coyoneda f a` to the `Functor` `f`.

#### `hoistCoyoneda`

``` purescript
hoistCoyoneda :: forall f g. (f ~> g) -> (Coyoneda f) ~> (Coyoneda g)
```

Use a natural transformation to change the generating type constructor of a
`Coyoneda`.


