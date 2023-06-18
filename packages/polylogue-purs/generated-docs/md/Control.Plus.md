## Module Control.Plus

#### `Plus`

``` purescript
class (Alt f) <= Plus f  where
  empty :: forall a. f a
```

The `Plus` type class extends the `Alt` type class with a value that
should be the left and right identity for `(<|>)`.

It is similar to `Monoid`, except that it applies to types of
kind `* -> *`, like `Array` or `List`, rather than concrete types like
`String` or `Number`.

`Plus` instances should satisfy the following laws:

- Left identity: `empty <|> x == x`
- Right identity: `x <|> empty == x`
- Annihilation: `f <$> empty == empty`

##### Instances
``` purescript
Plus Array
```


### Re-exported from Control.Alt:

#### `Alt`

``` purescript
class (Functor f) <= Alt f  where
  alt :: forall a. f a -> f a -> f a
```

The `Alt` type class identifies an associative operation on a type
constructor.  It is similar to `Semigroup`, except that it applies to
types of kind `* -> *`, like `Array` or `List`, rather than concrete types
`String` or `Number`.

`Alt` instances are required to satisfy the following laws:

- Associativity: `(x <|> y) <|> z == x <|> (y <|> z)`
- Distributivity: `f <$> (x <|> y) == (f <$> x) <|> (f <$> y)`

For example, the `Array` (`[]`) type is an instance of `Alt`, where
`(<|>)` is defined to be concatenation.

A common use case is to select the first "valid" item, or, if all items
are "invalid", the last "invalid" item.

For example:

```purescript
import Control.Alt ((<|>))
import Data.Maybe (Maybe(..)
import Data.Either (Either(..))

Nothing <|> Just 1 <|> Just 2 == Just 1
Left "err" <|> Right 1 <|> Right 2 == Right 1
Left "err 1" <|> Left "err 2" <|> Left "err 3" == Left "err 3"
```

##### Instances
``` purescript
Alt Array
```

#### `(<|>)`

``` purescript
infixr 3 alt as <|>
```

### Re-exported from Data.Functor:

#### `Functor`

``` purescript
class Functor f  where
  map :: forall a b. (a -> b) -> f a -> f b
```

A `Functor` is a type constructor which supports a mapping operation
`map`.

`map` can be used to turn functions `a -> b` into functions
`f a -> f b` whose argument and return types use the type constructor `f`
to represent some computational context.

Instances must satisfy the following laws:

- Identity: `map identity = identity`
- Composition: `map (f <<< g) = map f <<< map g`

##### Instances
``` purescript
Functor (Function r)
Functor Array
Functor Proxy
```

#### `void`

``` purescript
void :: forall f a. Functor f => f a -> f Unit
```

The `void` function is used to ignore the type wrapped by a
[`Functor`](#functor), replacing it with `Unit` and keeping only the type
information provided by the type constructor itself.

`void` is often useful when using `do` notation to change the return type
of a monadic computation:

```purescript
main = forE 1 10 \n -> void do
  print n
  print (n * n)
```

#### `(<$>)`

``` purescript
infixl 4 map as <$>
```

#### `(<$)`

``` purescript
infixl 4 voidRight as <$
```

#### `(<#>)`

``` purescript
infixl 1 mapFlipped as <#>
```

#### `($>)`

``` purescript
infixl 4 voidLeft as $>
```

