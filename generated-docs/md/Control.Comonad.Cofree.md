## Module Control.Comonad.Cofree

The _cofree comonad_ for a `Functor`.

#### `Cofree`

``` purescript
newtype Cofree f a
```

The `Cofree` `Comonad` for a functor.

A value of type `Cofree f a` consists of an `f`-branching
tree, annotated with labels of type `a`.

The `Comonad` instance supports _redecoration_, recomputing
labels from the local context.

##### Instances
``` purescript
(Apply f, Semigroup a) => Semigroup (Cofree f a)
(Applicative f, Monoid a) => Monoid (Cofree f a)
(Eq1 f, Eq a) => Eq (Cofree f a)
(Eq1 f) => Eq1 (Cofree f)
(Ord1 f, Ord a) => Ord (Cofree f a)
(Ord1 f) => Ord1 (Cofree f)
(Functor f) => Functor (Cofree f)
(Functor f) => FunctorWithIndex Int (Cofree f)
(Foldable f) => Foldable (Cofree f)
(Traversable f) => Traversable (Cofree f)
(Functor f) => Extend (Cofree f)
(Functor f) => Comonad (Cofree f)
(Alternative f) => Apply (Cofree f)
(Alternative f) => Applicative (Cofree f)
(Alternative f) => Bind (Cofree f)
(Alternative f) => Monad (Cofree f)
Lazy (Cofree f a)
```

#### `deferCofree`

``` purescript
deferCofree :: forall f a. (Unit -> Tuple a (f (Cofree f a))) -> Cofree f a
```

Lazily creates a value of type `Cofree f a` from a label and a
functor-full of "subtrees".

#### `mkCofree`

``` purescript
mkCofree :: forall f a. a -> f (Cofree f a) -> Cofree f a
```

Create a value of type `Cofree f a` from a label and a
functor-full of "subtrees".

#### `(:<)`

``` purescript
infixr 5 mkCofree as :<
```

#### `head`

``` purescript
head :: forall f a. Cofree f a -> a
```

Returns the label for a tree.

#### `tail`

``` purescript
tail :: forall f a. Cofree f a -> f (Cofree f a)
```

Returns the "subtrees" of a tree.

#### `hoistCofree`

``` purescript
hoistCofree :: forall f g. Functor f => (f ~> g) -> (Cofree f) ~> (Cofree g)
```

#### `buildCofree`

``` purescript
buildCofree :: forall f s a. Functor f => (s -> Tuple a (f s)) -> s -> Cofree f a
```

Recursively unfolds a `Cofree` structure given a seed.

#### `explore`

``` purescript
explore :: forall f g a b. Functor f => Functor g => (forall x y. f (x -> y) -> g x -> y) -> Free f (a -> b) -> Cofree g a -> b
```

Explore a value in the cofree comonad by using an expression in a
corresponding free monad.

The free monad should be built from a functor which pairs with the
functor underlying the cofree comonad.

#### `exploreM`

``` purescript
exploreM :: forall f g a b m. Functor f => Functor g => MonadRec m => (forall x y. f (x -> y) -> g x -> m y) -> Free f (a -> b) -> Cofree g a -> m b
```


