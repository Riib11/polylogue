## Module Test.Spec

#### `Spec`

``` purescript
type Spec a = SpecT Aff Unit Identity a
```

#### `SpecT`

``` purescript
newtype SpecT g i m a
  = SpecT (WriterT (Array (SpecTree g i)) m a)
```

##### Instances
``` purescript
Newtype (SpecT g i m a) _
(Functor m) => Functor (SpecT g i m)
(Apply m) => Apply (SpecT g i m)
(Applicative m) => Applicative (SpecT g i m)
(Alt m) => Alt (SpecT g i m)
(Plus m) => Plus (SpecT g i m)
(Alternative m) => Alternative (SpecT g i m)
(Bind m) => Bind (SpecT g i m)
(Monad m) => Monad (SpecT g i m)
(MonadRec m) => MonadRec (SpecT g i m)
(MonadPlus m) => MonadPlus (SpecT g i m)
MonadTrans (SpecT g i)
(MonadEffect m) => MonadEffect (SpecT g i m)
(MonadCont m) => MonadCont (SpecT g i m)
(MonadThrow e m) => MonadThrow e (SpecT g i m)
(MonadError e m) => MonadError e (SpecT g i m)
(MonadAsk r m) => MonadAsk r (SpecT g i m)
(MonadReader r m) => MonadReader r (SpecT g i m)
(MonadState s m) => MonadState s (SpecT g i m)
```

#### `SpecTree`

``` purescript
type SpecTree m a = Tree (ActionWith m a) (Item m a)
```

#### `mapSpecTree`

``` purescript
mapSpecTree :: forall m m' g g' i a i'. Functor m' => (m ~> m') -> (SpecTree g i -> SpecTree g' i') -> SpecT g i m a -> SpecT g' i' m' a
```

#### `collect`

``` purescript
collect :: forall m g i a. Functor m => SpecT g i m a -> m (Array (SpecTree g i))
```

Collects all tests, if something is focused, all unfocused tests will be discarded

#### `ComputationType`

``` purescript
data ComputationType
  = CleanUpWithContext (Array String)
  | TestWithName (NonEmptyArray String)
```

#### `hoistSpec`

``` purescript
hoistSpec :: forall m' m i a b. Monad m' => (m ~> m') -> (ComputationType -> a ~> b) -> (SpecT a i m) ~> (SpecT b i m')
```

#### `Example`

``` purescript
class Example t arg m | t -> arg, t -> m where
  evaluateExample :: t -> (ActionWith m arg -> m Unit) -> m Unit
```

##### Instances
``` purescript
Example (arg -> m Unit) arg m
Example (m Unit) Unit m
```

#### `parallel`

``` purescript
parallel :: forall m g i a. Monad m => SpecT g i m a -> SpecT g i m a
```

marks all spec items of the given spec to be safe for parallel evaluation.

#### `sequential`

``` purescript
sequential :: forall m g i a. Monad m => SpecT g i m a -> SpecT g i m a
```

marks all spec items of the given spec to be evaluated sequentially.

#### `FocusWarning`

``` purescript
class FocusWarning 
```

Nullary class used to raise a custom warning for the focusing functions.

##### Instances
``` purescript
(Warn (Text "Test.Spec.focus usage")) => FocusWarning
```

#### `focus`

``` purescript
focus :: forall m g i a. FocusWarning => Monad m => SpecT g i m a -> SpecT g i m a
```

`focus` focuses all spec items of the given spec.

Applying `focus` to a spec with focused spec items has no effect.

#### `describeOnly`

``` purescript
describeOnly :: forall m g i a. FocusWarning => Monad m => String -> SpecT g i m a -> SpecT g i m a
```

Combine a group of specs into a described hierarchy and mark it as the
only group to actually be evaluated. (useful for quickly narrowing down
on a set)

#### `itOnly`

``` purescript
itOnly :: forall m t arg g. FocusWarning => Monad m => Example t arg g => String -> t -> SpecT g arg m Unit
```

Create a spec with a description and mark it as the only one to
be run. (useful for quickly narrowing down on a single test)

