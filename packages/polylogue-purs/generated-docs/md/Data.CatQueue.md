## Module Data.CatQueue

This module defines a strict double-ended queue.

The queue implementation is based on a pair of lists where all
operations require `O(1)` amortized time.

However, any single `uncons` operation may run in `O(n)` time.

See [Simple and Efficient Purely Functional Queues and Dequeues](http://www.westpoint.edu/eecs/SiteAssets/SitePages/Faculty%20Publication%20Documents/Okasaki/jfp95queue.pdf) (Okasaki 1995)

#### `CatQueue`

``` purescript
data CatQueue a
  = CatQueue (List a) (List a)
```

A strict double-ended queue (dequeue) representated using a pair of lists.

##### Instances
``` purescript
(Eq a) => Eq (CatQueue a)
(Ord a) => Ord (CatQueue a)
Semigroup (CatQueue a)
Monoid (CatQueue a)
(Show a) => Show (CatQueue a)
Foldable CatQueue
Unfoldable1 CatQueue
Unfoldable CatQueue
Traversable CatQueue
Functor CatQueue
Apply CatQueue
Applicative CatQueue
Bind CatQueue
Monad CatQueue
Alt CatQueue
Plus CatQueue
Alternative CatQueue
MonadPlus CatQueue
```

#### `empty`

``` purescript
empty :: forall a. CatQueue a
```

Create an empty queue.

Running time: `O(1)`

#### `null`

``` purescript
null :: forall a. CatQueue a -> Boolean
```

Test whether a queue is empty.

Running time: `O(1)`

#### `singleton`

``` purescript
singleton :: forall a. a -> CatQueue a
```

Create a queue containing a single element.

Running time: `O(1)`

#### `length`

``` purescript
length :: forall a. CatQueue a -> Int
```

Number of elements in queue.

Running time: `O(n)` in length of queue.

#### `cons`

``` purescript
cons :: forall a. a -> CatQueue a -> CatQueue a
```

Append an element to the beginning of the queue, creating a new queue.

Running time: `O(1)`

#### `snoc`

``` purescript
snoc :: forall a. CatQueue a -> a -> CatQueue a
```

Append an element to the end of the queue, creating a new queue.

Running time: `O(1)`

#### `uncons`

``` purescript
uncons :: forall a. CatQueue a -> Maybe (Tuple a (CatQueue a))
```

Decompose a queue into a `Tuple` of the first element and the rest of the queue.

Running time: `O(1)`

Note that any single operation may run in `O(n)`.

#### `unsnoc`

``` purescript
unsnoc :: forall a. CatQueue a -> Maybe (Tuple a (CatQueue a))
```

Decompose a queue into a `Tuple` of the last element and the rest of the queue.

Running time: `O(1)`

Note that any single operation may run in `O(n)`.

#### `fromFoldable`

``` purescript
fromFoldable :: forall f a. Foldable f => f a -> CatQueue a
```

Convert any `Foldable` into a `CatQueue`.

Running time: `O(n)`


