## Module Data.Reflectable

#### `Reflectable`

``` purescript
class Reflectable v t | v -> t where
  reflectType :: Proxy v -> t
```

A type-class for reflectable types.

Instances for the following kinds are solved by the compiler:
* Boolean
* Int
* Ordering
* Symbol

#### `Reifiable`

``` purescript
class Reifiable t 
```

A type class for reifiable types.

Instances of this type class correspond to the `t` synthesized
by the compiler when solving the `Reflectable` type class.

##### Instances
``` purescript
Reifiable Boolean
Reifiable Int
Reifiable Ordering
Reifiable String
```

#### `reifyType`

``` purescript
reifyType :: forall t r. Reifiable t => t -> (forall v. Reflectable v t => Proxy v -> r) -> r
```

Reify a value of type `t` such that it can be consumed by a
function constrained by the `Reflectable` type class. For
example:

```purs
twiceFromType :: forall v. Reflectable v Int => Proxy v -> Int
twiceFromType = (_ * 2) <<< reflectType

twiceOfTerm :: Int
twiceOfTerm = reifyType 21 twiceFromType
```


