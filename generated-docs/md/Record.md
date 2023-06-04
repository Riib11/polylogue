## Module Record

#### `get`

``` purescript
get :: forall r r' l a. IsSymbol l => Cons l a r' r => Proxy l -> Record r -> a
```

Get a property for a label which is specified using a value-level proxy for
a type-level string.

For example:

```purescript
get (Proxy :: Proxy "x") :: forall r a. { x :: a | r } -> a
```

#### `set`

``` purescript
set :: forall r1 r2 r l a b. IsSymbol l => Cons l a r r1 => Cons l b r r2 => Proxy l -> b -> Record r1 -> Record r2
```

Set a property for a label which is specified using a value-level proxy for
a type-level string.

For example:

```purescript
set (Proxy :: Proxy "x")
  :: forall r a b. a -> { x :: b | r } -> { x :: a | r }
```

#### `modify`

``` purescript
modify :: forall r1 r2 r l a b. IsSymbol l => Cons l a r r1 => Cons l b r r2 => Proxy l -> (a -> b) -> Record r1 -> Record r2
```

Modify a property for a label which is specified using a value-level proxy for
a type-level string.

For example:

```purescript
modify (Proxy :: Proxy "x")
  :: forall r a b. (a -> b) -> { x :: a | r } -> { x :: b | r }
```

#### `insert`

``` purescript
insert :: forall r1 r2 l a. IsSymbol l => Lacks l r1 => Cons l a r1 r2 => Proxy l -> a -> Record r1 -> Record r2
```

Insert a new property for a label which is specified using a value-level proxy for
a type-level string.

For example:

```purescript
insert (Proxy :: Proxy "x")
  :: forall r a. Lacks "x" r => a -> { | r } -> { x :: a | r }
```

#### `delete`

``` purescript
delete :: forall r1 r2 l a. IsSymbol l => Lacks l r1 => Cons l a r1 r2 => Proxy l -> Record r2 -> Record r1
```

Delete a property for a label which is specified using a value-level proxy for
a type-level string.

Note that the type of the resulting row must _lack_ the specified property.
Since duplicate labels are allowed, this is checked with a type class constraint.

For example:

```purescript
delete (Proxy :: Proxy "x")
  :: forall r a. Lacks "x" r => { x :: a | r } -> { | r }
```

#### `rename`

``` purescript
rename :: forall prev next ty input inter output. IsSymbol prev => IsSymbol next => Cons prev ty inter input => Lacks prev inter => Cons next ty inter output => Lacks next inter => Proxy prev -> Proxy next -> Record input -> Record output
```

Rename a property for a label which is specified using a value-level proxy for
a type-level string.

Note that the type of the resulting row must _lack_ the specified property.
Since duplicate labels are allowed, this is checked with a type class constraint.

For example:

```purescript
rename (Proxy :: Proxy "x") (Proxy :: Proxy "y")
  :: forall a r. Lacks "x" r => Lacks "y" r => { x :: a | r} -> { y :: a | r}
```

#### `equal`

``` purescript
equal :: forall r rs. RowToList r rs => EqualFields rs r => Record r -> Record r -> Boolean
```

Check two records of the same type for equality.

#### `merge`

``` purescript
merge :: forall r1 r2 r3 r4. Union r1 r2 r3 => Nub r3 r4 => Record r1 -> Record r2 -> Record r4
```

Merges two records with the first record's labels taking precedence in the
case of overlaps.

For example:

```purescript
merge { x: 1, y: "y" } { y: 2, z: true }
 :: { x :: Int, y :: String, z :: Boolean }
```

#### `union`

``` purescript
union :: forall r1 r2 r3. Union r1 r2 r3 => Record r1 -> Record r2 -> Record r3
```

Merges two records with the first record's labels taking precedence in the
case of overlaps. Unlike `merge`, this does not remove duplicate labels
from the resulting record type. This can result in better inference for
some pipelines, deferring the need for a `Nub` constraint.

For example:

```purescript
union { x: 1, y: "y" } { y: 2, z: true }
 :: { x :: Int, y :: String, y :: Int, z :: Boolean }
```

#### `disjointUnion`

``` purescript
disjointUnion :: forall r1 r2 r3. Union r1 r2 r3 => Nub r3 r3 => Record r1 -> Record r2 -> Record r3
```

Merges two records where no labels overlap. This restriction exhibits
better inference than `merge` when the resulting record type is known,
but one argument is not.

For example, hole `?help` is inferred to have type `{ b :: Int }` here:

```purescript
disjointUnion { a: 5 } ?help :: { a :: Int, b :: Int }
```

#### `nub`

``` purescript
nub :: forall r1 r2. Nub r1 r2 => Record r1 -> Record r2
```

A coercion which removes duplicate labels from a record's type.

#### `EqualFields`

``` purescript
class EqualFields (rs :: RowList Type) (row :: Row Type) | rs -> row where
  equalFields :: Proxy rs -> Record row -> Record row -> Boolean
```

##### Instances
``` purescript
(IsSymbol name, Eq ty, Cons name ty tailRow row, EqualFields tail row) => EqualFields (Cons name ty tail) row
EqualFields Nil row
```


