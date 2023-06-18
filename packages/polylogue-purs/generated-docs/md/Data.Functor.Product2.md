## Module Data.Functor.Product2

#### `Product2`

``` purescript
data Product2 f g a b
  = Product2 (f a b) (g a b)
```

The product of two types that both take two type parameters (e.g. `Either`,
`Tuple, etc.) where both type parameters are the same.

```purescript
Product2 (Tuple 4 true) (Right false) :: Product2 Tuple Either Int Boolean
Product2 (Tuple 4 true) (Left      8) :: Product2 Tuple Either Int Boolean
```

##### Instances
``` purescript
(Eq (f a b), Eq (g a b)) => Eq (Product2 f g a b)
(Ord (f a b), Ord (g a b)) => Ord (Product2 f g a b)
(Show (f a b), Show (g a b)) => Show (Product2 f g a b)
(Functor (f a), Functor (g a)) => Functor (Product2 f g a)
(Bifunctor f, Bifunctor g) => Bifunctor (Product2 f g)
(Biapply f, Biapply g) => Biapply (Product2 f g)
(Biapplicative f, Biapplicative g) => Biapplicative (Product2 f g)
(Profunctor f, Profunctor g) => Profunctor (Product2 f g)
```


