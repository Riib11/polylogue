## Module Data.Predicate

#### `Predicate`

``` purescript
newtype Predicate a
  = Predicate (a -> Boolean)
```

An adaptor allowing `>$<` to map over the inputs of a predicate.

##### Instances
``` purescript
Newtype (Predicate a) _
HeytingAlgebra (Predicate a)
BooleanAlgebra (Predicate a)
Contravariant Predicate
```


