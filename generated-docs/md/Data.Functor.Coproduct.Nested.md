## Module Data.Functor.Coproduct.Nested

#### `Coproduct1`

``` purescript
type Coproduct1 a = C2 a (Const Void)
```

#### `Coproduct2`

``` purescript
type Coproduct2 a b = C3 a b (Const Void)
```

#### `Coproduct3`

``` purescript
type Coproduct3 a b c = C4 a b c (Const Void)
```

#### `Coproduct4`

``` purescript
type Coproduct4 a b c d = C5 a b c d (Const Void)
```

#### `Coproduct5`

``` purescript
type Coproduct5 a b c d e = C6 a b c d e (Const Void)
```

#### `Coproduct6`

``` purescript
type Coproduct6 a b c d e f = C7 a b c d e f (Const Void)
```

#### `Coproduct7`

``` purescript
type Coproduct7 a b c d e f g = C8 a b c d e f g (Const Void)
```

#### `Coproduct8`

``` purescript
type Coproduct8 a b c d e f g h = C9 a b c d e f g h (Const Void)
```

#### `Coproduct9`

``` purescript
type Coproduct9 a b c d e f g h i = C10 a b c d e f g h i (Const Void)
```

#### `Coproduct10`

``` purescript
type Coproduct10 a b c d e f g h i j = C11 a b c d e f g h i j (Const Void)
```

#### `C2`

``` purescript
type C2 a z = Coproduct a z
```

#### `C3`

``` purescript
type C3 a b z = Coproduct a (C2 b z)
```

#### `C4`

``` purescript
type C4 a b c z = Coproduct a (C3 b c z)
```

#### `C5`

``` purescript
type C5 a b c d z = Coproduct a (C4 b c d z)
```

#### `C6`

``` purescript
type C6 a b c d e z = Coproduct a (C5 b c d e z)
```

#### `C7`

``` purescript
type C7 a b c d e f z = Coproduct a (C6 b c d e f z)
```

#### `C8`

``` purescript
type C8 a b c d e f g z = Coproduct a (C7 b c d e f g z)
```

#### `C9`

``` purescript
type C9 a b c d e f g h z = Coproduct a (C8 b c d e f g h z)
```

#### `C10`

``` purescript
type C10 a b c d e f g h i z = Coproduct a (C9 b c d e f g h i z)
```

#### `C11`

``` purescript
type C11 a b c d e f g h i j z = Coproduct a (C10 b c d e f g h i j z)
```

#### `(<\/>)`

``` purescript
infixr 6 coproduct as <\/>
```

#### `type (<\/>)`

``` purescript
infixr 6 type Coproduct as ype (<\/>
```

#### `in1`

``` purescript
in1 :: forall a z. a ~> (C2 a z)
```

#### `in2`

``` purescript
in2 :: forall a b z. b ~> (C3 a b z)
```

#### `in3`

``` purescript
in3 :: forall a b c z. c ~> (C4 a b c z)
```

#### `in4`

``` purescript
in4 :: forall a b c d z. d ~> (C5 a b c d z)
```

#### `in5`

``` purescript
in5 :: forall a b c d e z. e ~> (C6 a b c d e z)
```

#### `in6`

``` purescript
in6 :: forall a b c d e f z. f ~> (C7 a b c d e f z)
```

#### `in7`

``` purescript
in7 :: forall a b c d e f g z. g ~> (C8 a b c d e f g z)
```

#### `in8`

``` purescript
in8 :: forall a b c d e f g h z. h ~> (C9 a b c d e f g h z)
```

#### `in9`

``` purescript
in9 :: forall a b c d e f g h i z. i ~> (C10 a b c d e f g h i z)
```

#### `in10`

``` purescript
in10 :: forall a b c d e f g h i j z. j ~> (C11 a b c d e f g h i j z)
```

#### `at1`

``` purescript
at1 :: forall r x a z. r -> (a x -> r) -> C2 a z x -> r
```

