## Module Effect.Ref

This module defines the `Ref` type for mutable value references, as well
as actions for working with them.

You'll notice that all of the functions that operate on a `Ref` (e.g.
`new`, `read`, `write`) return their result wrapped in an `Effect`.
Working with mutable references is considered effectful in PureScript
because of the principle of purity: functions should not have side
effects, and should return the same result when called with the same
arguments. If a `Ref` could be written to without using `Effect`, that
would cause a side effect (the effect of changing the result of subsequent
reads for that `Ref`). If there were a function for reading the current
value of a `Ref` without the result being wrapped in `Effect`, the result
of calling that function would change each time a new value was written to
the `Ref`. Even creating a new `Ref` is effectful: if there were a
function for creating a new `Ref` with the type `forall s. s -> Ref s`,
then calling that function twice with the same argument would not give the
same result in each case, since you'd end up with two distinct references
which could be updated independently of each other.

_Note_: `Control.Monad.ST` provides a pure alternative to `Ref` when
mutation is restricted to a local scope.

#### `Ref`

``` purescript
data Ref t0
```

A value of type `Ref a` represents a mutable reference
which holds a value of type `a`.

#### `new`

``` purescript
new :: forall s. s -> Effect (Ref s)
```

#### `newWithSelf`

``` purescript
newWithSelf :: forall s. (Ref s -> s) -> Effect (Ref s)
```

Create a new mutable reference containing a value that can refer to the
`Ref` being created.

#### `read`

``` purescript
read :: forall s. Ref s -> Effect s
```

Read the current value of a mutable reference.

#### `modify'`

``` purescript
modify' :: forall s b. (s -> { state :: s, value :: b }) -> Ref s -> Effect b
```

Update the value of a mutable reference by applying a function
to the current value.

#### `modify`

``` purescript
modify :: forall s. (s -> s) -> Ref s -> Effect s
```

Update the value of a mutable reference by applying a function
to the current value. The updated value is returned.

#### `modify_`

``` purescript
modify_ :: forall s. (s -> s) -> Ref s -> Effect Unit
```

A version of `modify` which does not return the updated value.

#### `write`

``` purescript
write :: forall s. s -> Ref s -> Effect Unit
```

Update the value of a mutable reference to the specified value.


