## Module Record.Builder

#### `Builder`

``` purescript
newtype Builder a b
```

A `Builder` can be used to `build` a record by incrementally adding
fields in-place, instead of using `insert` and repeatedly generating new
immutable records which need to be garbage collected.

The mutations accumulated in a `Builder` are safe because intermediate states can't be
observed. These mutations, then, are performed all-at-once in the `build` function.

The `Category` instance for `Builder` can be used to compose builders.

For example:

```purescript
build (insert x 42 >>> insert y "testing") {} :: { x :: Int, y :: String }
```

##### Instances
``` purescript
Semigroupoid Builder
Category Builder
```

#### `build`

``` purescript
build :: forall r1 r2. Builder (Record r1) (Record r2) -> Record r1 -> Record r2
```

Build a record, starting from some other record.

#### `buildFromScratch`

``` purescript
buildFromScratch :: forall r. Builder (Record ()) (Record r) -> Record r
```

Build a record from scratch.

#### `flip`

``` purescript
flip :: forall r1 r2 r3. (Record r1 -> Builder (Record r2) (Record r3)) -> Record r2 -> Builder (Record r1) (Record r3)
```

Flip a function of one argument returning a builder.

#### `insert`

``` purescript
insert :: forall l a r1 r2. Cons l a r1 r2 => Lacks l r1 => IsSymbol l => Proxy l -> a -> Builder (Record r1) (Record r2)
```

Build by inserting a new field.

#### `modify`

``` purescript
modify :: forall l a b r r1 r2. Cons l a r r1 => Cons l b r r2 => IsSymbol l => Proxy l -> (a -> b) -> Builder (Record r1) (Record r2)
```

Build by modifying an existing field.

#### `delete`

``` purescript
delete :: forall l a r1 r2. IsSymbol l => Lacks l r1 => Cons l a r1 r2 => Proxy l -> Builder (Record r2) (Record r1)
```

Build by deleting an existing field.

#### `rename`

``` purescript
rename :: forall l1 l2 a r1 r2 r3. IsSymbol l1 => IsSymbol l2 => Cons l1 a r2 r1 => Lacks l1 r2 => Cons l2 a r2 r3 => Lacks l2 r2 => Proxy l1 -> Proxy l2 -> Builder (Record r1) (Record r3)
```

Build by renaming an existing field.

#### `merge`

``` purescript
merge :: forall r1 r2 r3 r4. Union r1 r2 r3 => Nub r3 r4 => Record r1 -> Builder (Record r2) (Record r4)
```

Build by merging existing fields from another record, taking precedence
in the case of overlaps.

For example:

```purescript
build (merge { x: 1, y: "y" }) { y: 2, z: true }
 :: { x :: Int, y :: String, z :: Boolean }
```

#### `union`

``` purescript
union :: forall r1 r2 r3. Union r1 r2 r3 => Record r1 -> Builder (Record r2) (Record r3)
```

Build by merging existing fields from another record, taking precedence
in the case of overlaps. Unlike `merge`, this does not remove duplicate
labels from the resulting record type. This can result in better inference
for some pipelines, deferring the need for a `Nub` constraint.

For example:

```purescript
build (union { x: 1, y: "y" }) { y: 2, z: true }
 :: { x :: Int, y :: String, y :: Int, z :: Boolean }
```

#### `disjointUnion`

``` purescript
disjointUnion :: forall r1 r2 r3. Union r1 r2 r3 => Nub r3 r3 => Record r1 -> Builder (Record r2) (Record r3)
```

Build by merging some disjoint set of fields from another record.

#### `nub`

``` purescript
nub :: forall r1 r2. Nub r1 r2 => Builder (Record r1) (Record r2)
```

A coercion which removes duplicate labels from a record's type.


