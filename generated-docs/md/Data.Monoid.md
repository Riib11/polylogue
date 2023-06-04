## Module Data.Monoid

#### `Monoid`

``` purescript
class (Semigroup m) <= Monoid m  where
  mempty :: m
```

A `Monoid` is a `Semigroup` with a value `mempty`, which is both a
left and right unit for the associative operation `<>`:

- Left unit: `(mempty <> x) = x`
- Right unit: `(x <> mempty) = x`

`Monoid`s are commonly used as the result of fold operations, where
`<>` is used to combine individual results, and `mempty` gives the result
of folding an empty collection of elements.

### Newtypes for Monoid

Some types (e.g. `Int`, `Boolean`) can implement multiple law-abiding
instances for `Monoid`. Let's use `Int` as an example
1. `<>` could be `+` and `mempty` could be `0`
2. `<>` could be `*` and `mempty` could be `1`.

To clarify these ambiguous situations, one should use the newtypes
defined in `Data.Monoid.<NewtypeName>` modules.

In the above ambiguous situation, we could use `Additive`
for the first situation or `Multiplicative` for the second one.

##### Instances
``` purescript
Monoid Unit
Monoid Ordering
(Monoid b) => Monoid (a -> b)
Monoid String
Monoid (Array a)
(RowToList row list, MonoidRecord list row row) => Monoid (Record row)
```

#### `power`

``` purescript
power :: forall m. Monoid m => m -> Int -> m
```

Append a value to itself a certain number of times. For the
`Multiplicative` type, and for a non-negative power, this is the same as
normal number exponentiation.

If the second argument is negative this function will return `mempty`
(*unlike* normal number exponentiation). The `Monoid` constraint alone
is not enough to write a `power` function with the property that `power x
n` cancels with `power x (-n)`, i.e. `power x n <> power x (-n) = mempty`.
For that, we would additionally need the ability to invert elements, i.e.
a Group.

```purescript
power [1,2] 3    == [1,2,1,2,1,2]
power [1,2] 1    == [1,2]
power [1,2] 0    == []
power [1,2] (-3) == []
```


#### `guard`

``` purescript
guard :: forall m. Monoid m => Boolean -> m -> m
```

Allow or "truncate" a Monoid to its `mempty` value based on a condition.

#### `MonoidRecord`

``` purescript
class (SemigroupRecord rowlist row subrow) <= MonoidRecord rowlist row subrow | rowlist -> row subrow where
  memptyRecord :: Proxy rowlist -> Record subrow
```

A class for records where all fields have `Monoid` instances, used to
implement the `Monoid` instance for records.

##### Instances
``` purescript
MonoidRecord Nil row ()
(IsSymbol key, Monoid focus, Cons key focus subrowTail subrow, MonoidRecord rowlistTail row subrowTail) => MonoidRecord (Cons key focus rowlistTail) row subrow
```


### Re-exported from Data.Semigroup:

#### `Semigroup`

``` purescript
class Semigroup a 
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

#### `SemigroupRecord`

``` purescript
class SemigroupRecord rowlist row subrow | rowlist -> subrow
```

A class for records where all fields have `Semigroup` instances, used to
implement the `Semigroup` instance for records.

##### Instances
``` purescript
SemigroupRecord Nil row ()
(IsSymbol key, Cons key focus subrowTail subrow, SemigroupRecord rowlistTail row subrowTail, Semigroup focus) => SemigroupRecord (Cons key focus rowlistTail) row subrow
```

#### `(<>)`

``` purescript
infixr 5 append as <>
```

