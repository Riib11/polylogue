## Module Data.Divisible

#### `Divisible`

``` purescript
class (Divide f) <= Divisible f  where
  conquer :: forall a. f a
```

`Divisible` is the contravariant analogue of `Applicative`.

##### Instances
``` purescript
Divisible Comparison
Divisible Equivalence
Divisible Predicate
(Monoid r) => Divisible (Op r)
```


