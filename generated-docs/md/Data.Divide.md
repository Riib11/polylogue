## Module Data.Divide

#### `Divide`

``` purescript
class (Contravariant f) <= Divide f  where
  divide :: forall a b c. (a -> Tuple b c) -> f b -> f c -> f a
```

`Divide` is the contravariant analogue of `Apply`.

For example, to test equality of `Point`s, we can use the `Divide` instance
for `Equivalence`:

```purescript
type Point = Tuple Int Int

pointEquiv :: Equivalence Point
pointEquiv = divided defaultEquivalence defaultEquivalence
```

##### Instances
``` purescript
Divide Comparison
Divide Equivalence
Divide Predicate
(Semigroup r) => Divide (Op r)
```

#### `divided`

``` purescript
divided :: forall f a b. Divide f => f a -> f b -> f (Tuple a b)
```

`divided = divide id`


