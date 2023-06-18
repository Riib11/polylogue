## Module Data.Functor.Flip

#### `Flip`

``` purescript
newtype Flip p a b
  = Flip (p b a)
```

Flips the order of the type arguments of a `Bifunctor`.

##### Instances
``` purescript
Newtype (Flip p a b) _
(Eq (p b a)) => Eq (Flip p a b)
(Ord (p b a)) => Ord (Flip p a b)
(Show (p a b)) => Show (Flip p b a)
(Bifunctor p) => Functor (Flip p a)
(Bifunctor p) => Bifunctor (Flip p)
(Biapply p) => Biapply (Flip p)
(Biapplicative p) => Biapplicative (Flip p)
(Profunctor p) => Contravariant (Flip p b)
(Semigroupoid p) => Semigroupoid (Flip p)
(Category p) => Category (Flip p)
```


