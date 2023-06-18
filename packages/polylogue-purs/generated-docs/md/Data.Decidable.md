## Module Data.Decidable

#### `Decidable`

``` purescript
class (Decide f, Divisible f) <= Decidable f  where
  lose :: forall a. (a -> Void) -> f a
```

`Decidable` is the contravariant analogue of `Alternative`.

##### Instances
``` purescript
Decidable Comparison
Decidable Equivalence
Decidable Predicate
(Monoid r) => Decidable (Op r)
```

#### `lost`

``` purescript
lost :: forall f. Decidable f => f Void
```


