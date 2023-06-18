## Module Data.CatList

This module defines a strict catenable list.

The implementation is based on a queue where all operations require
`O(1)` amortized time.

However, any single `uncons` operation may run in `O(n)` time.

See [Purely Functional Data Structures](http://www.cs.cmu.edu/~rwh/theses/okasaki.pdf) (Okasaki 1996)

#### `CatList`

``` purescript
data CatList a
  = CatNil
  | CatCons a (CatQueue (CatList a))
```

A strict catenable list.

`CatList` may be empty, represented by `CatNil`.

`CatList` may be non-empty, represented by `CatCons`. The `CatCons`
data constructor takes the first element of the list and a queue of
`CatList`.

##### Instances
``` purescript
Semigroup (CatList a)
Monoid (CatList a)
(Show a) => Show (CatList a)
Foldable CatList
Unfoldable CatList
Unfoldable1 CatList
Traversable CatList
Functor CatList
Apply CatList
Applicative CatList
Bind CatList
Monad CatList
Alt CatList
Plus CatList
Alternative CatList
MonadPlus CatList
```

#### `empty`

``` purescript
empty :: forall a. CatList a
```

Create an empty catenable list.

Running time: `O(1)`

#### `null`

``` purescript
null :: forall a. CatList a -> Boolean
```

Test whether a catenable list is empty.

Running time: `O(1)`

#### `singleton`

``` purescript
singleton :: forall a. a -> CatList a
```

Create a catenable list with a single item.

Running time: `O(1)`

#### `length`

``` purescript
length :: forall a. CatList a -> Int
```

Number of elements in queue.

Running time: `O(n)` in length of queue.

#### `append`

``` purescript
append :: forall a. CatList a -> CatList a -> CatList a
```

Append all elements of a catenable list to the end of another
catenable list, create a new catenable list.

Running time: `O(1)`

#### `cons`

``` purescript
cons :: forall a. a -> CatList a -> CatList a
```

Append an element to the beginning of the catenable list, creating a new
catenable list.

Running time: `O(1)`

#### `snoc`

``` purescript
snoc :: forall a. CatList a -> a -> CatList a
```

Append an element to the end of the catenable list, creating a new
catenable list.

Running time: `O(1)`

#### `uncons`

``` purescript
uncons :: forall a. CatList a -> Maybe (Tuple a (CatList a))
```

Decompose a catenable list into a `Tuple` of the first element and
the rest of the catenable list.

Running time: `O(1)`

Note that any single operation may run in `O(n)`.

#### `fromFoldable`

``` purescript
fromFoldable :: forall f. Foldable f => f ~> CatList
```

Convert any `Foldable` into a `CatList`.

Running time: `O(n)`


