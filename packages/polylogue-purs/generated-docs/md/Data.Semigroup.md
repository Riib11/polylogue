## Module Data.Semigroup

#### `Semigroup`

``` purescript
class Semigroup a  where
  append :: a -> a -> a
```

The `Semigroup` type class identifies an associative operation on a type.

Instances are required to satisfy the following law:

- Associativity: `(x <> y) <> z = x <> (y <> z)`

One example of a `Semigroup` is `String`, with `(<>)` defined as string
concatenation. Another example is `List a`, with `(<>)` defined as
list concatenation.

### Newtypes for Semigroup

There are two other ways to implement an instance for this type class
regardless of which type is used. These instances can be used by
wrapping the values in one of the two newtypes below:
1. `First` - Use the first argument every time: `append first _ = first`.
2. `Last` - Use the last argument every time: `append _ last = last`.

##### Instances
``` purescript
Semigroup String
Semigroup Unit
Semigroup Void
(Semigroup s') => Semigroup (s -> s')
Semigroup (Array a)
Semigroup (Proxy a)
(RowToList row list, SemigroupRecord list row row) => Semigroup (Record row)
```

#### `(<>)`

``` purescript
infixr 5 append as <>
```

#### `SemigroupRecord`

``` purescript
class SemigroupRecord rowlist row subrow | rowlist -> subrow where
  appendRecord :: Proxy rowlist -> Record row -> Record row -> Record subrow
```

A class for records where all fields have `Semigroup` instances, used to
implement the `Semigroup` instance for records.

##### Instances
``` purescript
SemigroupRecord Nil row ()
(IsSymbol key, Cons key focus subrowTail subrow, SemigroupRecord rowlistTail row subrowTail, Semigroup focus) => SemigroupRecord (Cons key focus rowlistTail) row subrow
```


