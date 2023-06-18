## Module Data.Functor.Variant

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

#### `inj`

``` purescript
inj :: forall sym f a r1 r2. Cons sym f r1 r2 => IsSymbol sym => Functor f => Proxy sym -> f a -> VariantF r2 a
```

Inject into the variant at a given label.
```purescript
maybeAtFoo :: forall r. VariantF (foo :: Maybe | r) Int
maybeAtFoo = inj (Proxy :: Proxy "foo") (Just 42)
```

#### `prj`

``` purescript
prj :: forall sym f a r1 r2 g. Cons sym f r1 r2 => Alternative g => IsSymbol sym => Proxy sym -> VariantF r2 a -> g (f a)
```

Attempt to read a variant at a given label.
```purescript
case prj (Proxy :: Proxy "foo") maybeAtFoo of
  Just (Just i) -> i + 1
  _ -> 0
```

#### `on`

``` purescript
on :: forall sym f a b r1 r2. Cons sym f r1 r2 => IsSymbol sym => Proxy sym -> (f a -> b) -> (VariantF r1 a -> b) -> VariantF r2 a -> b
```

Attempt to read a variant at a given label by providing branches.
The failure branch receives the provided variant, but with the label
removed.

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

#### `over`

``` purescript
over :: forall r rl rlo ri ro r1 r2 r3 a b. RowToList r rl => VariantFMapCases rl ri ro a b => RowToList ro rlo => VariantTags rlo => VariantFMaps rlo => Union ri r2 r1 => Union ro r2 r3 => Record r -> (a -> b) -> VariantF r1 a -> VariantF r3 b
```

Map over some labels (with access to the containers) and use `map f` for
the rest (just changing the index type). For example:

```purescript
over { label: \(Identity a) -> Just (show (a - 5)) } show
  :: forall r.
    VariantF ( label :: Identity | r ) Int ->
    VariantF ( label :: Maybe | r ) String
```

`over r f` is like `(map f >>> expand) # overSome r` but with
a more easily solved constraint (i.e. it can be solved once the type of
`r` is known).

#### `overOne`

``` purescript
overOne :: forall sym f g a b r1 r2 r3 r4. Cons sym f r1 r2 => Cons sym g r4 r3 => IsSymbol sym => Functor g => Proxy sym -> (f a -> g b) -> (VariantF r1 a -> VariantF r3 b) -> VariantF r2 a -> VariantF r3 b
```

Map over one case of a variant, putting the result back at the same label,
with a fallback function to handle the remaining cases.

#### `overSome`

``` purescript
overSome :: forall r rl rlo ri ro r1 r2 r3 r4 a b. RowToList r rl => VariantFMapCases rl ri ro a b => RowToList ro rlo => VariantTags rlo => VariantFMaps rlo => Union ri r2 r1 => Union ro r4 r3 => Record r -> (VariantF r2 a -> VariantF r3 b) -> VariantF r1 a -> VariantF r3 b
```

Map over several cases of a variant using a `Record` containing functions
for each case. Each case gets put back at the same label it was matched
at, i.e. its label in the record. Labels not found in the record are
handled using the fallback function.

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

#### `traverse`

``` purescript
traverse :: forall r rl rlo ri ro r1 r2 r3 a b m. RowToList r rl => VariantFTraverseCases m rl ri ro a b => RowToList ro rlo => VariantTags rlo => VariantFMaps rlo => Union ri r2 r1 => Union ro r2 r3 => Applicative m => Traversable (VariantF r2) => Record r -> (a -> m b) -> VariantF r1 a -> m (VariantF r3 b)
```

Traverse over some labels (with access to the containers) and use
`traverse f` for the rest (just changing the index type).

`traverse r f` is like `(traverse f >>> expand) # traverseSome r` but with
a more easily solved constraint (i.e. it can be solved once the type of
`r` is known).

#### `traverseOne`

``` purescript
traverseOne :: forall sym f g a b r1 r2 r3 r4 m. Cons sym f r1 r2 => Cons sym g r4 r3 => IsSymbol sym => Functor g => Functor m => Proxy sym -> (f a -> m (g b)) -> (VariantF r1 a -> m (VariantF r3 b)) -> VariantF r2 a -> m (VariantF r3 b)
```

Traverse over one case of a variant (in a functorial/monadic context `m`),
putting the result back at the same label, with a fallback function.

#### `traverseSome`

``` purescript
traverseSome :: forall r rl rlo ri ro r1 r2 r3 r4 a b m. RowToList r rl => VariantFTraverseCases m rl ri ro a b => RowToList ro rlo => VariantTags rlo => VariantFMaps rlo => Union ri r2 r1 => Union ro r4 r3 => Functor m => Record r -> (VariantF r2 a -> m (VariantF r3 b)) -> VariantF r1 a -> m (VariantF r3 b)
```

