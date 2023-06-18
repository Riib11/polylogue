## Module Data.Array.ST.Iterator

#### `Iterator`

``` purescript
data Iterator r a
```

This type provides a slightly easier way of iterating over an array's
elements in an STArray computation, without having to keep track of
indices.

#### `iterator`

``` purescript
iterator :: forall r a. (Int -> Maybe a) -> ST r (Iterator r a)
```

Make an Iterator given an indexing function into an array (or anything
else). If `xs :: Array a`, the standard way to create an iterator over
`xs` is to use `iterator (xs !! _)`, where `(!!)` comes from `Data.Array`.

#### `iterate`

``` purescript
iterate :: forall r a. Iterator r a -> (a -> ST r Unit) -> ST r Unit
```

Perform an action once for each item left in an iterator. If the action
itself also advances the same iterator, `iterate` will miss those items
out.

#### `next`

``` purescript
next :: forall r a. Iterator r a -> ST r (Maybe a)
```

Get the next item out of an iterator, advancing it. Returns Nothing if the
Iterator is exhausted.

#### `peek`

``` purescript
peek :: forall r a. Iterator r a -> ST r (Maybe a)
```

Get the next item out of an iterator without advancing it.

#### `exhausted`

``` purescript
exhausted :: forall r a. Iterator r a -> ST r Boolean
```

Check whether an iterator has been exhausted.

#### `pushWhile`

``` purescript
pushWhile :: forall r a. (a -> Boolean) -> Iterator r a -> STArray r a -> ST r Unit
```

Extract elements from an iterator and push them on to an STArray for as
long as those elements satisfy a given predicate.

#### `pushAll`

``` purescript
pushAll :: forall r a. Iterator r a -> STArray r a -> ST r Unit
```

Push the entire remaining contents of an iterator onto an STArray.


