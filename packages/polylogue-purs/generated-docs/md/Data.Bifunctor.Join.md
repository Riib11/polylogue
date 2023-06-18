## Module Data.Bifunctor.Join

#### `Join`

``` purescript
newtype Join p a
  = Join (p a a)
```

Turns a `Bifunctor` into a `Functor` by equating the two type arguments.

##### Instances
``` purescript
Newtype (Join p a) _
(Eq (p a a)) => Eq (Join p a)
(Ord (p a a)) => Ord (Join p a)
(Show (p a a)) => Show (Join p a)
(Bifunctor p) => Functor (Join p)
(Biapply p) => Apply (Join p)
(Biapplicative p) => Applicative (Join p)
```