#### `describe`

``` purescript
describe :: forall m g i a. Monad m => String -> SpecT g i m a -> SpecT g i m a
```

Combine a group of specs into a described hierarchy.

#### `it`

``` purescript
it :: forall m t arg g. Monad m => Example t arg g => String -> t -> SpecT g arg m Unit
```

Create a spec with a description.

#### `pending`

``` purescript
pending :: forall m g i. Monad m => String -> SpecT g i m Unit
```

Create a pending spec.

#### `pending'`

``` purescript
pending' :: forall m g i. Monad m => String -> g Unit -> SpecT g i m Unit
```

Create a pending spec with a body that is ignored by
the runner. It can be useful for documenting what the
spec should test when non-pending.

#### `aroundWith`

``` purescript
aroundWith :: forall m g i i' a. Monad m => (ActionWith g i -> ActionWith g i') -> SpecT g i m a -> SpecT g i' m a
```

Run a custom action before and/or after every spec item.

#### `around`

``` purescript
around :: forall m g i a. Monad m => (ActionWith g i -> g Unit) -> SpecT g i m a -> SpecT g Unit m a
```

Run a custom action before and/or after every spec item.

#### `around_`

``` purescript
around_ :: forall m g i a. Monad m => (g Unit -> g Unit) -> SpecT g i m a -> SpecT g i m a
```

Run a custom action before and/or after every spec item.

#### `before`

``` purescript
before :: forall m g i a. Monad m => Monad g => g i -> SpecT g i m a -> SpecT g Unit m a
```

Run a custom action before every spec item.

#### `before_`

``` purescript
before_ :: forall m g i a. Monad m => Monad g => g Unit -> SpecT g i m a -> SpecT g i m a
```

Run a custom action before every spec item.

#### `beforeWith`

``` purescript
beforeWith :: forall m g i i' a. Monad m => Monad g => (i' -> g i) -> SpecT g i m a -> SpecT g i' m a
```

Run a custom action before every spec item.

#### `beforeAll`

``` purescript
beforeAll :: forall m g i a. MonadEffect m => MonadAff g => MonadError Error g => g i -> SpecT g i m a -> SpecT g Unit m a
```

Run a custom action before the first spec item.

#### `beforeAll_`

``` purescript
beforeAll_ :: forall m g i a. MonadEffect m => MonadAff g => MonadError Error g => g Unit -> SpecT g i m a -> SpecT g i m a
```

Run a custom action before the first spec item.

#### `after`

``` purescript
after :: forall m g e f i a. Monad m => MonadBracket e f g => ActionWith g i -> SpecT g i m a -> SpecT g i m a
```

Run a custom action after every spec item.

#### `after_`

``` purescript
after_ :: forall m g e f i a. Monad m => MonadBracket e f g => g Unit -> SpecT g i m a -> SpecT g i m a
```

Run a custom action after every spec item.

#### `afterAll`

``` purescript
afterAll :: forall m g i a. Monad m => ActionWith g i -> SpecT g i m a -> SpecT g i m a
```

Run a custom action after the last spec item.

#### `afterAll_`

``` purescript
afterAll_ :: forall m g i a. Monad m => g Unit -> SpecT g i m a -> SpecT g i m a
```

Run a custom action after the last spec item.


### Re-exported from Test.Spec.Tree:

#### `Tree`

``` purescript
data Tree c a
  = Node (Either String c) (Array (Tree c a))
  | Leaf String (Maybe a)
```

##### Instances
``` purescript
(Show c, Show a) => Show (Tree c a)
(Eq c, Eq a) => Eq (Tree c a)
Bifunctor Tree
Foldable (Tree c)
```

#### `Item`

``` purescript
newtype Item m a
  = Item { example :: (ActionWith m a -> m Unit) -> m Unit, isFocused :: Boolean, isParallelizable :: Maybe Boolean }
```

##### Instances
``` purescript
Newtype (Item m a) _
Show (Item m a)
Eq (Item m a)
```

#### `ActionWith`

``` purescript
type ActionWith m a = a -> m Unit
```

