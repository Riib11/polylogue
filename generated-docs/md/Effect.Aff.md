## Module Effect.Aff

#### `Aff`

``` purescript
data Aff t0
```

An `Aff a` is an asynchronous computation with effects. The
computation may either error with an exception, or produce a result of
type `a`. `Aff` effects are assembled from primitive `Effect` effects using
`makeAff` or `liftEffect`.

##### Instances
``` purescript
Functor Aff
Apply Aff
Applicative Aff
Bind Aff
Monad Aff
(Semigroup a) => Semigroup (Aff a)
(Monoid a) => Monoid (Aff a)
Alt Aff
Plus Aff
MonadRec Aff
MonadThrow Error Aff
MonadError Error Aff
MonadEffect Aff
Lazy (Aff a)
MonadST Global Aff
Parallel ParAff Aff
```

#### `Fiber`

``` purescript
newtype Fiber a
```

Represents a forked computation by way of `forkAff`. `Fiber`s are
memoized, so their results are only computed once.

##### Instances
``` purescript
Functor Fiber
Apply Fiber
Applicative Fiber
```

#### `ParAff`

``` purescript
data ParAff t0
```

Applicative for running parallel effects. Any `Aff` can be coerced to a
`ParAff` and back using the `Parallel` class.

##### Instances
``` purescript
Functor ParAff
Apply ParAff
Applicative ParAff
(Semigroup a) => Semigroup (ParAff a)
(Monoid a) => Monoid (ParAff a)
Alt ParAff
Plus ParAff
Alternative ParAff
Parallel ParAff Aff
```

#### `Canceler`

``` purescript
newtype Canceler
  = Canceler (Error -> Aff Unit)
```

A cancellation effect for actions run via `makeAff`. If a `Fiber` is
killed, and an async action is pending, the canceler will be called to
clean it up.

##### Instances
``` purescript
Newtype Canceler _
Semigroup Canceler
Monoid Canceler
```

#### `makeAff`

``` purescript
makeAff :: forall a. ((Either Error a -> Effect Unit) -> Effect Canceler) -> Aff a
```

Constructs an `Aff` from low-level `Effect` effects using a callback. A
`Canceler` effect should be returned to cancel the pending action. The
supplied callback may be invoked only once. Subsequent invocation are
ignored.

#### `launchAff`

``` purescript
launchAff :: forall a. Aff a -> Effect (Fiber a)
```

Forks an `Aff` from an `Effect` context, returning the `Fiber`.

#### `launchAff_`

``` purescript
launchAff_ :: Aff Unit -> Effect Unit
```

Forks an `Aff` from an `Effect` context, discarding the `Fiber`.

#### `launchSuspendedAff`

``` purescript
launchSuspendedAff :: forall a. Aff a -> Effect (Fiber a)
```

Suspends an `Aff` from an `Effect` context, returning the `Fiber`.

#### `runAff`

``` purescript
runAff :: forall a. (Either Error a -> Effect Unit) -> Aff a -> Effect (Fiber Unit)
```

Forks an `Aff` from an `Effect` context and also takes a callback to run when
it completes. Returns the pending `Fiber`.

#### `runAff_`

``` purescript
runAff_ :: forall a. (Either Error a -> Effect Unit) -> Aff a -> Effect Unit
```

Forks an `Aff` from an `Effect` context and also takes a callback to run when
it completes, discarding the `Fiber`.

#### `runSuspendedAff`

``` purescript
runSuspendedAff :: forall a. (Either Error a -> Effect Unit) -> Aff a -> Effect (Fiber Unit)
```

Suspends an `Aff` from an `Effect` context and also takes a callback to run
when it completes. Returns the suspended `Fiber`.

#### `forkAff`

``` purescript
forkAff :: forall a. Aff a -> Aff (Fiber a)
```

Forks an `Aff` from within a parent `Aff` context, returning the `Fiber`.

#### `suspendAff`

``` purescript
suspendAff :: forall a. Aff a -> Aff (Fiber a)
```

Suspends an `Aff` from within a parent `Aff` context, returning the `Fiber`.
A suspended `Aff` is not executed until a consumer observes the result
with `joinFiber`.

#### `supervise`

``` purescript
supervise :: forall a. Aff a -> Aff a
```

Creates a new supervision context for some `Aff`, guaranteeing fiber
cleanup when the parent completes. Any pending fibers forked within
the context will be killed and have their cancelers run.

