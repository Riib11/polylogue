## Module Data.Variant.Internal

#### `VariantRep`

``` purescript
newtype VariantRep a
  = VariantRep { type :: String, value :: a }
```

#### `VariantCase`

``` purescript
data VariantCase
```

#### `VariantFCase`

``` purescript
data VariantFCase t0
```

#### `VariantTags`

``` purescript
class VariantTags rl  where
  variantTags :: Proxy rl -> List String
```

##### Instances
``` purescript
VariantTags Nil
(VariantTags rs, IsSymbol sym) => VariantTags (Cons sym a rs)
```

#### `Contractable`

``` purescript
class Contractable gt lt  where
  contractWith :: forall proxy1 proxy2 f a. Alternative f => proxy1 gt -> proxy2 lt -> String -> a -> f a
```

##### Instances
``` purescript
(RowToList lt ltl, Union lt a gt, VariantTags ltl) => Contractable gt lt
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

#### `VariantFMatchCases`

``` purescript
class VariantFMatchCases rl vo a b | rl -> vo a b
```

##### Instances
``` purescript
(VariantFMatchCases rl vo' a b, Cons sym f vo' vo, TypeEquals k (f a -> b)) => VariantFMatchCases (Cons sym k rl) vo a b
VariantFMatchCases Nil () a b
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

#### `VariantFMapCases`

``` purescript
class VariantFMapCases (rl :: RowList Type) (ri :: Row (Type -> Type)) (ro :: Row (Type -> Type)) (a :: Type) (b :: Type) | rl -> ri ro
```

##### Instances
``` purescript
(Cons sym f ri' ri, Cons sym g ro' ro, VariantFMapCases rl ri' ro' a b, TypeEquals k (f a -> g b)) => VariantFMapCases (Cons sym k rl) ri ro a b
VariantFMapCases Nil () () a b
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

#### `VariantFTraverseCases`

``` purescript
class VariantFTraverseCases (m :: Type -> Type) (rl :: RowList Type) (ri :: Row (Type -> Type)) (ro :: Row (Type -> Type)) (a :: Type) (b :: Type) | rl -> ri ro
```

##### Instances
``` purescript
(Cons sym f ri' ri, Cons sym g ro' ro, VariantFTraverseCases m rl ri' ro' a b, TypeEquals k (f a -> m (g b))) => VariantFTraverseCases m (Cons sym k rl) ri ro a b
VariantFTraverseCases m Nil () () a b
```

#### `lookup`

``` purescript
lookup :: forall a. String -> String -> List String -> List a -> a
```

#### `lookupTag`

``` purescript
lookupTag :: String -> List String -> Boolean
```

A specialized lookup function which bails early. Foldable's `elem`
is always worst-case.

#### `lookupEq`

``` purescript
lookupEq :: List String -> List (VariantCase -> VariantCase -> Boolean) -> VariantRep VariantCase -> VariantRep VariantCase -> Boolean
```

#### `lookupOrd`

``` purescript
lookupOrd :: List String -> List (VariantCase -> VariantCase -> Ordering) -> VariantRep VariantCase -> VariantRep VariantCase -> Ordering
```

#### `lookupLast`

``` purescript
lookupLast :: forall a b. String -> (a -> b) -> List String -> List a -> { type :: String, value :: b }
```

#### `lookupFirst`

``` purescript
lookupFirst :: forall a b. String -> (a -> b) -> List String -> List a -> { type :: String, value :: b }
```

#### `lookupPred`

``` purescript
lookupPred :: forall a. VariantRep a -> List String -> List (BoundedDict a) -> List (BoundedEnumDict a) -> Maybe (VariantRep a)
```

#### `lookupSucc`

``` purescript
lookupSucc :: forall a. VariantRep a -> List String -> List (BoundedDict a) -> List (BoundedEnumDict a) -> Maybe (VariantRep a)
```

#### `lookupCardinality`

``` purescript
lookupCardinality :: forall a. List (BoundedEnumDict a) -> Int
```

#### `lookupFromEnum`

``` purescript
lookupFromEnum :: forall a. VariantRep a -> List String -> List (BoundedEnumDict a) -> Int
```

#### `lookupToEnum`

``` purescript
lookupToEnum :: forall a. Int -> List String -> List (BoundedEnumDict a) -> Maybe (VariantRep a)
```

#### `BoundedDict`

``` purescript
type BoundedDict a = { bottom :: a, top :: a }
```

#### `BoundedEnumDict`

``` purescript
type BoundedEnumDict a = { cardinality :: Int, fromEnum :: a -> Int, pred :: a -> Maybe a, succ :: a -> Maybe a, toEnum :: Int -> Maybe a }
```

#### `impossible`

``` purescript
impossible :: forall a. String -> a
```


### Re-exported from Record.Unsafe:

#### `unsafeHas`

``` purescript
unsafeHas :: forall r1. String -> Record r1 -> Boolean
```

Checks if a record has a key, using a string for the key.

#### `unsafeGet`

``` purescript
unsafeGet :: forall r a. String -> Record r -> a
```

Unsafely gets a value from a record, using a string for the key.

If the key does not exist this will cause a runtime error elsewhere.

