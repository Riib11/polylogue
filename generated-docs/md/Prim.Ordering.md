## Module Prim.Ordering

The Prim.Ordering module is embedded in the PureScript compiler. Unlike `Prim`, it is not imported implicitly. It contains a type level `Ordering` data structure.
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

#### `EQ`

``` purescript
data EQ :: Ordering
```

The 'equal to' ordering type.

#### `GT`

``` purescript
data GT :: Ordering
```

The 'greater than' ordering type.


