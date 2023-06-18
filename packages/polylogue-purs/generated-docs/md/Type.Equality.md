## Module Type.Equality

#### `TypeEquals`

``` purescript
class (Coercible a b) <= TypeEquals a b | a -> b, b -> a where
  proof :: forall p. p a -> p b
```

This type class asserts that types `a` and `b`
are equal.

The functional dependencies and the single
instance below will force the two type arguments
to unify when either one is known.

Note: any instance will necessarily overlap with
`refl` below, so instances of this class should
not be defined in libraries.

##### Instances
``` purescript
TypeEquals a a
```

#### `to`

``` purescript
to :: forall a b. TypeEquals a b => a -> b
```

#### `from`

``` purescript
from :: forall a b. TypeEquals a b => b -> a
```


