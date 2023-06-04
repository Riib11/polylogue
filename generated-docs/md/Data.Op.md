## Module Data.Op

#### `Op`

``` purescript
newtype Op a b
  = Op (b -> a)
```

The opposite of the function category.

##### Instances
``` purescript
Newtype (Op a b) _
(Semigroup a) => Semigroup (Op a b)
(Monoid a) => Monoid (Op a b)
Semigroupoid Op
Category Op
Contravariant (Op a)
```


