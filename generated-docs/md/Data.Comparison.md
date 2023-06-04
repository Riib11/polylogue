## Module Data.Comparison

#### `Comparison`

``` purescript
newtype Comparison a
  = Comparison (a -> a -> Ordering)
```

An adaptor allowing `>$<` to map over the inputs of a comparison function.

##### Instances
``` purescript
Newtype (Comparison a) _
Contravariant Comparison
Semigroup (Comparison a)
Monoid (Comparison a)
```

#### `defaultComparison`

``` purescript
defaultComparison :: forall a. Ord a => Comparison a
```

The default comparison for any values with an `Ord` instance.


