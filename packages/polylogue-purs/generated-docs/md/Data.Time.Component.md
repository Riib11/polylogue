## Module Data.Time.Component

#### `Hour`

``` purescript
newtype Hour
```

An hour component for a time value.

The constructor is private as values for the type are restricted to the
range 0 to 23, inclusive. The `toEnum` function can be used to safely
acquire an `Hour` value from an integer. Correspondingly, an `Hour` can be
lowered to a plain integer with the `fromEnum` function.

##### Instances
``` purescript
Eq Hour
Ord Hour
Bounded Hour
Enum Hour
BoundedEnum Hour
Show Hour
```

#### `Minute`

``` purescript
newtype Minute
```

An minute component for a time value.

The constructor is private as values for the type are restricted to the
range 0 to 59, inclusive. The `toEnum` function can be used to safely
acquire an `Minute` value from an integer. Correspondingly, a `Minute` can
be lowered to a plain integer with the `fromEnum` function.

##### Instances
``` purescript
Eq Minute
Ord Minute
Bounded Minute
Enum Minute
BoundedEnum Minute
Show Minute
```

#### `Second`

``` purescript
newtype Second
```

An second component for a time value.

The constructor is private as values for the type are restricted to the
range 0 to 59, inclusive. The `toEnum` function can be used to safely
acquire an `Second` value from an integer. Correspondingly, a `Second` can
be lowered to a plain integer with the `fromEnum` function.

##### Instances
``` purescript
Eq Second
Ord Second
Bounded Second
Enum Second
BoundedEnum Second
Show Second
```

#### `Millisecond`

``` purescript
newtype Millisecond
```

An millisecond component for a time value.

The constructor is private as values for the type are restricted to the
range 0 to 999, inclusive. The `toEnum` function can be used to safely
acquire an `Millisecond` value from an integer. Correspondingly, a
`Millisecond` can be lowered to a plain integer with the `fromEnum`
function.

##### Instances
``` purescript
Eq Millisecond
Ord Millisecond
Bounded Millisecond
Enum Millisecond
BoundedEnum Millisecond
Show Millisecond
```


