## Module Type.Data.Ordering

#### `IsOrdering`

``` purescript
class IsOrdering ordering  where
  reflectOrdering :: Proxy ordering -> Ordering
```

Class for reflecting a type level `Ordering` at the value level

##### Instances
``` purescript
IsOrdering LT
IsOrdering EQ
IsOrdering GT
```

#### `reifyOrdering`

``` purescript
reifyOrdering :: forall r. Ordering -> (forall o. IsOrdering o => Proxy o -> r) -> r
```

Use a value level `Ordering` as a type-level `Ordering`

#### `Append`

``` purescript
class Append lhs rhs output | lhs -> rhs output
```

Append two `Ordering` types together
Reflective of the semigroup for value level `Ordering`

##### Instances
``` purescript
Append LT rhs LT
Append EQ rhs rhs
Append GT rhs GT
```

#### `append`

``` purescript
append :: forall l r o. Append l r o => Proxy l -> Proxy r -> Proxy o
```

#### `Invert`

``` purescript
class Invert ordering result | ordering -> result
```

Invert an `Ordering`

##### Instances
``` purescript
Invert LT GT
Invert EQ EQ
Invert GT LT
```

#### `invert`

``` purescript
invert :: forall i o. Invert i o => Proxy i -> Proxy o
```

#### `Equals`

``` purescript
class Equals lhs rhs out | lhs rhs -> out
```

##### Instances
``` purescript
Equals EQ EQ True
Equals LT LT True
Equals GT GT True
Equals EQ LT False
Equals EQ GT False
Equals LT EQ False
Equals LT GT False
Equals GT LT False
Equals GT EQ False
```

#### `equals`

``` purescript
equals :: forall l r o. Equals l r o => Proxy l -> Proxy r -> Proxy o
```


### Re-exported from Prim.Ordering:

#### `Ordering`

``` purescript
data Ordering :: Type
```

The `Ordering` kind represents the three possibilities of comparing two
types of the same kind: `LT` (less than), `EQ` (equal to), and
`GT` (greater than).

#### `LT`

``` purescript
data LT :: Ordering
```

The 'less than' ordering type.

#### `GT`

``` purescript
data GT :: Ordering
```

The 'greater than' ordering type.

#### `EQ`

``` purescript
data EQ :: Ordering
```

The 'equal to' ordering type.