#### `attempt`

``` purescript
attempt :: forall a. Aff a -> Aff (Either Error a)
```

A monomorphic version of `try`. Catches thrown errors and lifts them
into an `Either`.

#### `apathize`

``` purescript
apathize :: forall a. Aff a -> Aff Unit
```

Ignores any errors.

#### `delay`

``` purescript
delay :: Milliseconds -> Aff Unit
```

Pauses the running fiber.

#### `never`

``` purescript
never :: forall a. Aff a
```

An async computation which does not resolve.

#### `finally`

``` purescript
finally :: forall a. Aff Unit -> Aff a -> Aff a
```

Runs the first effect after the second, regardless of whether it completed
successfully or the fiber was cancelled.

#### `invincible`

``` purescript
invincible :: forall a. Aff a -> Aff a
```

Runs an effect such that it cannot be killed.

#### `killFiber`

``` purescript
killFiber :: forall a. Error -> Fiber a -> Aff Unit
```

Invokes pending cancelers in a fiber and runs cleanup effects. Blocks
until the fiber has fully exited.

#### `joinFiber`

``` purescript
joinFiber :: Fiber ~> Aff
```

Blocks until the fiber completes, yielding the result. If the fiber
throws an exception, it is rethrown in the current fiber.

#### `cancelWith`

``` purescript
cancelWith :: forall a. Aff a -> Canceler -> Aff a
```

Attaches a custom `Canceler` to an action. If the computation is canceled,
then the custom `Canceler` will be run afterwards.

#### `bracket`

``` purescript
bracket :: forall a b. Aff a -> (a -> Aff Unit) -> (a -> Aff b) -> Aff b
```

Guarantees resource acquisition and cleanup. The first effect may acquire
some resource, while the second will dispose of it. The third effect makes
use of the resource. Disposal is always run last, regardless. Neither
acquisition nor disposal may be cancelled and are guaranteed to run until
they complete.

#### `BracketConditions`

``` purescript
type BracketConditions a b = { completed :: b -> a -> Aff Unit, failed :: Error -> a -> Aff Unit, killed :: Error -> a -> Aff Unit }
```

#### `generalBracket`

``` purescript
generalBracket :: forall a b. Aff a -> BracketConditions a b -> (a -> Aff b) -> Aff b
```

A general purpose bracket which lets you observe the status of the
bracketed action. The bracketed action may have been killed with an
exception, thrown an exception, or completed successfully.

#### `nonCanceler`

``` purescript
nonCanceler :: Canceler
```

A canceler which does not cancel anything.

#### `effectCanceler`

``` purescript
effectCanceler :: Effect Unit -> Canceler
```

A canceler from an Effect action.

#### `fiberCanceler`

``` purescript
fiberCanceler :: forall a. Fiber a -> Canceler
```

A canceler from a Fiber.


### Re-exported from Control.Monad.Error.Class:

#### `catchError`

``` purescript
catchError :: forall e m a. MonadError e m => m a -> (e -> m a) -> m a
```

#### `throwError`

``` purescript
throwError :: forall e m a. MonadThrow e m => e -> m a
```

#### `try`

``` purescript
try :: forall e m a. MonadError e m => m a -> m (Either e a)
```

Return `Right` if the given action succeeds, `Left` if it throws.

### Re-exported from Control.Parallel.Class:

#### `parallel`

``` purescript
parallel :: forall f m. Parallel f m => m ~> f
```

#### `sequential`

``` purescript
sequential :: forall f m. Parallel f m => f ~> m
```

### Re-exported from Data.Time.Duration:

#### `Milliseconds`

``` purescript
newtype Milliseconds
  = Milliseconds Number
```

A duration measured in milliseconds.

##### Instances
``` purescript
Newtype Milliseconds _
Eq Milliseconds
Ord Milliseconds
Semigroup Milliseconds
Monoid Milliseconds
Show Milliseconds
Duration Milliseconds
```

### Re-exported from Effect.Exception:

#### `Error`

``` purescript
data Error
```

The type of JavaScript errors

##### Instances
``` purescript
Show Error
```

#### `message`

``` purescript
message :: Error -> String
```

Get the error message from a JavaScript error

#### `error`

``` purescript
error :: String -> Error
```

Create a JavaScript error, specifying a message

