## Module Foreign.Index

This module defines a type class for types which act like
_property indices_.

#### `Index`

``` purescript
class Index i m | i -> m where
  index :: Foreign -> i -> ExceptT (NonEmptyList ForeignError) m Foreign
  hasProperty :: i -> Foreign -> Boolean
  hasOwnProperty :: i -> Foreign -> Boolean
  errorAt :: i -> ForeignError -> ForeignError
```

This type class identifies types that act like _property indices_.

The canonical instances are for `String`s and `Int`s.

##### Instances
``` purescript
(Monad m) => Index String m
(Monad m) => Index Int m
```

#### `Indexable`

``` purescript
class Indexable a m | a -> m where
  ix :: forall i. Index i m => a -> i -> ExceptT (NonEmptyList ForeignError) m Foreign
```

##### Instances
``` purescript
(Monad m) => Indexable Foreign m
(Monad m) => Indexable (ExceptT (NonEmptyList ForeignError) m Foreign) m
```

#### `readProp`

``` purescript
readProp :: forall m. Monad m => String -> Foreign -> ExceptT (NonEmptyList ForeignError) m Foreign
```

Attempt to read a value from a foreign value property

#### `readIndex`

``` purescript
readIndex :: forall m. Monad m => Int -> Foreign -> ExceptT (NonEmptyList ForeignError) m Foreign
```

Attempt to read a value from a foreign value at the specified numeric index

#### `(!)`

``` purescript
infixl 9 ix as !
```


