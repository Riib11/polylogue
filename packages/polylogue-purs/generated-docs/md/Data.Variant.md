## Module Data.Variant

#### `Variant`

``` purescript
data Variant t0
```

##### Instances
``` purescript
(RowToList r rl, VariantTags rl, VariantEqs rl) => Eq (Variant r)
(RowToList r rl, VariantTags rl, VariantEqs rl, VariantOrds rl, VariantBounded rl) => Bounded (Variant r)
(RowToList r rl, VariantTags rl, VariantEqs rl, VariantOrds rl, VariantBoundedEnums rl) => Enum (Variant r)
(RowToList r rl, VariantTags rl, VariantEqs rl, VariantOrds rl, VariantBoundedEnums rl) => BoundedEnum (Variant r)
(RowToList r rl, VariantTags rl, VariantEqs rl, VariantOrds rl) => Ord (Variant r)
(RowToList r rl, VariantTags rl, VariantShows rl) => Show (Variant r)
```

#### `inj`

``` purescript
inj :: forall sym a r1 r2. Cons sym a r1 r2 => IsSymbol sym => Proxy sym -> a -> Variant r2
```

Inject into the variant at a given label.
```purescript
intAtFoo :: forall r. Variant (foo :: Int | r)
intAtFoo = inj (Proxy :: Proxy "foo") 42
```

#### `prj`

``` purescript
prj :: forall sym a r1 r2 f. Cons sym a r1 r2 => IsSymbol sym => Alternative f => Proxy sym -> Variant r2 -> f a
```

Attempt to read a variant at a given label.
```purescript
case prj (Proxy :: Proxy "foo") intAtFoo of
  Just i  -> i + 1
  Nothing -> 0
```

#### `on`

``` purescript
on :: forall sym a b r1 r2. Cons sym a r1 r2 => IsSymbol sym => Proxy sym -> (a -> b) -> (Variant r1 -> b) -> Variant r2 -> b
```

Attempt to read a variant at a given label by providing branches.
The failure branch receives the provided variant, but with the label
removed.

#### `onMatch`

``` purescript
onMatch :: forall rl r r1 r2 r3 b. RowToList r rl => VariantMatchCases rl r1 b => Union r1 r2 r3 => Record r -> (Variant r2 -> b) -> Variant r3 -> b
```

Match a `Variant` with a `Record` containing functions for handling cases.
This is similar to `on`, except instead of providing a single label and
handler, you can provide a record where each field maps to a particular
`Variant` case.

```purescript
onMatch
  { foo: \foo -> "Foo: " <> foo
  , bar: \bar -> "Bar: " <> bar
  }
```

Polymorphic functions in records (such as `show` or `id`) can lead
to inference issues if not all polymorphic variables are specified
in usage. When in doubt, label methods with specific types, such as
`show :: Int -> String`, or give the whole record an appropriate type.

#### `over`

``` purescript
over :: forall r rl ri ro r1 r2 r3. RowToList r rl => VariantMapCases rl ri ro => Union ri r2 r1 => Union ro r2 r3 => Record r -> Variant r1 -> Variant r3
```

Map over some labels and leave the rest unchanged. For example:

```purescript
over { label: show :: Int -> String }
  :: forall r. Variant ( label :: Int | r ) -> Variant ( label :: String | r )
```

`over r` is like `expand # overSome r` but with a more easily
solved constraint (i.e. it can be solved once the type of `r` is known).

#### `overOne`

``` purescript
overOne :: forall sym a b r1 r2 r3 r4. IsSymbol sym => Cons sym a r1 r2 => Cons sym b r4 r3 => Proxy sym -> (a -> b) -> (Variant r1 -> Variant r3) -> Variant r2 -> Variant r3
```

Map over one case of a variant, putting the result back at the same label,
with a fallback function to handle the remaining cases.

#### `overSome`

