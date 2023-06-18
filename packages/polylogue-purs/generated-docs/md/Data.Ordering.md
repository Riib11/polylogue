## Module Data.Ordering

#### `Ordering`

``` purescript
data Ordering
  = LT
  | GT
  | EQ
```

The `Ordering` data type represents the three possible outcomes of
comparing two values:

`LT` - The first value is _less than_ the second.
`GT` - The first value is _greater than_ the second.
`EQ` - The first value is _equal to_ the second.

##### Instances
``` purescript
Eq Ordering
Semigroup Ordering
Show Ordering
```

#### `invert`

``` purescript
invert :: Ordering -> Ordering
```

Reverses an `Ordering` value, flipping greater than for less than while
preserving equality.


