## Module Run

#### `Run`

``` purescript
newtype Run r a
  = Run (Free (VariantF r) a)
```

An extensible effect Monad, indexed by a set of effect functors. Effects
are eliminated by interpretation into a pure value or into some base
effect Monad.

An example using `State` and `Except`:

```purescript
type MyEffects =
  ( STATE Int
  + EXCEPT String
  + EFFECT
  + ()
  )

yesProgram :: Run MyEffects Unit
yesProgram = do
  whenM (gets (_ < 0)) do
    throw "Number is less than 0"
  whileM_ (gets (_ > 0)) do
    liftEffect $ log "Yes"
    modify (_ - 1)
  where
  whileM_
    :: forall a
    . Run MyEffects Boolean
    -> Run MyEffects a
    -> Run MyEffects Unit
  whileM_ mb ma = flip tailRecM unit \a ->
    mb >>= if _ then ma $> Loop unit else pure $ Done unit

main =
  yesProgram
    # catch (liftEffect <<< log)
    # runState 10
    # runBaseEffect
    # void
````

##### Instances
``` purescript
Newtype (Run r a) _
Functor (Run r)
Apply (Run r)
Applicative (Run r)
Bind (Run r)
Monad (Run r)
MonadRec (Run r)
(TypeEquals (Proxy r1) (Proxy (EFFECT r2))) => MonadEffect (Run r1)
(TypeEquals (Proxy r1) (Proxy (RowApply AFF (RowApply EFFECT r2)))) => MonadAff (Run r1)
(TypeEquals (Proxy r1) (Proxy (RowApply CHOOSE r2))) => Alt (Run r1)
(TypeEquals (Proxy r1) (Proxy (RowApply CHOOSE r2))) => Plus (Run r1)
(TypeEquals (Proxy r1) (Proxy (RowApply CHOOSE r2))) => Alternative (Run r1)
```

#### `lift`

``` purescript
lift :: forall sym r1 r2 f a. Cons sym f r1 r2 => IsSymbol sym => Functor f => Proxy sym -> f a -> Run r2 a
```

Lifts an effect functor into the `Run` Monad according to the provided
`Proxy` slot.

#### `send`

``` purescript
send :: forall a r. VariantF r a -> Run r a
```

Enqueues an instruction in the `Run` Monad.

#### `extract`

``` purescript
extract :: forall a. Run () a -> a
```

Extracts the value from a purely interpreted program.

#### `interpret`

``` purescript
interpret :: forall m a r. Monad m => ((VariantF r) ~> m) -> Run r a -> m a
```

Extracts the value from a program via some Monad `m`. This assumes
stack safety under Monadic recursion.

#### `interpretRec`

``` purescript
interpretRec :: forall m a r. MonadRec m => ((VariantF r) ~> m) -> Run r a -> m a
```

Extracts the value from a program via some MonadRec `m`, preserving
stack safety.

#### `run`

``` purescript
run :: forall m a r. Monad m => (VariantF r (Run r a) -> m (Run r a)) -> Run r a -> m a
```

Identical to `interpret` but with a less restrictive type signature,
letting you intercept the rest of the program.

#### `runRec`

``` purescript
runRec :: forall m a r. MonadRec m => (VariantF r (Run r a) -> m (Run r a)) -> Run r a -> m a
```

Identical to `interpretRec` but with a less restrictive type
signature, letting you intercept the rest of the program.

#### `runCont`

``` purescript
runCont :: forall m a b r. (VariantF r (m b) -> m b) -> (a -> m b) -> Run r a -> m b
```

Extracts the value from a program via some `m` using continuation passing.

#### `runPure`

``` purescript
runPure :: forall r1 r2 a. (VariantF r1 (Run r1 a) -> Step (Run r1 a) (VariantF r2 (Run r1 a))) -> Run r1 a -> Run r2 a
```

Eliminates effects purely. Uses `Step` from `Control.Monad.Rec.Class` to
preserve stack safety under tail recursion.

#### `runAccum`

``` purescript
runAccum :: forall m r s a. Monad m => (s -> VariantF r (Run r a) -> m (Tuple s (Run r a))) -> s -> Run r a -> m a
```

Extracts the value from a program via some Monad `m` with an internal
accumulator. This assumes stack safety under Monadic recursion.

#### `runAccumRec`

``` purescript
runAccumRec :: forall m r s a. MonadRec m => (s -> VariantF r (Run r a) -> m (Tuple s (Run r a))) -> s -> Run r a -> m a
```

Extracts the value from a program via some MonadRec `m` with an internal
accumulator.

#### `runAccumCont`

``` purescript
runAccumCont :: forall m r s a b. (s -> VariantF r (s -> m b) -> m b) -> (s -> a -> m b) -> s -> Run r a -> m b
```

Extracts the value from a program via some `m` using continuation passing
with an internal accumulator.

#### `runAccumPure`

``` purescript
runAccumPure :: forall r1 r2 a b s. (s -> VariantF r1 (Run r1 a) -> Step (Tuple s (Run r1 a)) (VariantF r2 (Run r1 a))) -> (s -> a -> b) -> s -> Run r1 a -> Run r2 b
```

Eliminates effects purely with an internal accumulator. Uses `Step` from
`Control.Monad.Rec.Class` to preserve stack safety under tail recursion.

#### `peel`

``` purescript
peel :: forall a r. Run r a -> Either (VariantF r (Run r a)) a
```

Reflects the next instruction or the final value if there are no more
instructions.

#### `resume`

``` purescript
resume :: forall a b r. (VariantF r (Run r a) -> b) -> (a -> b) -> Run r a -> b
```

Eliminator for the `Run` data type.

#### `expand`

``` purescript
expand :: forall r1 r2 rx a. Union r1 rx r2 => Run r1 a -> Run r2 a
```

Casts some set of effects to a wider set of effects via a left-biased
union. For example, you could take a closed effect and unify it with
a superset of effects because we know the additional effects never
occur.

```purescript
type LessRows = (foo :: Foo)
type MoreRows = (foo :: Foo, bar :: Bar, baz :: Baz)

