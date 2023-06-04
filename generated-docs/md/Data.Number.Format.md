## Module Data.Number.Format

A module for formatting numbers as strings.

Usage:
``` purs
> let x = 1234.56789

> toStringWith (precision 6) x
"1234.57"

> toStringWith (fixed 3) x
"1234.568"

> toStringWith (exponential 2) x
"1.23e+3"
```

The main method of this module is the `toStringWith` function that accepts
a `Format` argument which can be constructed through one of the smart
constructors `precision`, `fixed` and `exponential`. Internally, the
number will be formatted with JavaScripts `toPrecision`, `toFixed` or
`toExponential`.

#### `Format`

``` purescript
data Format
```

The `Format` data type specifies how a number will be formatted.

#### `precision`

``` purescript
precision :: Int -> Format
```

Create a `toPrecision`-based format from an integer. Values smaller than
`1` and larger than `21` will be clamped.

#### `fixed`

``` purescript
fixed :: Int -> Format
```

Create a `toFixed`-based format from an integer. Values smaller than `0`
and larger than `20` will be clamped.

#### `exponential`

``` purescript
exponential :: Int -> Format
```

Create a `toExponential`-based format from an integer. Values smaller than
`0` and larger than `20` will be clamped.

#### `toStringWith`

``` purescript
toStringWith :: Format -> Number -> String
```

Convert a number to a string with a given format.

#### `toString`

``` purescript
toString :: Number -> String
```

Convert a number to a string via JavaScript's toString method.

```purs
> toString 12.34
"12.34"

> toString 1234.0
"1234"

> toString 1.2e-10
"1.2e-10"
```


