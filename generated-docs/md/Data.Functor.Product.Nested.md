## Module Data.Functor.Product.Nested

#### `Product1`

``` purescript
type Product1 a = T2 a (Const Unit)
```

#### `Product2`

``` purescript
type Product2 a b = T3 a b (Const Unit)
```

#### `Product3`

``` purescript
type Product3 a b c = T4 a b c (Const Unit)
```

#### `Product4`

``` purescript
type Product4 a b c d = T5 a b c d (Const Unit)
```

#### `Product5`

``` purescript
type Product5 a b c d e = T6 a b c d e (Const Unit)
```

#### `Product6`

``` purescript
type Product6 a b c d e f = T7 a b c d e f (Const Unit)
```

#### `Product7`

``` purescript
type Product7 a b c d e f g = T8 a b c d e f g (Const Unit)
```

#### `Product8`

``` purescript
type Product8 a b c d e f g h = T9 a b c d e f g h (Const Unit)
```

#### `Product9`

``` purescript
type Product9 a b c d e f g h i = T10 a b c d e f g h i (Const Unit)
```

#### `Product10`

``` purescript
type Product10 a b c d e f g h i j = T11 a b c d e f g h i j (Const Unit)
```

#### `T2`

``` purescript
type T2 a z = Product a z
```

#### `T3`

``` purescript
type T3 a b z = Product a (T2 b z)
```

#### `T4`

``` purescript
type T4 a b c z = Product a (T3 b c z)
```

#### `T5`

``` purescript
type T5 a b c d z = Product a (T4 b c d z)
```

#### `T6`

``` purescript
type T6 a b c d e z = Product a (T5 b c d e z)
```

#### `T7`

``` purescript
type T7 a b c d e f z = Product a (T6 b c d e f z)
```

#### `T8`

``` purescript
type T8 a b c d e f g z = Product a (T7 b c d e f g z)
```

#### `T9`

``` purescript
type T9 a b c d e f g h z = Product a (T8 b c d e f g h z)
```

#### `T10`

``` purescript
type T10 a b c d e f g h i z = Product a (T9 b c d e f g h i z)
```

#### `T11`

``` purescript
type T11 a b c d e f g h i j z = Product a (T10 b c d e f g h i j z)
```

#### `(</\>)`

``` purescript
infixr 6 product as </\>
```

#### `type (</\>)`

``` purescript
infixr 6 type Product as ype (</\>
```

#### `product1`

``` purescript
product1 :: forall a. a ~> (Product1 a)
```

#### `product2`

``` purescript
product2 :: forall a b x. a x -> b x -> Product2 a b x
```

#### `product3`

``` purescript
product3 :: forall a b c x. a x -> b x -> c x -> Product3 a b c x
```

#### `product4`

``` purescript
product4 :: forall a b c d x. a x -> b x -> c x -> d x -> Product4 a b c d x
```

#### `product5`

``` purescript
product5 :: forall a b c d e x. a x -> b x -> c x -> d x -> e x -> Product5 a b c d e x
```

#### `product6`

``` purescript
product6 :: forall a b c d e f x. a x -> b x -> c x -> d x -> e x -> f x -> Product6 a b c d e f x
```

#### `product7`

``` purescript
product7 :: forall a b c d e f g x. a x -> b x -> c x -> d x -> e x -> f x -> g x -> Product7 a b c d e f g x
```

#### `product8`

``` purescript
product8 :: forall a b c d e f g h x. a x -> b x -> c x -> d x -> e x -> f x -> g x -> h x -> Product8 a b c d e f g h x
```

#### `product9`

``` purescript
product9 :: forall a b c d e f g h i x. a x -> b x -> c x -> d x -> e x -> f x -> g x -> h x -> i x -> Product9 a b c d e f g h i x
```

#### `product10`

``` purescript
product10 :: forall a b c d e f g h i j x. a x -> b x -> c x -> d x -> e x -> f x -> g x -> h x -> i x -> j x -> Product10 a b c d e f g h i j x
```

#### `get1`

``` purescript
get1 :: forall a z. (T2 a z) ~> a
```

#### `get2`

``` purescript
get2 :: forall a b z. (T3 a b z) ~> b
```

#### `get3`

``` purescript
get3 :: forall a b c z. (T4 a b c z) ~> c
```

#### `get4`

``` purescript
get4 :: forall a b c d z. (T5 a b c d z) ~> d
```

#### `get5`

``` purescript
get5 :: forall a b c d e z. (T6 a b c d e z) ~> e
```

#### `get6`

``` purescript
get6 :: forall a b c d e f z. (T7 a b c d e f z) ~> f
```

#### `get7`

``` purescript
get7 :: forall a b c d e f g z. (T8 a b c d e f g z) ~> g
```

#### `get8`

``` purescript
get8 :: forall a b c d e f g h z. (T9 a b c d e f g h z) ~> h
```

#### `get9`

``` purescript
get9 :: forall a b c d e f g h i z. (T10 a b c d e f g h i z) ~> i
```

#### `get10`

``` purescript
get10 :: forall a b c d e f g h i j z. (T11 a b c d e f g h i j z) ~> j
```


