## Module Data.Functor.Contravariant

#### `Contravariant`

``` purescript
class Contravariant f  where
  cmap :: forall a b. (b -> a) -> f a -> f b
```

A `Contravariant` functor can be seen as a way of changing the input type
of a consumer of input, in contrast to the standard covariant `Functor`
that can be seen as a way of changing the output type of a producer of
output.

`Contravariant` instances should satisfy the following laws:

- Identity `cmap id = id`
- Composition `cmap f <<< cmap g = cmap (g <<< f)`

##### Instances
``` purescript
Contravariant (Const a)
```

#### `(>$<)`

``` purescript
infixl 4 cmap as >$<
```

#### `cmapFlipped`

``` purescript
cmapFlipped :: forall a b f. Contravariant f => f a -> (b -> a) -> f b
```

`cmapFlipped` is `cmap` with its arguments reversed.

#### `(>#<)`

``` purescript
infixl 4 cmapFlipped as >#<
```

#### `coerce`

``` purescript
coerce :: forall f a b. Contravariant f => Functor f => f a -> f b
```

#### `imapC`

``` purescript
imapC :: forall f a b. Contravariant f => (a -> b) -> (b -> a) -> f a -> f b
```

As all `Contravariant` functors are also trivially `Invariant`, this function can be used as the `imap` implementation for any types that have an existing `Contravariant` instance.


