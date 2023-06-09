## Module Record.Unsafe

The functions in this module are highly unsafe as they treat records like
stringly-keyed maps and can coerce the row of labels that a record has.

These function are intended for situations where there is some other way of
proving things about the structure of the record - for example, when using
`RowToList`. **They should never be used for general record manipulation.**

#### `unsafeHas`

``` purescript
unsafeHas :: forall r1. String -> Record r1 -> Boolean
```

Checks if a record has a key, using a string for the key.

#### `unsafeGet`

``` purescript
unsafeGet :: forall r a. String -> Record r -> a
```

Unsafely gets a value from a record, using a string for the key.

If the key does not exist this will cause a runtime error elsewhere.

#### `unsafeSet`

``` purescript
unsafeSet :: forall r1 r2 a. String -> a -> Record r1 -> Record r2
```

Unsafely sets a value on a record, using a string for the key.

The output record's row is unspecified so can be coerced to any row. If the
output type is incorrect it will cause a runtime error elsewhere.

#### `unsafeDelete`

``` purescript
unsafeDelete :: forall r1 r2. String -> Record r1 -> Record r2
```

Unsafely removes a value on a record, using a string for the key.

The output record's row is unspecified so can be coerced to any row. If the
output type is incorrect it will cause a runtime error elsewhere.


