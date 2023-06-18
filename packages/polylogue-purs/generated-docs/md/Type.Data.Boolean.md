## Module Type.Data.Boolean

#### `IsBoolean`

``` purescript
class IsBoolean bool  where
  reflectBoolean :: Proxy bool -> Boolean
```

Class for reflecting a type level `Boolean` at the value level

##### Instances
``` purescript
IsBoolean True
IsBoolean False
```

#### `reifyBoolean`

``` purescript
reifyBoolean :: forall r. Boolean -> (forall o. IsBoolean o => Proxy o -> r) -> r
```

Use a value level `Boolean` as a type-level `Boolean`

#### `And`

``` purescript
class And lhs rhs out | lhs rhs -> out
```

And two `Boolean` types together

##### Instances
``` purescript
And True rhs rhs
And False rhs False
```

#### `and`

``` purescript
and :: forall l r o. And l r o => Proxy l -> Proxy r -> Proxy o
```

#### `Or`

``` purescript
class Or lhs rhs output | lhs rhs -> output
```

Or two `Boolean` types together

##### Instances
``` purescript
Or True rhs True
Or False rhs rhs
```

#### `or`

``` purescript
or :: forall l r o. Or l r o => Proxy l -> Proxy r -> Proxy o
```

#### `Not`

``` purescript
class Not bool output | bool -> output
```

Not a `Boolean`

##### Instances
``` purescript
Not True False
Not False True
```

#### `not`

``` purescript
not :: forall i o. Not i o => Proxy i -> Proxy o
```

#### `If`

``` purescript
class If bool onTrue onFalse output | bool onTrue onFalse -> output
```

If - dispatch based on a boolean

##### Instances
``` purescript
If True onTrue onFalse onTrue
If False onTrue onFalse onFalse
```

#### `if_`

``` purescript
if_ :: forall b t e o. If b t e o => Proxy b -> Proxy t -> Proxy e -> Proxy o
```


### Re-exported from Prim.Boolean:

#### `True`

``` purescript
data True :: Boolean
```

The 'True' boolean type.

#### `False`

``` purescript
data False :: Boolean
```

The 'False' boolean type.

