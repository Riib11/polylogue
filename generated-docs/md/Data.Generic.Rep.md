## Module Data.Generic.Rep

#### `Generic`

``` purescript
class Generic a rep | a -> rep where
  to :: rep -> a
  from :: a -> rep
```

The `Generic` class asserts the existence of a type function from types
to their representations using the type constructors defined in this module.

#### `repOf`

``` purescript
repOf :: forall a rep. Generic a rep => Proxy a -> Proxy rep
```

#### `NoConstructors`

``` purescript
newtype NoConstructors
```

A representation for types with no constructors.

#### `NoArguments`

``` purescript
data NoArguments
  = NoArguments
```

A representation for constructors with no arguments.

##### Instances
``` purescript
Show NoArguments
```

#### `Sum`

``` purescript
data Sum a b
  = Inl a
  | Inr b
```

A representation for types with multiple constructors.

##### Instances
``` purescript
(Show a, Show b) => Show (Sum a b)
```

#### `Product`

``` purescript
data Product a b
  = Product a b
```

A representation for constructors with multiple fields.

##### Instances
``` purescript
(Show a, Show b) => Show (Product a b)
```

#### `Constructor`

``` purescript
newtype Constructor (name :: Symbol) a
  = Constructor a
```

A representation for constructors which includes the data constructor name
as a type-level string.

##### Instances
``` purescript
(IsSymbol name, Show a) => Show (Constructor name a)
```

#### `Argument`

``` purescript
newtype Argument a
  = Argument a
```

A representation for an argument in a data constructor.

##### Instances
``` purescript
(Show a) => Show (Argument a)
```


