## Module Data.Semigroup.Traversable

#### `Traversable1`

``` purescript
class (Foldable1 t, Traversable t) <= Traversable1 t  where
  traverse1 :: forall a b f. Apply f => (a -> f b) -> t a -> f (t b)
  sequence1 :: forall b f. Apply f => t (f b) -> f (t b)
```

`Traversable1` represents data structures with a minimum of one element that can be _traversed_,
accumulating results and effects in some `Applicative` functor.

- `traverse1` runs an action for every element in a data structure,
  and accumulates the results.
- `sequence1` runs the actions _contained_ in a data structure,
  and accumulates the results.

The `traverse1` and `sequence1` functions should be compatible in the
following sense:

- `traverse1 f xs = sequence1 (f <$> xs)`
- `sequence1 = traverse1 identity`

`Traversable1` instances should also be compatible with the corresponding
`Foldable1` instances, in the following sense:

- `foldMap1 f = runConst <<< traverse1 (Const <<< f)`

Default implementations are provided by the following functions:

- `traverse1Default`
- `sequence1Default`

##### Instances
``` purescript
Traversable1 Dual
Traversable1 Multiplicative
Traversable1 (Tuple a)
Traversable1 Identity
```

#### `traverse1Default`

``` purescript
traverse1Default :: forall t a b m. Traversable1 t => Apply m => (a -> m b) -> t a -> m (t b)
```

A default implementation of `traverse1` using `sequence1`.

#### `sequence1Default`

``` purescript
sequence1Default :: forall t a m. Traversable1 t => Apply m => t (m a) -> m (t a)
```

A default implementation of `sequence1` using `traverse1`.


