## Module Data.Tuple.Nested

Tuples that are not restricted to two elements.

Here is an example of a 3-tuple:


```purescript
> tuple = tuple3 1 "2" 3.0
> tuple
(Tuple 1 (Tuple "2" (Tuple 3.0 unit)))
```

Notice that a tuple is a nested structure not unlike a list. The type of `tuple` is this:

```purescript
> :t tuple
Tuple Int (Tuple String (Tuple Number Unit))
```

That, however, can be abbreviated with the `Tuple3` type:

```purescript
Tuple3 Int String Number
```

All tuple functions are numbered from 1 to 10. That is, there's
a `get1` and a `get10`.

The `getN` functions accept tuples of length N or greater:

```purescript
get1 tuple = 1
get3 tuple = 3
get4 tuple -- type error. `get4` requires a longer tuple. 
```

The same is true of the `overN` functions:

```purescript
over2 negate (tuple3 1 2 3) = tuple3 1 (-2) 3
```

`uncurryN` can be used to convert a function that takes `N` arguments to one that takes an N-tuple:

```purescript
uncurry2 (+) (tuple2 1 2) = 3
```

The reverse `curryN` function converts functions that take
N-tuples (which are rare) to functions that take `N` arguments.

---------------
In addition to types like `Tuple3`, there are also types like
`T3`. Whereas `Tuple3` describes a tuple with exactly three
elements, `T3` describes a tuple of length *two or longer*. More
specifically, `T3` requires two element plus a "tail" that may be
`unit` or more tuple elements. Use types like `T3` when you want to
create a set of functions for arbitrary tuples. See the source for how that's done.


#### `(/\)`

``` purescript
infixr 6 Tuple as /\
```

Shorthand for constructing n-tuples as nested pairs.
`a /\ b /\ c /\ d /\ unit` becomes `Tuple a (Tuple b (Tuple c (Tuple d unit)))`

#### `type (/\)`

``` purescript
infixr 6 type Tuple as ype (/\
```

Shorthand for constructing n-tuple types as nested pairs.
`forall a b c d. a /\ b /\ c /\ d /\ Unit` becomes
`forall a b c d. Tuple a (Tuple b (Tuple c (Tuple d Unit)))`

#### `Tuple1`

``` purescript
type Tuple1 a = T2 a Unit
```

#### `Tuple2`

``` purescript
type Tuple2 a b = T3 a b Unit
```

#### `Tuple3`

``` purescript
type Tuple3 a b c = T4 a b c Unit
```

#### `Tuple4`

``` purescript
type Tuple4 a b c d = T5 a b c d Unit
```

#### `Tuple5`

``` purescript
type Tuple5 a b c d e = T6 a b c d e Unit
```

#### `Tuple6`

``` purescript
type Tuple6 a b c d e f = T7 a b c d e f Unit
```

#### `Tuple7`

``` purescript
type Tuple7 a b c d e f g = T8 a b c d e f g Unit
```

#### `Tuple8`

``` purescript
type Tuple8 a b c d e f g h = T9 a b c d e f g h Unit
```

#### `Tuple9`

``` purescript
type Tuple9 a b c d e f g h i = T10 a b c d e f g h i Unit
```

#### `Tuple10`

``` purescript
type Tuple10 a b c d e f g h i j = T11 a b c d e f g h i j Unit
```

#### `T2`

``` purescript
type T2 a z = Tuple a z
```

#### `T3`

``` purescript
type T3 a b z = Tuple a (T2 b z)
```

#### `T4`

``` purescript
type T4 a b c z = Tuple a (T3 b c z)
```

#### `T5`

``` purescript
type T5 a b c d z = Tuple a (T4 b c d z)
```

#### `T6`

``` purescript
type T6 a b c d e z = Tuple a (T5 b c d e z)
```

#### `T7`

``` purescript
type T7 a b c d e f z = Tuple a (T6 b c d e f z)
```

#### `T8`

``` purescript
type T8 a b c d e f g z = Tuple a (T7 b c d e f g z)
```

#### `T9`

``` purescript
type T9 a b c d e f g h z = Tuple a (T8 b c d e f g h z)
```

#### `T10`

``` purescript
type T10 a b c d e f g h i z = Tuple a (T9 b c d e f g h i z)
```

#### `T11`

``` purescript
type T11 a b c d e f g h i j z = Tuple a (T10 b c d e f g h i j z)
```

#### `tuple1`

``` purescript
tuple1 :: forall a. a -> Tuple1 a
```

Creates a singleton tuple.

#### `tuple2`

``` purescript
tuple2 :: forall a b. a -> b -> Tuple2 a b
```

Given 2 values, creates a 2-tuple.

#### `tuple3`

``` purescript
tuple3 :: forall a b c. a -> b -> c -> Tuple3 a b c
```

Given 3 values, creates a nested 3-tuple.

#### `tuple4`

``` purescript
tuple4 :: forall a b c d. a -> b -> c -> d -> Tuple4 a b c d
```

