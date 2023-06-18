## Module Control.Semigroupoid

#### `Semigroupoid`

``` purescript
class Semigroupoid a  where
  compose :: forall b c d. a c d -> a b c -> a b d
```

A `Semigroupoid` is similar to a [`Category`](#category) but does not
require an identity element `identity`, just composable morphisms.

`Semigroupoid`s must satisfy the following law:

- Associativity: `p <<< (q <<< r) = (p <<< q) <<< r`

One example of a `Semigroupoid` is the function type constructor `(->)`,
with `(<<<)` defined as function composition.

##### Instances
``` purescript
Semigroupoid Function
```

#### `(<<<)`

``` purescript
infixr 9 compose as <<<
```

#### `composeFlipped`

``` purescript
composeFlipped :: forall a b c d. Semigroupoid a => a b c -> a c d -> a b d
```

Forwards composition, or `compose` with its arguments reversed.

#### `(>>>)`

``` purescript
infixr 9 composeFlipped as >>>
```