``` purescript
overSome :: forall r rl ri ro r1 r2 r3 r4. RowToList r rl => VariantMapCases rl ri ro => Union ri r2 r1 => Union ro r4 r3 => Record r -> (Variant r2 -> Variant r3) -> Variant r1 -> Variant r3
```

Map over several cases of a variant using a `Record` containing functions
for each case. Each case gets put back at the same label it was matched
at, i.e. its label in the record. Labels not found in the record are
handled using the fallback function.

#### `case_`

``` purescript
case_ :: forall a. Variant () -> a
```

Combinator for exhaustive pattern matching.
```purescript
caseFn :: Variant (foo :: Int, bar :: String, baz :: Boolean) -> String
caseFn = case_
 # on (Proxy :: Proxy "foo") (\foo -> "Foo: " <> show foo)
 # on (Proxy :: Proxy "bar") (\bar -> "Bar: " <> bar)
 # on (Proxy :: Proxy "baz") (\baz -> "Baz: " <> show baz)
```

#### `match`

``` purescript
match :: forall rl r r1 r2 b. RowToList r rl => VariantMatchCases rl r1 b => Union r1 () r2 => Record r -> Variant r2 -> b
```

Combinator for exhaustive pattern matching using an `onMatch` case record.
```purescript
matchFn :: Variant (foo :: Int, bar :: String, baz :: Boolean) -> String
matchFn = match
  { foo: \foo -> "Foo: " <> show foo
  , bar: \bar -> "Bar: " <> bar
  , baz: \baz -> "Baz: " <> show baz
  }
```

#### `default`

``` purescript
default :: forall a r. a -> Variant r -> a
```

Combinator for partial matching with a default value in case of failure.
```purescript
caseFn :: forall r. Variant (foo :: Int, bar :: String | r) -> String
caseFn = default "No match"
 # on (Proxy :: Proxy "foo") (\foo -> "Foo: " <> show foo)
 # on (Proxy :: Proxy "bar") (\bar -> "Bar: " <> bar)
```

#### `traverse`

``` purescript
traverse :: forall r rl ri ro r1 r2 r3 m. RowToList r rl => VariantTraverseCases m rl ri ro => Union ri r2 r1 => Union ro r2 r3 => Applicative m => Record r -> Variant r1 -> m (Variant r3)
```

Traverse over some labels and leave the rest unchanged.
(Implemented by expanding after `traverseSome`.)

#### `traverseOne`

``` purescript
traverseOne :: forall sym a b r1 r2 r3 r4 m. IsSymbol sym => Cons sym a r1 r2 => Cons sym b r4 r3 => Functor m => Proxy sym -> (a -> m b) -> (Variant r1 -> m (Variant r3)) -> Variant r2 -> m (Variant r3)
```

Traverse over one case of a variant (in a functorial/monadic context `m`),
putting the result back at the same label, with a fallback function.

#### `traverseSome`

``` purescript
traverseSome :: forall r rl ri ro r1 r2 r3 r4 m. RowToList r rl => VariantTraverseCases m rl ri ro => Union ri r2 r1 => Union ro r4 r3 => Functor m => Record r -> (Variant r2 -> m (Variant r3)) -> Variant r1 -> m (Variant r3)
```

Traverse over several cases of a variant using a `Record` containing
traversals. Each case gets put back at the same label it was matched
at, i.e. its label in the record. Labels not found in the record are
handled using the fallback function.

#### `expand`

``` purescript
expand :: forall lt a gt. Union lt a gt => Variant lt -> Variant gt
```

Every `Variant lt` can be cast to some `Variant gt` as long as `lt` is a
subset of `gt`.

#### `contract`

``` purescript
contract :: forall lt gt f. Alternative f => Contractable gt lt => Variant gt -> f (Variant lt)
```

A `Variant gt` can be cast to some `Variant lt`, where `lt` is is a subset
of `gt`, as long as there is proof that the `Variant`'s runtime tag is
within the subset of `lt`.

