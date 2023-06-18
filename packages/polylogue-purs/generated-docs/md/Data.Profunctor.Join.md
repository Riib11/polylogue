## Module Data.Profunctor.Join

#### `Join`

``` purescript
newtype Join p a
  = Join (p a a)
```

Turns a `Profunctor` into a `Invariant` functor by equating the two type
arguments.

##### Instances
``` purescript
Newtype (Join p a) _
(Eq (p a a)) => Eq (Join p a)
(Ord (p a a)) => Ord (Join p a)
(Show (p a a)) => Show (Join p a)
(Semigroupoid p) => Semigroup (Join p a)
(Category p) => Monoid (Join p a)
(Profunctor p) => Invariant (Join p)
```


