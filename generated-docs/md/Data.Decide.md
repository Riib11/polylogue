## Module Data.Decide

#### `Decide`

``` purescript
class (Divide f) <= Decide f  where
  choose :: forall a b c. (a -> Either b c) -> f b -> f c -> f a
```

`Decide` is the contravariant analogue of `Alt`.

##### Instances
``` purescript
Decide Comparison
Decide Equivalence
Decide Predicate
(Semigroup r) => Decide (Op r)
```

#### `chosen`

``` purescript
chosen :: forall f a b. Decide f => f a -> f b -> f (Either a b)
```

`chosen = choose id`


