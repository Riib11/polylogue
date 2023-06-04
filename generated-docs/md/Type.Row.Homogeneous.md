## Module Type.Row.Homogeneous

#### `Homogeneous`

``` purescript
class Homogeneous row fieldType | row -> fieldType
```

Ensure that every field in a row has the same type.

##### Instances
``` purescript
(RowToList row fields, HomogeneousRowList fields fieldType) => Homogeneous row fieldType
```

#### `HomogeneousRowList`

``` purescript
class HomogeneousRowList rowList fieldType | rowList -> fieldType
```

##### Instances
``` purescript
(HomogeneousRowList tail fieldType, TypeEquals fieldType fieldType2) => HomogeneousRowList (Cons symbol fieldType tail) fieldType2
HomogeneousRowList Nil fieldType
```


