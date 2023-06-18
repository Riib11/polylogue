## Module Control.MonadPlus

#### `MonadPlus`

``` purescript
class (Monad m, Alternative m) <= MonadPlus m 
```

The `MonadPlus` type class has no members of its own; it just specifies
that the type has both `Monad` and `Alternative` instances.

Types which have `MonadPlus` instances should also satisfy the following
law:

- Distributivity: `(x <|> y) >>= f == (x >>= f) <|> (y >>= f)`

##### Instances
``` purescript
MonadPlus Array
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

### Re-exported from Control.Alternative:

#### `Alternative`

``` purescript
class (Applicative f, Plus f) <= Alternative f 
```

The `Alternative` type class has no members of its own; it just specifies
that the type constructor has both `Applicative` and `Plus` instances.

Types which have `Alternative` instances should also satisfy the following
laws:

- Distributivity: `(f <|> g) <*> x == (f <*> x) <|> (g <*> x)`
- Annihilation: `empty <*> f = empty`

##### Instances
``` purescript
Alternative Array
```

#### `guard`

``` purescript
guard :: forall m. Alternative m => Boolean -> m Unit
```

Fail using `Plus` if a condition does not hold, or
succeed using `Applicative` if it does.

For example:

```purescript
import Prelude
import Control.Alternative (guard)
import Data.Array ((..))

factors :: Int -> Array Int
factors n = do
  a <- 1..n
  b <- 1..n
  guard $ a * b == n
  pure a
```

### Re-exported from Control.Applicative:

#### `Applicative`

``` purescript
class (Apply f) <= Applicative f  where
  pure :: forall a. a -> f a
```

The `Applicative` type class extends the [`Apply`](#apply) type class
with a `pure` function, which can be used to create values of type `f a`
from values of type `a`.

Where [`Apply`](#apply) provides the ability to lift functions of two or
more arguments to functions whose arguments are wrapped using `f`, and
[`Functor`](#functor) provides the ability to lift functions of one
argument, `pure` can be seen as the function which lifts functions of
_zero_ arguments. That is, `Applicative` functors support a lifting
operation for any number of function arguments.

Instances must satisfy the following laws in addition to the `Apply`
laws:

- Identity: `(pure identity) <*> v = v`
- Composition: `pure (<<<) <*> f <*> g <*> h = f <*> (g <*> h)`
- Homomorphism: `(pure f) <*> (pure x) = pure (f x)`
- Interchange: `u <*> (pure y) = (pure (_ $ y)) <*> u`

##### Instances
``` purescript
Applicative (Function r)
Applicative Array
Applicative Proxy
```

#### `when`

``` purescript
when :: forall m. Applicative m => Boolean -> m Unit -> m Unit
```

Perform an applicative action when a condition is true.

#### `unless`

``` purescript
unless :: forall m. Applicative m => Boolean -> m Unit -> m Unit
```

Perform an applicative action unless a condition is true.

#### `liftA1`

``` purescript
liftA1 :: forall f a b. Applicative f => (a -> b) -> f a -> f b
```

`liftA1` provides a default implementation of `(<$>)` for any
[`Applicative`](#applicative) functor, without using `(<$>)` as provided
by the [`Functor`](#functor)-[`Applicative`](#applicative) superclass
relationship.

`liftA1` can therefore be used to write [`Functor`](#functor) instances
as follows:

```purescript
instance functorF :: Functor F where
  map = liftA1
```

### Re-exported from Control.Apply:

#### `Apply`

``` purescript
class (Functor f) <= Apply f  where
  apply :: forall a b. f (a -> b) -> f a -> f b
```

The `Apply` class provides the `(<*>)` which is used to apply a function
to an argument under a type constructor.

`Apply` can be used to lift functions of two or more arguments to work on
values wrapped with the type constructor `f`. It might also be understood
in terms of the `lift2` function:

```purescript
lift2 :: forall f a b c. Apply f => (a -> b -> c) -> f a -> f b -> f c
lift2 f a b = f <$> a <*> b
```

`(<*>)` is recovered from `lift2` as `lift2 ($)`. That is, `(<*>)` lifts
the function application operator `($)` to arguments wrapped with the
type constructor `f`.

Put differently...
```
foo =
  functionTakingNArguments <$> computationProducingArg1
                           <*> computationProducingArg2
                           <*> ...
                           <*> computationProducingArgN
