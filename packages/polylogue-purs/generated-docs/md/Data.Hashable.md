## Module Data.Hashable

#### `Hashable`

``` purescript
class (Eq a) <= Hashable a  where
  hash :: a -> Int
```

The `Hashable` type class represents types with decidable
equality and a hash function for use in hash-based algorithms and
data structures, not cryptography.

Instances of `Hashable` must satisfy the following law:

```PureScript
(a == b) `implies` (hash a == hash b)
```

Note that while `hash = const 0` is a law-abiding implementation,
one would usually prefer more discrimination. Hash-based data
structures and algorithms tend to perform badly in the presence
of excessive numbers of collisions.

Hash values produced by `hash` should not be relied upon to be
stable accross multiple executions of a program and should not be
stored externally. While we currently do not do this, we might
want to use a fresh salt for every execution in the future.

##### Instances
``` purescript
Hashable Boolean
Hashable Int
Hashable Number
Hashable Char
Hashable String
(Hashable a) => Hashable (Array a)
(Hashable a) => Hashable (List a)
(Hashable a, Hashable b) => Hashable (Tuple a b)
(Hashable a) => Hashable (Maybe a)
(Hashable a, Hashable b) => Hashable (Either a b)
Hashable Unit
Hashable Void
(RowToList r l, HashableRecord l r, EqRecord l r) => Hashable (Record r)
```

#### `HashableRecord`

``` purescript
class (EqRecord l r) <= HashableRecord l r | l -> r where
  hashRecord :: Proxy l -> Record r -> Int
```

##### Instances
``` purescript
HashableRecord Nil r
(Hashable vt, HashableRecord tl r, IsSymbol l, Cons l vt whatev r) => HashableRecord (Cons l vt tl) r
```