Given 4 values, creates a nested 4-tuple.

#### `tuple5`

``` purescript
tuple5 :: forall a b c d e. a -> b -> c -> d -> e -> Tuple5 a b c d e
```

Given 5 values, creates a nested 5-tuple.

#### `tuple6`

``` purescript
tuple6 :: forall a b c d e f. a -> b -> c -> d -> e -> f -> Tuple6 a b c d e f
```

Given 6 values, creates a nested 6-tuple.

#### `tuple7`

``` purescript
tuple7 :: forall a b c d e f g. a -> b -> c -> d -> e -> f -> g -> Tuple7 a b c d e f g
```

Given 7 values, creates a nested 7-tuple.

#### `tuple8`

``` purescript
tuple8 :: forall a b c d e f g h. a -> b -> c -> d -> e -> f -> g -> h -> Tuple8 a b c d e f g h
```

Given 8 values, creates a nested 8-tuple.

#### `tuple9`

``` purescript
tuple9 :: forall a b c d e f g h i. a -> b -> c -> d -> e -> f -> g -> h -> i -> Tuple9 a b c d e f g h i
```

Given 9 values, creates a nested 9-tuple.

#### `tuple10`

``` purescript
tuple10 :: forall a b c d e f g h i j. a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> Tuple10 a b c d e f g h i j
```

Given 10 values, creates a nested 10-tuple.

#### `get1`

``` purescript
get1 :: forall a z. T2 a z -> a
```

Given at least a singleton tuple, gets the first value.

#### `get2`

``` purescript
get2 :: forall a b z. T3 a b z -> b
```

Given at least a 2-tuple, gets the second value.

#### `get3`

``` purescript
get3 :: forall a b c z. T4 a b c z -> c
```

Given at least a 3-tuple, gets the third value.

#### `get4`

``` purescript
get4 :: forall a b c d z. T5 a b c d z -> d
```

Given at least a 4-tuple, gets the fourth value.

#### `get5`

``` purescript
get5 :: forall a b c d e z. T6 a b c d e z -> e
```

Given at least a 5-tuple, gets the fifth value.

#### `get6`

``` purescript
get6 :: forall a b c d e f z. T7 a b c d e f z -> f
```

Given at least a 6-tuple, gets the sixth value.

#### `get7`

``` purescript
get7 :: forall a b c d e f g z. T8 a b c d e f g z -> g
```

Given at least a 7-tuple, gets the seventh value.

#### `get8`

``` purescript
get8 :: forall a b c d e f g h z. T9 a b c d e f g h z -> h
```

Given at least an 8-tuple, gets the eigth value.

#### `get9`

``` purescript
get9 :: forall a b c d e f g h i z. T10 a b c d e f g h i z -> i
```

Given at least a 9-tuple, gets the ninth value.

#### `get10`

``` purescript
get10 :: forall a b c d e f g h i j z. T11 a b c d e f g h i j z -> j
```

Given at least a 10-tuple, gets the tenth value.

#### `over1`

``` purescript
over1 :: forall a r z. (a -> r) -> T2 a z -> T2 r z
```

Given at least a singleton tuple, modifies the first value.

#### `over2`

``` purescript
over2 :: forall a b r z. (b -> r) -> T3 a b z -> T3 a r z
```

Given at least a 2-tuple, modifies the second value.

#### `over3`

``` purescript
over3 :: forall a b c r z. (c -> r) -> T4 a b c z -> T4 a b r z
```

Given at least a 3-tuple, modifies the third value.

#### `over4`

``` purescript
over4 :: forall a b c d r z. (d -> r) -> T5 a b c d z -> T5 a b c r z
```

Given at least a 4-tuple, modifies the fourth value.

#### `over5`

``` purescript
over5 :: forall a b c d e r z. (e -> r) -> T6 a b c d e z -> T6 a b c d r z
```

Given at least a 5-tuple, modifies the fifth value.

#### `over6`

``` purescript
over6 :: forall a b c d e f r z. (f -> r) -> T7 a b c d e f z -> T7 a b c d e r z
```

Given at least a 6-tuple, modifies the sixth value.

#### `over7`

``` purescript
over7 :: forall a b c d e f g r z. (g -> r) -> T8 a b c d e f g z -> T8 a b c d e f r z
```

Given at least a 7-tuple, modifies the seventh value.

#### `over8`

``` purescript
over8 :: forall a b c d e f g h r z. (h -> r) -> T9 a b c d e f g h z -> T9 a b c d e f g r z
```

Given at least an 8-tuple, modifies the eighth value.

#### `over9`

``` purescript
over9 :: forall a b c d e f g h i r z. (i -> r) -> T10 a b c d e f g h i z -> T10 a b c d e f g h r z
```

Given at least a 9-tuple, modifies the ninth value.

#### `over10`

``` purescript
over10 :: forall a b c d e f g h i j r z. (j -> r) -> T11 a b c d e f g h i j z -> T11 a b c d e f g h i r z
```