foo :: Run LessRows Unit
foo = foo

foo' :: Run MoreRows Unit
foo' = expand foo
```

#### `EFFECT`

``` purescript
type EFFECT r = (effect :: Effect | r)
```

Type synonym for using `Effect` as an effect.

#### `AFF`

``` purescript
type AFF r = (aff :: Aff | r)
```

Type synonym for using `Aff` as an effect.

#### `liftEffect`

``` purescript
liftEffect :: forall r. Effect ~> (Run (EFFECT + r))
```

#### `liftAff`

``` purescript
liftAff :: forall r. Aff ~> (Run (AFF + r))
```

Lift an `Aff` effect into the `Run` Monad via the `aff` label.

#### `runBaseEffect`

``` purescript
runBaseEffect :: (Run (EFFECT + ())) ~> Effect
```

Runs a base `Effect` effect.

#### `runBaseAff`

``` purescript
runBaseAff :: (Run (AFF + ())) ~> Aff
```

Runs a base `Aff` effect.

#### `runBaseAff'`

``` purescript
runBaseAff' :: (Run (AFF + EFFECT + ())) ~> Aff
```

Runs base `Aff` and `Effect` together as one effect.


### Re-exported from Control.Monad.Rec.Class:

#### `Step`

``` purescript
data Step a b
  = Loop a
  | Done b
```

The result of a computation: either `Loop` containing the updated
accumulator, or `Done` containing the final result of the computation.

##### Instances
``` purescript
Functor (Step a)
Bifunctor Step
```

### Re-exported from Data.Functor.Variant:

#### `VariantF`

``` purescript
data VariantF f a
```

##### Instances
``` purescript
Functor (VariantF r)
(RowToList row rl, FoldableVFRL rl row) => Foldable (VariantF row)
(RowToList row rl, TraversableVFRL rl row) => Traversable (VariantF row)
(RowToList r rl, VariantTags rl, VariantFShows rl a, Show a) => Show (VariantF r a)
```

#### `onMatch`

``` purescript
onMatch :: forall rl r r1 r2 r3 a b. RowToList r rl => VariantFMatchCases rl r1 a b => Union r1 r2 r3 => Record r -> (VariantF r2 a -> b) -> VariantF r3 a -> b
```

Match a `VariantF` with a `Record` containing functions for handling cases.
This is similar to `on`, except instead of providing a single label and
handler, you can provide a record where each field maps to a particular
`VariantF` case.

```purescript
onMatch
 { foo: \foo -> "Foo: " <> maybe "nothing" id foo
 , bar: \bar -> "Bar: " <> snd bar
 }
```

Polymorphic functions in records (such as `show` or `id`) can lead
to inference issues if not all polymorphic variables are specified
in usage. When in doubt, label methods with specific types, such as
`show :: Int -> String`, or give the whole record an appropriate type.

#### `on`

``` purescript
on :: forall sym f a b r1 r2. Cons sym f r1 r2 => IsSymbol sym => Proxy sym -> (f a -> b) -> (VariantF r1 a -> b) -> VariantF r2 a -> b
```

Attempt to read a variant at a given label by providing branches.
The failure branch receives the provided variant, but with the label
removed.

#### `match`

``` purescript
match :: forall rl r r1 r2 a b. RowToList r rl => VariantFMatchCases rl r1 a b => Union r1 () r2 => Record r -> VariantF r2 a -> b
```

Combinator for exhaustive pattern matching using an `onMatch` case record.
```purescript
matchFn :: VariantF (foo :: Maybe, bar :: Tuple String, baz :: Either String) Int -> String
matchFn = match
 { foo: \foo -> "Foo: " <> maybe "nothing" show foo
 , bar: \bar -> "Bar: " <> show (snd bar)
 , baz: \baz -> "Baz: " <> either id show baz
 }
```

#### `inj`

``` purescript
inj :: forall sym f a r1 r2. Cons sym f r1 r2 => IsSymbol sym => Functor f => Proxy sym -> f a -> VariantF r2 a
```

Inject into the variant at a given label.
```purescript
maybeAtFoo :: forall r. VariantF (foo :: Maybe | r) Int
maybeAtFoo = inj (Proxy :: Proxy "foo") (Just 42)
```

#### `default`

``` purescript
default :: forall a b r. a -> VariantF r b -> a
```

Combinator for partial matching with a default value in case of failure.
```purescript
caseFn :: forall r. VariantF (foo :: Maybe, bar :: Tuple String | r) Int -> String
caseFn = default "No match"
 # on (Proxy :: Proxy "foo") (\foo -> "Foo: " <> maybe "nothing" show foo)
 # on (Proxy :: Proxy "bar") (\bar -> "Bar: " <> show (snd bar))
```

#### `case_`

``` purescript
case_ :: forall a b. VariantF () a -> b
```

Combinator for exhaustive pattern matching.
```purescript
caseFn :: VariantF (foo :: Maybe, bar :: Tuple String, baz :: Either String) Int -> String
caseFn = case_
 # on (Proxy :: Proxy "foo") (\foo -> "Foo: " <> maybe "nothing" show foo)
 # on (Proxy :: Proxy "bar") (\bar -> "Bar: " <> show (snd bar))
 # on (Proxy :: Proxy "baz") (\baz -> "Baz: " <> either id show baz)
```