#### `at2`

``` purescript
at2 :: forall r x a b z. r -> (b x -> r) -> C3 a b z x -> r
```

#### `at3`

``` purescript
at3 :: forall r x a b c z. r -> (c x -> r) -> C4 a b c z x -> r
```

#### `at4`

``` purescript
at4 :: forall r x a b c d z. r -> (d x -> r) -> C5 a b c d z x -> r
```

#### `at5`

``` purescript
at5 :: forall r x a b c d e z. r -> (e x -> r) -> C6 a b c d e z x -> r
```

#### `at6`

``` purescript
at6 :: forall r x a b c d e f z. r -> (f x -> r) -> C7 a b c d e f z x -> r
```

#### `at7`

``` purescript
at7 :: forall r x a b c d e f g z. r -> (g x -> r) -> C8 a b c d e f g z x -> r
```

#### `at8`

``` purescript
at8 :: forall r x a b c d e f g h z. r -> (h x -> r) -> C9 a b c d e f g h z x -> r
```

#### `at9`

``` purescript
at9 :: forall r x a b c d e f g h i z. r -> (i x -> r) -> C10 a b c d e f g h i z x -> r
```

#### `at10`

``` purescript
at10 :: forall r x a b c d e f g h i j z. r -> (j x -> r) -> C11 a b c d e f g h i j z x -> r
```

#### `coproduct1`

``` purescript
coproduct1 :: forall a. (Coproduct1 a) ~> a
```

#### `coproduct2`

``` purescript
coproduct2 :: forall r x a b. (a x -> r) -> (b x -> r) -> Coproduct2 a b x -> r
```

#### `coproduct3`

``` purescript
coproduct3 :: forall r x a b c. (a x -> r) -> (b x -> r) -> (c x -> r) -> Coproduct3 a b c x -> r
```

#### `coproduct4`

``` purescript
coproduct4 :: forall r x a b c d. (a x -> r) -> (b x -> r) -> (c x -> r) -> (d x -> r) -> Coproduct4 a b c d x -> r
```

#### `coproduct5`

``` purescript
coproduct5 :: forall r x a b c d e. (a x -> r) -> (b x -> r) -> (c x -> r) -> (d x -> r) -> (e x -> r) -> Coproduct5 a b c d e x -> r
```

#### `coproduct6`

``` purescript
coproduct6 :: forall r x a b c d e f. (a x -> r) -> (b x -> r) -> (c x -> r) -> (d x -> r) -> (e x -> r) -> (f x -> r) -> Coproduct6 a b c d e f x -> r
```

#### `coproduct7`

``` purescript
coproduct7 :: forall r x a b c d e f g. (a x -> r) -> (b x -> r) -> (c x -> r) -> (d x -> r) -> (e x -> r) -> (f x -> r) -> (g x -> r) -> Coproduct7 a b c d e f g x -> r
```

#### `coproduct8`

``` purescript
coproduct8 :: forall r x a b c d e f g h. (a x -> r) -> (b x -> r) -> (c x -> r) -> (d x -> r) -> (e x -> r) -> (f x -> r) -> (g x -> r) -> (h x -> r) -> Coproduct8 a b c d e f g h x -> r
```

#### `coproduct9`

``` purescript
coproduct9 :: forall r x a b c d e f g h i. (a x -> r) -> (b x -> r) -> (c x -> r) -> (d x -> r) -> (e x -> r) -> (f x -> r) -> (g x -> r) -> (h x -> r) -> (i x -> r) -> Coproduct9 a b c d e f g h i x -> r
```

#### `coproduct10`

``` purescript
coproduct10 :: forall r x a b c d e f g h i j. (a x -> r) -> (b x -> r) -> (c x -> r) -> (d x -> r) -> (e x -> r) -> (f x -> r) -> (g x -> r) -> (h x -> r) -> (i x -> r) -> (j x -> r) -> Coproduct10 a b c d e f g h i j x -> r
```


