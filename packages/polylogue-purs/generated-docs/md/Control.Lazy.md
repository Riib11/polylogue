## Module Control.Lazy

#### `Lazy`

``` purescript
class Lazy l  where
  defer :: (Unit -> l) -> l
```

The `Lazy` class represents types which allow evaluation of values
to be _deferred_.

Usually, this means that a type contains a function arrow which can
be used to delay evaluation.

##### Instances
``` purescript
Lazy (a -> b)
Lazy Unit
```

#### `fix`

``` purescript
fix :: forall l. Lazy l => (l -> l) -> l
```

`fix` defines a value as the fixed point of a function.

The `Lazy` instance allows us to generate the result lazily.


