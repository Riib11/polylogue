## Module Data.Functor.Product

#### `Product`

``` purescript
newtype Product f g a
  = Product (Tuple (f a) (g a))
```

`Product f g` is the product of the two functors `f` and `g`.

##### Instances
``` purescript
Newtype (Product f g a) _
(Eq1 f, Eq1 g, Eq a) => Eq (Product f g a)
(Eq1 f, Eq1 g) => Eq1 (Product f g)
(Ord1 f, Ord1 g, Ord a) => Ord (Product f g a)
(Ord1 f, Ord1 g) => Ord1 (Product f g)
(Show (f a), Show (g a)) => Show (Product f g a)
(Functor f, Functor g) => Functor (Product f g)
(Apply f, Apply g) => Apply (Product f g)
(Applicative f, Applicative g) => Applicative (Product f g)
(Bind f, Bind g) => Bind (Product f g)
(Monad f, Monad g) => Monad (Product f g)
```

#### `product`

``` purescript
product :: forall f g a. f a -> g a -> Product f g a
```

Create a product.

#### `bihoistProduct`

``` purescript
bihoistProduct :: forall f g h i. (f ~> h) -> (g ~> i) -> (Product f g) ~> (Product h i)
```


