## Module Pipes.Prelude

#### `repeatM`

``` purescript
repeatM :: forall a m r. Monad m => m a -> Producer_ a m r
```

Repeat a monadic action indefinitely, `yield`ing each result

#### `replicateM`

``` purescript
replicateM :: forall a m. Monad m => Int -> m a -> Producer_ a m Unit
```

Repeat a monadic action a fixed number of times, `yield`ing each result

#### `mapM_`

``` purescript
mapM_ :: forall a m r. Monad m => (a -> m Unit) -> Consumer_ a m r
```

Consume all values using a monadic function

#### `drain`

``` purescript
drain :: forall a m r. Monad m => Consumer_ a m r
```

`discard` all incoming values

#### `map`

``` purescript
map :: forall a b m r. Monad m => (a -> b) -> Pipe a b m r
```

Apply a function to all values flowing downstream

#### `mapM`

``` purescript
mapM :: forall a b m r. Monad m => (a -> m b) -> Pipe a b m r
```

Apply a monadic function to all values flowing downstream

#### `sequence`

``` purescript
sequence :: forall a m r. Monad m => Pipe (m a) a m r
```

Convert a stream of actions to a stream of values

#### `mapFoldable`

``` purescript
mapFoldable :: forall a b m t r. Monad m => Foldable t => (a -> t b) -> Pipe a b m r
```

Apply a function to all values flowing downstream, and

#### `filter`

``` purescript
filter :: forall a m r. Monad m => (a -> Boolean) -> Pipe a a m r
```

`filter` only forwards values that satisfy the predicate.

#### `filterM`

``` purescript
filterM :: forall a m r. Monad m => (a -> m Boolean) -> Pipe a a m r
```

`filterM` only forwards values that satisfy the monadic predicate

#### `take`

``` purescript
take :: forall a m. Monad m => Int -> Pipe a a m Unit
```

`take n` only allows n values to pass through

#### `takeWhile`

``` purescript
takeWhile :: forall a m. Monad m => (a -> Boolean) -> Pipe a a m Unit
```

`takeWhile` allows values to pass downstream so long as they satisfy

#### `takeWhile'`

``` purescript
takeWhile' :: forall a m. Monad m => (a -> Boolean) -> Pipe a a m a
```

`takeWhile'` is a version of `takeWhile` that returns the value failing

#### `drop`

``` purescript
drop :: forall a m r. Monad m => Int -> Pipe a a m r
```

drop discards n values going downstream

#### `dropWhile`

``` purescript
dropWhile :: forall a m r. Monad m => (a -> Boolean) -> Pipe a a m r
```

dropWhile discards values going downstream until one violates the

#### `concat`

``` purescript
concat :: forall a m f r. Monad m => Foldable f => Pipe (f a) a m r
```

Flatten all 'Foldable' elements flowing downstream

#### `findIndices`

``` purescript
findIndices :: forall a m r. Monad m => (a -> Boolean) -> Pipe a Int m r
```

Outputs the indices of all elements that satisfied the predicate

#### `scan`

``` purescript
scan :: forall a b x m r. Monad m => (x -> a -> x) -> x -> (x -> b) -> Pipe a b m r
```

Left scan

#### `scanM`

``` purescript
scanM :: forall a b x m r. Monad m => (x -> a -> m x) -> m x -> (x -> m b) -> Pipe a b m r
```

Monadic left scan

#### `chain`

``` purescript
chain :: forall a m r. Monad m => (a -> m Unit) -> Pipe a a m r
```

Apply an action to all values flowing downstream

#### `show`

``` purescript
show :: forall a m r. Monad m => Show a => Pipe a String m r
```

Convert `Show`able values to `String`s

#### `seq`

``` purescript
seq :: forall a m r. Monad m => Pipe a a m r
```

Evaluate all values flowing downstream to WHNF
XXX: Is this needed in purescript?

#### `fold`

``` purescript
fold :: forall a b x m. Monad m => (x -> a -> x) -> x -> (x -> b) -> Producer a m Unit -> m b
```

Fold of the elements of a `Producer`

#### `fold'`

``` purescript
fold' :: forall a b x m r. Monad m => (x -> a -> x) -> x -> (x -> b) -> Producer a m r -> m (Tuple b r)
```

Fold of the elements of a `Producer` that preserves the return value

#### `foldM`

``` purescript
foldM :: forall a b x m. Monad m => (x -> a -> m x) -> m x -> (x -> m b) -> Producer a m Unit -> m b
```

Monadic fold of the elements of a `Producer`

#### `foldM'`

``` purescript
foldM' :: forall a b x m r. Monad m => (x -> a -> m x) -> m x -> (x -> m b) -> Producer a m r -> m (Tuple b r)
```

Monadic fold of the elements of a `Producer`

#### `all`

``` purescript
all :: forall a m. Monad m => (a -> Boolean) -> Producer a m Unit -> m Boolean
```

all determines whether all the elements of p satisfy the predicate.

#### `any`

``` purescript
any :: forall a m. Monad m => (a -> Boolean) -> Producer a m Unit -> m Boolean
```

any determines whether any element of p satisfies the predicate.

#### `and`

``` purescript
and :: forall m. Monad m => Producer Boolean m Unit -> m Boolean
```

Determines whether all elements are `True`

#### `or`

``` purescript
or :: forall m. Monad m => Producer Boolean m Unit -> m Boolean
```

Determines whether any element is `True`

#### `elem`

``` purescript
elem :: forall a m. Monad m => Eq a => a -> Producer a m Unit -> m Boolean
```

elem returns `True` if p has an element equal to a, `False` otherwise

#### `notElem`

``` purescript
notElem :: forall a m. Monad m => Eq a => a -> Producer a m Unit -> m Boolean
```

notElem returns `False` if p has an element equal to a, `True` otherwise

#### `find`

``` purescript
find :: forall a m. Monad m => (a -> Boolean) -> Producer a m Unit -> m (Maybe a)
```

Find the first element of a `Producer` that satisfies the predicate

#### `findIndex`

``` purescript
findIndex :: forall a m. Monad m => (a -> Boolean) -> Producer a m Unit -> m (Maybe Int)
```

Find the index of the first element of a `Producer` that satisfies the

#### `head`

``` purescript
head :: forall a m. Monad m => Producer a m Unit -> m (Maybe a)
```

Retrieve the first element from a `Producer`

#### `index`

``` purescript
index :: forall a m. Monad m => Int -> Producer a m Unit -> m (Maybe a)
```

Index into a `Producer`

#### `last`

``` purescript
last :: forall a m. Monad m => Producer a m Unit -> m (Maybe a)
```

Retrieve the last element from a `Producer`

#### `length`

``` purescript
length :: forall a m. Monad m => Producer a m Unit -> m Int
```

Count the number of elements in a `Producer`

#### `maximum`

``` purescript
maximum :: forall a m. Monad m => Ord a => Producer a m Unit -> m (Maybe a)
```

Find the maximum element of a `Producer`

#### `minimum`

``` purescript
minimum :: forall a m. Monad m => Ord a => Producer a m Unit -> m (Maybe a)
```

Find the minimum element of a `Producer`

#### `null`

``` purescript
null :: forall a m. Monad m => Producer a m Unit -> m Boolean
```

Determine if a `Producer` is empty

#### `toList`

``` purescript
toList :: forall a. Producer a Identity Unit -> List a
```

Convert a pure `Producer` into a list

#### `toListM`

``` purescript
toListM :: forall a m. Monad m => Producer a m Unit -> m (List a)
```


