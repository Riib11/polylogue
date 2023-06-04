## Module Control.Monad.ST


### Re-exported from Control.Monad.ST.Internal:

#### `ST`

``` purescript
data ST t0 t1
```

The `ST` type constructor allows _local mutation_, i.e. mutation which
does not "escape" into the surrounding computation.

An `ST` computation is parameterized by a phantom type which is used to
restrict the set of reference cells it is allowed to access.

The `run` function can be used to run a computation in the `ST` monad.

##### Instances
``` purescript
Functor (ST r)
Apply (ST r)
Applicative (ST r)
Bind (ST r)
Monad (ST r)
MonadRec (ST r)
(Semigroup a) => Semigroup (ST r a)
(Monoid a) => Monoid (ST r a)
```

#### `Region`

``` purescript
data Region
```

`ST` is concerned with _restricted_ mutation. Mutation is restricted to a
_region_ of mutable references. This kind is inhabited by phantom types
which represent regions in the type system.

#### `while`

``` purescript
while :: forall r a. ST r Boolean -> ST r a -> ST r Unit
```

Loop while a condition is `true`.

`while b m` is ST computation which runs the ST computation `b`. If its
result is `true`, it runs the ST computation `m` and loops. If not, the
computation ends.

#### `run`

``` purescript
run :: forall a. (forall r. ST r a) -> a
```

Run an `ST` computation.

Note: the type of `run` uses a rank-2 type to constrain the phantom
type `r`, such that the computation must not leak any mutable references
to the surrounding computation. It may cause problems to apply this
function using the `$` operator. The recommended approach is to use
parentheses instead.

#### `foreach`

``` purescript
foreach :: forall r a. Array a -> (a -> ST r Unit) -> ST r Unit
```

Loop over an array of values.

`ST.foreach xs f` runs the computation returned by the function `f` for each
of the inputs `xs`.

#### `for`

``` purescript
for :: forall r a. Int -> Int -> (Int -> ST r a) -> ST r Unit
```

Loop over a consecutive collection of numbers

`ST.for lo hi f` runs the computation returned by the function `f` for each
of the inputs between `lo` (inclusive) and `hi` (exclusive).