#### `Unvariant`

``` purescript
newtype Unvariant r
  = Unvariant (forall x. Unvariant' r x -> x)
```

#### `Unvariant'`

``` purescript
type Unvariant' r x = forall s t o. IsSymbol s => Cons s t o r => Proxy s -> t -> x
```

#### `unvariant`

``` purescript
unvariant :: forall r. Variant r -> Unvariant r
```

A low-level eliminator which reifies the `IsSymbol` and `Cons`
constraints required to reconstruct the Variant. This lets you
work generically with some Variant at runtime.

#### `revariant`

``` purescript
revariant :: forall r. Unvariant r -> Variant r
```

Reconstructs a Variant given an Unvariant eliminator.

#### `VariantEqs`

``` purescript
class VariantEqs rl  where
  variantEqs :: Proxy rl -> List (VariantCase -> VariantCase -> Boolean)
```

##### Instances
``` purescript
VariantEqs Nil
(VariantEqs rs, Eq a) => VariantEqs (Cons sym a rs)
```

#### `VariantOrds`

``` purescript
class VariantOrds rl  where
  variantOrds :: Proxy rl -> List (VariantCase -> VariantCase -> Ordering)
```

##### Instances
``` purescript
VariantOrds Nil
(VariantOrds rs, Ord a) => VariantOrds (Cons sym a rs)
```

#### `VariantShows`

``` purescript
class VariantShows rl  where
  variantShows :: Proxy rl -> List (VariantCase -> String)
```

##### Instances
``` purescript
VariantShows Nil
(VariantShows rs, Show a) => VariantShows (Cons sym a rs)
```

#### `VariantBounded`

``` purescript
class VariantBounded rl  where
  variantBounded :: Proxy rl -> List (BoundedDict VariantCase)
```

##### Instances
``` purescript
VariantBounded Nil
(VariantBounded rs, Bounded a) => VariantBounded (Cons sym a rs)
```

#### `VariantBoundedEnums`

``` purescript
class (VariantBounded rl) <= VariantBoundedEnums rl  where
  variantBoundedEnums :: Proxy rl -> List (BoundedEnumDict VariantCase)
```

##### Instances
``` purescript
VariantBoundedEnums Nil
(VariantBoundedEnums rs, BoundedEnum a) => VariantBoundedEnums (Cons sym a rs)
```


### Re-exported from Data.Variant.Internal:

#### `Contractable`

``` purescript
class Contractable gt lt 
```

##### Instances
``` purescript
(RowToList lt ltl, Union lt a gt, VariantTags ltl) => Contractable gt lt
```

#### `VariantMapCases`

``` purescript
class VariantMapCases (rl :: RowList Type) (ri :: Row Type) (ro :: Row Type) | rl -> ri ro
```

##### Instances
``` purescript
(Cons sym a ri' ri, Cons sym b ro' ro, VariantMapCases rl ri' ro', TypeEquals k (a -> b)) => VariantMapCases (Cons sym k rl) ri ro
VariantMapCases Nil () ()
```

#### `VariantMatchCases`

``` purescript
class VariantMatchCases rl vo b | rl -> vo b
```

##### Instances
``` purescript
(VariantMatchCases rl vo' b, Cons sym a vo' vo, TypeEquals k (a -> b)) => VariantMatchCases (Cons sym k rl) vo b
VariantMatchCases Nil () b
```

#### `VariantTraverseCases`

``` purescript
class VariantTraverseCases (m :: Type -> Type) (rl :: RowList Type) (ri :: Row Type) (ro :: Row Type) | rl -> ri ro
```

##### Instances
``` purescript
(Cons sym a ri' ri, Cons sym b ro' ro, VariantTraverseCases m rl ri' ro', TypeEquals k (a -> m b)) => VariantTraverseCases m (Cons sym k rl) ri ro
VariantTraverseCases m Nil () ()
```

