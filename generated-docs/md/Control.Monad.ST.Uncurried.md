## Module Control.Monad.ST.Uncurried

This module defines types for STf uncurried functions, as well as
functions for converting back and forth between them.

The general naming scheme for functions and types in this module is as
follows:

* `STFn{N}` means, an uncurried function which accepts N arguments and
  performs some STs. The first N arguments are the actual function's
  argument. The last type argument is the return type.
* `runSTFn{N}` takes an `STFn` of N arguments, and converts it into
  the normal PureScript form: a curried function which returns an ST
  action.
* `mkSTFn{N}` is the inverse of `runSTFn{N}`. It can be useful for
  callbacks.


#### `STFn1`

``` purescript
data STFn1 t0 t1 t2
```

#### `STFn2`

``` purescript
data STFn2 t0 t1 t2 t3
```

#### `STFn3`

``` purescript
data STFn3 t0 t1 t2 t3 t4
```

#### `STFn4`

``` purescript
data STFn4 t0 t1 t2 t3 t4 t5
```

#### `STFn5`

``` purescript
data STFn5 t0 t1 t2 t3 t4 t5 t6
```

#### `STFn6`

``` purescript
data STFn6 t0 t1 t2 t3 t4 t5 t6 t7
```

#### `STFn7`

``` purescript
data STFn7 t0 t1 t2 t3 t4 t5 t6 t7 t8
```

#### `STFn8`

``` purescript
data STFn8 t0 t1 t2 t3 t4 t5 t6 t7 t8 t9
```

#### `STFn9`

``` purescript
data STFn9 t0 t1 t2 t3 t4 t5 t6 t7 t8 t9 t10
```

#### `STFn10`

``` purescript
data STFn10 t0 t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11
```

#### `mkSTFn1`

``` purescript
mkSTFn1 :: forall a t r. (a -> ST t r) -> STFn1 a t r
```

#### `mkSTFn2`

``` purescript
mkSTFn2 :: forall a b t r. (a -> b -> ST t r) -> STFn2 a b t r
```

#### `mkSTFn3`

``` purescript
mkSTFn3 :: forall a b c t r. (a -> b -> c -> ST t r) -> STFn3 a b c t r
```

#### `mkSTFn4`

``` purescript
mkSTFn4 :: forall a b c d t r. (a -> b -> c -> d -> ST t r) -> STFn4 a b c d t r
```

#### `mkSTFn5`

``` purescript
mkSTFn5 :: forall a b c d e t r. (a -> b -> c -> d -> e -> ST t r) -> STFn5 a b c d e t r
```

#### `mkSTFn6`

``` purescript
mkSTFn6 :: forall a b c d e f t r. (a -> b -> c -> d -> e -> f -> ST t r) -> STFn6 a b c d e f t r
```

#### `mkSTFn7`

``` purescript
mkSTFn7 :: forall a b c d e f g t r. (a -> b -> c -> d -> e -> f -> g -> ST t r) -> STFn7 a b c d e f g t r
```

#### `mkSTFn8`

``` purescript
mkSTFn8 :: forall a b c d e f g h t r. (a -> b -> c -> d -> e -> f -> g -> h -> ST t r) -> STFn8 a b c d e f g h t r
```

#### `mkSTFn9`

``` purescript
mkSTFn9 :: forall a b c d e f g h i t r. (a -> b -> c -> d -> e -> f -> g -> h -> i -> ST t r) -> STFn9 a b c d e f g h i t r
```

#### `mkSTFn10`

``` purescript
mkSTFn10 :: forall a b c d e f g h i j t r. (a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> ST t r) -> STFn10 a b c d e f g h i j t r
```

#### `runSTFn1`

``` purescript
runSTFn1 :: forall a t r. STFn1 a t r -> a -> ST t r
```

#### `runSTFn2`

``` purescript
runSTFn2 :: forall a b t r. STFn2 a b t r -> a -> b -> ST t r
```

#### `runSTFn3`

``` purescript
runSTFn3 :: forall a b c t r. STFn3 a b c t r -> a -> b -> c -> ST t r
```

#### `runSTFn4`

``` purescript
runSTFn4 :: forall a b c d t r. STFn4 a b c d t r -> a -> b -> c -> d -> ST t r
```

#### `runSTFn5`

``` purescript
runSTFn5 :: forall a b c d e t r. STFn5 a b c d e t r -> a -> b -> c -> d -> e -> ST t r
```

#### `runSTFn6`

``` purescript
runSTFn6 :: forall a b c d e f t r. STFn6 a b c d e f t r -> a -> b -> c -> d -> e -> f -> ST t r
```

#### `runSTFn7`

``` purescript
runSTFn7 :: forall a b c d e f g t r. STFn7 a b c d e f g t r -> a -> b -> c -> d -> e -> f -> g -> ST t r
```

#### `runSTFn8`

``` purescript
runSTFn8 :: forall a b c d e f g h t r. STFn8 a b c d e f g h t r -> a -> b -> c -> d -> e -> f -> g -> h -> ST t r
```

#### `runSTFn9`

``` purescript
runSTFn9 :: forall a b c d e f g h i t r. STFn9 a b c d e f g h i t r -> a -> b -> c -> d -> e -> f -> g -> h -> i -> ST t r
```

#### `runSTFn10`

``` purescript
runSTFn10 :: forall a b c d e f g h i j t r. STFn10 a b c d e f g h i j t r -> a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> ST t r
```


