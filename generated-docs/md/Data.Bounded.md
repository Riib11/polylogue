## Module Data.Bounded

#### `Bounded`

``` purescript
class (Ord a) <= Bounded a  where
  top :: a
  bottom :: a
```

The `Bounded` type class represents totally ordered types that have an
upper and lower boundary.

Instances should satisfy the following law in addition to the `Ord` laws:

- Bounded: `bottom <= a <= top`

##### Instances
``` purescript
Bounded Boolean
Bounded Int
Bounded Char
Bounded Ordering
Bounded Unit
Bounded Number
Bounded (Proxy a)
(RowToList row list, BoundedRecord list row row) => Bounded (Record row)
```

#### `BoundedRecord`

``` purescript
class (OrdRecord rowlist row) <= BoundedRecord rowlist row subrow | rowlist -> subrow where
  topRecord :: Proxy rowlist -> Proxy row -> Record subrow
  bottomRecord :: Proxy rowlist -> Proxy row -> Record subrow
```

##### Instances
``` purescript
BoundedRecord Nil row ()
(IsSymbol key, Bounded focus, Cons key focus rowTail row, Cons key focus subrowTail subrow, BoundedRecord rowlistTail row subrowTail) => BoundedRecord (Cons key focus rowlistTail) row subrow
```


### Re-exported from Data.Ord:

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

#### `Ord`

``` purescript
class (Eq a) <= Ord a  where
  compare :: a -> a -> Ordering
```

The `Ord` type class represents types which support comparisons with a
_total order_.

`Ord` instances should satisfy the laws of total orderings:

- Reflexivity: `a <= a`
- Antisymmetry: if `a <= b` and `b <= a` then `a == b`
- Transitivity: if `a <= b` and `b <= c` then `a <= c`

**Note:** The `Number` type is not an entirely law abiding member of this
class due to the presence of `NaN`, since `NaN <= NaN` evaluates to `false`

##### Instances
``` purescript
Ord Boolean
Ord Int
Ord Number
Ord String
Ord Char
Ord Unit
Ord Void
Ord (Proxy a)
(Ord a) => Ord (Array a)
Ord Ordering
(RowToList row list, OrdRecord list row) => Ord (Record row)
```

#### `OrdRecord`

``` purescript
class (EqRecord rowlist row) <= OrdRecord rowlist row 
```

##### Instances
``` purescript
OrdRecord Nil row
(OrdRecord rowlistTail row, Cons key focus rowTail row, IsSymbol key, Ord focus) => OrdRecord (Cons key focus rowlistTail) row
```

#### `(>=)`

``` purescript
infixl 4 greaterThanOrEq as >=
```

#### `(>)`

``` purescript
infixl 4 greaterThan as >
```

#### `(<=)`

``` purescript
infixl 4 lessThanOrEq as <=
```

#### `(<)`

``` purescript
infixl 4 lessThan as <
```

