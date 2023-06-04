## Module Control.Category

#### `Category`

``` purescript
class (Semigroupoid a) <= Category a  where
  identity :: forall t. a t t
```

`Category`s consist of objects and composable morphisms between them, and
as such are [`Semigroupoids`](#semigroupoid), but unlike `semigroupoids`
must have an identity element.

Instances must satisfy the following law in addition to the
`Semigroupoid` law:

- Identity: `identity <<< p = p <<< identity = p`

##### Instances
``` purescript
Category Function
```


### Re-exported from Control.Semigroupoid:

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

#### `(>>>)`

``` purescript
infixr 9 composeFlipped as >>>
```

#### `(<<<)`

``` purescript
infixr 9 compose as <<<
```