Traverse over several cases of a variant using a `Record` containing
traversals. Each case gets put back at the same label it was matched
at, i.e. its label in the record. Labels not found in the record are
handled using the fallback function.

#### `expand`

``` purescript
expand :: forall lt mix gt a. Union lt mix gt => VariantF lt a -> VariantF gt a
```

Every `VariantF lt a` can be cast to some `VariantF gt a` as long as `lt` is a
subset of `gt`.

#### `contract`

``` purescript
contract :: forall lt gt f a. Alternative f => Contractable gt lt => VariantF gt a -> f (VariantF lt a)
```

A `VariantF gt a` can be cast to some `VariantF lt a`, where `lt` is is a subset
of `gt`, as long as there is proof that the `VariantF`'s runtime tag is
within the subset of `lt`.

#### `UnvariantF`

``` purescript
newtype UnvariantF r a
  = UnvariantF (forall x. UnvariantF' r a x -> x)
```

#### `UnvariantF'`

``` purescript
type UnvariantF' r a x = forall s f o. IsSymbol s => Cons s f o r => Functor f => Proxy s -> f a -> x
```

#### `unvariantF`

``` purescript
unvariantF :: forall r a. VariantF r a -> UnvariantF r a
```

A low-level eliminator which reifies the `IsSymbol`, `Cons` and
`Functor` constraints require to reconstruct the Variant. This
lets you work generically with some VariantF at runtime.

#### `revariantF`

``` purescript
revariantF :: forall r a. UnvariantF r a -> VariantF r a
```

Reconstructs a VariantF given an UnvariantF eliminator.

#### `VariantFShows`

``` purescript
class VariantFShows rl x  where
  variantFShows :: forall proxy1 proxy2. proxy1 rl -> proxy2 x -> List (VariantCase -> String)
```

##### Instances
``` purescript
VariantFShows Nil x
(VariantFShows rs x, Show (f x), Show x) => VariantFShows (Cons sym f rs) x
```

#### `VariantFMaps`

``` purescript
class VariantFMaps (rl :: RowList (Type -> Type))  where
  variantFMaps :: Proxy rl -> List (Mapper VariantFCase)
```

##### Instances
``` purescript
VariantFMaps Nil
(VariantFMaps rs, Functor f) => VariantFMaps (Cons sym f rs)
```

#### `Mapper`

``` purescript
newtype Mapper f
```

#### `TraversableVFRL`

``` purescript
class (FoldableVFRL rl row) <= TraversableVFRL rl row | rl -> row where
  traverseVFRL :: forall f a b. Applicative f => Proxy rl -> (a -> f b) -> VariantF row a -> f (VariantF row b)
```

##### Instances
``` purescript
TraversableVFRL Nil ()
(IsSymbol k, Traversable f, TraversableVFRL rl r, Cons k f r r', Union r rx r') => TraversableVFRL (Cons k f rl) r'
```

#### `FoldableVFRL`

``` purescript
class FoldableVFRL rl row | rl -> row where
  foldrVFRL :: forall a b. Proxy rl -> (a -> b -> b) -> b -> VariantF row a -> b
  foldlVFRL :: forall a b. Proxy rl -> (b -> a -> b) -> b -> VariantF row a -> b
  foldMapVFRL :: forall a m. Monoid m => Proxy rl -> (a -> m) -> VariantF row a -> m
```

##### Instances
``` purescript
FoldableVFRL Nil ()
(IsSymbol k, Foldable f, FoldableVFRL rl r, Cons k f r r') => FoldableVFRL (Cons k f rl) r'
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

#### `VariantFMapCases`

``` purescript
class VariantFMapCases (rl :: RowList Type) (ri :: Row (Type -> Type)) (ro :: Row (Type -> Type)) (a :: Type) (b :: Type) | rl -> ri ro
```

##### Instances
``` purescript
(Cons sym f ri' ri, Cons sym g ro' ro, VariantFMapCases rl ri' ro' a b, TypeEquals k (f a -> g b)) => VariantFMapCases (Cons sym k rl) ri ro a b
VariantFMapCases Nil () () a b
```

#### `VariantFMatchCases`

``` purescript
class VariantFMatchCases rl vo a b | rl -> vo a b
```

##### Instances
``` purescript
(VariantFMatchCases rl vo' a b, Cons sym f vo' vo, TypeEquals k (f a -> b)) => VariantFMatchCases (Cons sym k rl) vo a b
VariantFMatchCases Nil () a b
```