```

Instances must satisfy the following law in addition to the `Functor`
laws:

- Associative composition: `(<<<) <$> f <*> g <*> h = f <*> (g <*> h)`

Formally, `Apply` represents a strong lax semi-monoidal endofunctor.

##### Instances
``` purescript
Apply (Function r)
Apply Array
Apply Proxy
```

#### `(<*>)`

``` purescript
infixl 4 apply as <*>
```

#### `(<*)`

``` purescript
infixl 4 applyFirst as <*
```

#### `(*>)`

``` purescript
infixl 4 applySecond as *>
```

### Re-exported from Control.Bind:

#### `Bind`

``` purescript
class (Apply m) <= Bind m  where
  bind :: forall a b. m a -> (a -> m b) -> m b
```

The `Bind` type class extends the [`Apply`](#apply) type class with a
"bind" operation `(>>=)` which composes computations in sequence, using
the return value of one computation to determine the next computation.

The `>>=` operator can also be expressed using `do` notation, as follows:

```purescript
x >>= f = do y <- x
             f y
```

where the function argument of `f` is given the name `y`.

Instances must satisfy the following laws in addition to the `Apply`
laws:

- Associativity: `(x >>= f) >>= g = x >>= (\k -> f k >>= g)`
- Apply Superclass: `apply f x = f >>= \f’ -> map f’ x`

Associativity tells us that we can regroup operations which use `do`
notation so that we can unambiguously write, for example:

```purescript
do x <- m1
   y <- m2 x
   m3 x y
```

##### Instances
``` purescript
Bind (Function r)
Bind Array
Bind Proxy
```

#### `join`

``` purescript
join :: forall a m. Bind m => m (m a) -> m a
```

Collapse two applications of a monadic type constructor into one.

#### `ifM`

``` purescript
ifM :: forall a m. Bind m => m Boolean -> m a -> m a -> m a
```

Execute a monadic action if a condition holds.

For example:

```purescript
main = ifM ((< 0.5) <$> random)
         (trace "Heads")
         (trace "Tails")
```

#### `(>>=)`

``` purescript
infixl 1 bind as >>=
```

#### `(>=>)`

``` purescript
infixr 1 composeKleisli as >=>
```

#### `(=<<)`

``` purescript
infixr 1 bindFlipped as =<<
```

#### `(<=<)`

``` purescript
infixr 1 composeKleisliFlipped as <=<
```

### Re-exported from Control.Monad:

#### `Monad`

``` purescript
class (Applicative m, Bind m) <= Monad m 
```

The `Monad` type class combines the operations of the `Bind` and
`Applicative` type classes. Therefore, `Monad` instances represent type
constructors which support sequential composition, and also lifting of
functions of arbitrary arity.

Instances must satisfy the following laws in addition to the
`Applicative` and `Bind` laws:

- Left Identity: `pure x >>= f = f x`
- Right Identity: `x >>= pure = x`

##### Instances
``` purescript
Monad (Function r)
Monad Array
Monad Proxy
```

#### `liftM1`

``` purescript
liftM1 :: forall m a b. Monad m => (a -> b) -> m a -> m b
```

`liftM1` provides a default implementation of `(<$>)` for any
[`Monad`](#monad), without using `(<$>)` as provided by the
[`Functor`](#functor)-[`Monad`](#monad) superclass relationship.

`liftM1` can therefore be used to write [`Functor`](#functor) instances
as follows:

```purescript
instance functorF :: Functor F where
  map = liftM1
```

#### `ap`

``` purescript
ap :: forall m a b. Monad m => m (a -> b) -> m a -> m b
```

`ap` provides a default implementation of `(<*>)` for any `Monad`, without
using `(<*>)` as provided by the `Apply`-`Monad` superclass relationship.

`ap` can therefore be used to write `Apply` instances as follows:

```purescript
instance applyF :: Apply F where
  apply = ap
```

### Re-exported from Control.Plus:

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