Given at least a 10-tuple, modifies the tenth value.

#### `uncurry1`

``` purescript
uncurry1 :: forall a r z. (a -> r) -> T2 a z -> r
```

Given a function of 1 argument, returns a function that accepts a singleton tuple.

#### `uncurry2`

``` purescript
uncurry2 :: forall a b r z. (a -> b -> r) -> T3 a b z -> r
```

Given a function of 2 arguments, returns a function that accepts a 2-tuple.

#### `uncurry3`

``` purescript
uncurry3 :: forall a b c r z. (a -> b -> c -> r) -> T4 a b c z -> r
```

Given a function of 3 arguments, returns a function that accepts a 3-tuple.

#### `uncurry4`

``` purescript
uncurry4 :: forall a b c d r z. (a -> b -> c -> d -> r) -> T5 a b c d z -> r
```

Given a function of 4 arguments, returns a function that accepts a 4-tuple.

#### `uncurry5`

``` purescript
uncurry5 :: forall a b c d e r z. (a -> b -> c -> d -> e -> r) -> T6 a b c d e z -> r
```

Given a function of 5 arguments, returns a function that accepts a 5-tuple.

#### `uncurry6`

``` purescript
uncurry6 :: forall a b c d e f r z. (a -> b -> c -> d -> e -> f -> r) -> T7 a b c d e f z -> r
```

Given a function of 6 arguments, returns a function that accepts a 6-tuple.

#### `uncurry7`

``` purescript
uncurry7 :: forall a b c d e f g r z. (a -> b -> c -> d -> e -> f -> g -> r) -> T8 a b c d e f g z -> r
```

Given a function of 7 arguments, returns a function that accepts a 7-tuple.

#### `uncurry8`

``` purescript
uncurry8 :: forall a b c d e f g h r z. (a -> b -> c -> d -> e -> f -> g -> h -> r) -> T9 a b c d e f g h z -> r
```

Given a function of 8 arguments, returns a function that accepts an 8-tuple.

#### `uncurry9`

``` purescript
uncurry9 :: forall a b c d e f g h i r z. (a -> b -> c -> d -> e -> f -> g -> h -> i -> r) -> T10 a b c d e f g h i z -> r
```

Given a function of 9 arguments, returns a function that accepts a 9-tuple.

#### `uncurry10`

``` purescript
uncurry10 :: forall a b c d e f g h i j r z. (a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> r) -> T11 a b c d e f g h i j z -> r
```

Given a function of 10 arguments, returns a function that accepts a 10-tuple.

#### `curry1`

``` purescript
curry1 :: forall a r z. z -> (T2 a z -> r) -> a -> r
```

Given a function that accepts at least a singleton tuple, returns a function of 1 argument.

#### `curry2`

``` purescript
curry2 :: forall a b r z. z -> (T3 a b z -> r) -> a -> b -> r
```

Given a function that accepts at least a 2-tuple, returns a function of 2 arguments.

#### `curry3`

``` purescript
curry3 :: forall a b c r z. z -> (T4 a b c z -> r) -> a -> b -> c -> r
```

Given a function that accepts at least a 3-tuple, returns a function of 3 arguments.

#### `curry4`

``` purescript
curry4 :: forall a b c d r z. z -> (T5 a b c d z -> r) -> a -> b -> c -> d -> r
```

Given a function that accepts at least a 4-tuple, returns a function of 4 arguments.

#### `curry5`

``` purescript
curry5 :: forall a b c d e r z. z -> (T6 a b c d e z -> r) -> a -> b -> c -> d -> e -> r
```

Given a function that accepts at least a 5-tuple, returns a function of 5 arguments.

#### `curry6`

``` purescript
curry6 :: forall a b c d e f r z. z -> (T7 a b c d e f z -> r) -> a -> b -> c -> d -> e -> f -> r
```

Given a function that accepts at least a 6-tuple, returns a function of 6 arguments.

#### `curry7`

``` purescript
curry7 :: forall a b c d e f g r z. z -> (T8 a b c d e f g z -> r) -> a -> b -> c -> d -> e -> f -> g -> r
```

Given a function that accepts at least a 7-tuple, returns a function of 7 arguments.

#### `curry8`

``` purescript
curry8 :: forall a b c d e f g h r z. z -> (T9 a b c d e f g h z -> r) -> a -> b -> c -> d -> e -> f -> g -> h -> r
```

Given a function that accepts at least an 8-tuple, returns a function of 8 arguments.

#### `curry9`

``` purescript
curry9 :: forall a b c d e f g h i r z. z -> (T10 a b c d e f g h i z -> r) -> a -> b -> c -> d -> e -> f -> g -> h -> i -> r
```

Given a function that accepts at least a 9-tuple, returns a function of 9 arguments.

#### `curry10`

``` purescript
curry10 :: forall a b c d e f g h i j r z. z -> (T11 a b c d e f g h i j z -> r) -> a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> r
```

Given a function that accepts at least a 10-tuple, returns a function of 10 arguments.


