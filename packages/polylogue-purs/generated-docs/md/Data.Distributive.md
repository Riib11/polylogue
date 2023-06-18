## Module Data.Distributive

#### `Distributive`

``` purescript
class (Functor f) <= Distributive f  where
  distribute :: forall a g. Functor g => g (f a) -> f (g a)
  collect :: forall a b g. Functor g => (a -> f b) -> g a -> f (g b)
```

Categorical dual of `Traversable`:

- `distribute` is the dual of `sequence` - it zips an arbitrary collection
  of containers.
- `collect` is the dual of `traverse` - it traverses an arbitrary
  collection of values.

Laws:

- `distribute = collect identity`
- `distribute <<< distribute = identity`
- `collect f = distribute <<< map f`
- `map f = unwrap <<< collect (Identity <<< f)`
- `map distribute <<< collect f = unwrap <<< collect (Compose <<< f)`

##### Instances
``` purescript
Distributive Identity
Distributive (Function e)
(TypeEquals a Unit) => Distributive (Tuple a)
```

#### `distributeDefault`

``` purescript
distributeDefault :: forall a f g. Distributive f => Functor g => g (f a) -> f (g a)
```

A default implementation of `distribute`, based on `collect`.

#### `collectDefault`

``` purescript
collectDefault :: forall a b f g. Distributive f => Functor g => (a -> f b) -> g a -> f (g b)
```

A default implementation of `collect`, based on `distribute`.

#### `cotraverse`

``` purescript
cotraverse :: forall a b f g. Distributive f => Functor g => (g a -> b) -> g (f a) -> f b
```

Zip an arbitrary collection of containers and summarize the results


