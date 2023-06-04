## Module Data.Either.Nested

Utilities for n-eithers: sums types with more than two terms built from nested eithers.

Nested eithers arise naturally in sum combinators. You shouldn't
represent sum data using nested eithers, but if combinators you're working with
create them, utilities in this module will allow to to more easily work
with them, including translating to and from more traditional sum types.

```purescript
data Color = Red Number | Green Number | Blue Number

fromEither3 :: Either3 Number Number Number -> Color
fromEither3 = either3 Red Green Blue

toEither3 :: Color -> Either3 Number Number Number
toEither3 (Red   v) = in1 v
toEither3 (Green v) = in2 v
toEither3 (Blue  v) = in3 v
```

#### `type (\/)`

``` purescript
infixr 6 type Either as ype (\/
```

#### `(\/)`

``` purescript
infixr 6 either as \/
```

The `\/` operator alias for the `either` function allows easy matching on nested Eithers. For example, consider the function

```purescript
f :: (Int \/ String \/ Boolean) -> String
f (Left x) = show x
f (Right (Left y)) = y
f (Right (Right z)) = if z then "Yes" else "No"
```

The `\/` operator alias allows us to rewrite this function as

```purescript
f :: (Int \/ String \/ Boolean) -> String
f = show \/ identity \/ if _ then "Yes" else "No"
```

#### `in1`

``` purescript
in1 :: forall a z. a -> a \/ z
```

#### `in2`

``` purescript
in2 :: forall a b z. b -> a \/ b \/ z
```

#### `in3`

``` purescript
in3 :: forall a b c z. c -> a \/ b \/ c \/ z
```

#### `in4`

``` purescript
in4 :: forall a b c d z. d -> a \/ b \/ c \/ d \/ z
```

#### `in5`

``` purescript
in5 :: forall a b c d e z. e -> a \/ b \/ c \/ d \/ e \/ z
```

#### `in6`

``` purescript
in6 :: forall a b c d e f z. f -> a \/ b \/ c \/ d \/ e \/ f \/ z
```

#### `in7`

``` purescript
in7 :: forall a b c d e f g z. g -> a \/ b \/ c \/ d \/ e \/ f \/ g \/ z
```

#### `in8`

``` purescript
in8 :: forall a b c d e f g h z. h -> a \/ b \/ c \/ d \/ e \/ f \/ g \/ h \/ z
```

#### `in9`

``` purescript
in9 :: forall a b c d e f g h i z. i -> a \/ b \/ c \/ d \/ e \/ f \/ g \/ h \/ i \/ z
```

#### `in10`

``` purescript
in10 :: forall a b c d e f g h i j z. j -> a \/ b \/ c \/ d \/ e \/ f \/ g \/ h \/ i \/ j \/ z
```

#### `at1`

``` purescript
at1 :: forall r a z. r -> (a -> r) -> a \/ z -> r
```

#### `at2`

``` purescript
at2 :: forall r a b z. r -> (b -> r) -> a \/ b \/ z -> r
```

#### `at3`

``` purescript
at3 :: forall r a b c z. r -> (c -> r) -> a \/ b \/ c \/ z -> r
```

#### `at4`

``` purescript
at4 :: forall r a b c d z. r -> (d -> r) -> a \/ b \/ c \/ d \/ z -> r
```

#### `at5`

``` purescript
at5 :: forall r a b c d e z. r -> (e -> r) -> a \/ b \/ c \/ d \/ e \/ z -> r
```

#### `at6`

``` purescript
at6 :: forall r a b c d e f z. r -> (f -> r) -> a \/ b \/ c \/ d \/ e \/ f \/ z -> r
```

#### `at7`

``` purescript
at7 :: forall r a b c d e f g z. r -> (g -> r) -> a \/ b \/ c \/ d \/ e \/ f \/ g \/ z -> r
```

#### `at8`

``` purescript
at8 :: forall r a b c d e f g h z. r -> (h -> r) -> a \/ b \/ c \/ d \/ e \/ f \/ g \/ h \/ z -> r
```

#### `at9`

``` purescript
at9 :: forall r a b c d e f g h i z. r -> (i -> r) -> a \/ b \/ c \/ d \/ e \/ f \/ g \/ h \/ i \/ z -> r
```

#### `at10`

``` purescript
at10 :: forall r a b c d e f g h i j z. r -> (j -> r) -> a \/ b \/ c \/ d \/ e \/ f \/ g \/ h \/ i \/ j \/ z -> r
```

#### `Either1`

``` purescript
type Either1 a = a \/ Void
```

#### `Either2`

``` purescript
type Either2 a b = a \/ b \/ Void
```

#### `Either3`

``` purescript
type Either3 a b c = a \/ b \/ c \/ Void
```

#### `Either4`

``` purescript
type Either4 a b c d = a \/ b \/ c \/ d \/ Void
```

#### `Either5`

``` purescript
type Either5 a b c d e = a \/ b \/ c \/ d \/ e \/ Void
```

#### `Either6`

``` purescript
type Either6 a b c d e f = a \/ b \/ c \/ d \/ e \/ f \/ Void
```

#### `Either7`

``` purescript
type Either7 a b c d e f g = a \/ b \/ c \/ d \/ e \/ f \/ g \/ Void
```

#### `Either8`

``` purescript
type Either8 a b c d e f g h = a \/ b \/ c \/ d \/ e \/ f \/ g \/ h \/ Void
```

#### `Either9`

``` purescript
type Either9 a b c d e f g h i = a \/ b \/ c \/ d \/ e \/ f \/ g \/ h \/ i \/ Void
```

#### `Either10`

``` purescript
type Either10 a b c d e f g h i j = a \/ b \/ c \/ d \/ e \/ f \/ g \/ h \/ i \/ j \/ Void
```

#### `either1`

``` purescript
either1 :: forall a. Either1 a -> a
```

#### `either2`

``` purescript
either2 :: forall r a b. (a -> r) -> (b -> r) -> Either2 a b -> r
```

#### `either3`

``` purescript
either3 :: forall r a b c. (a -> r) -> (b -> r) -> (c -> r) -> Either3 a b c -> r
```

#### `either4`

``` purescript
either4 :: forall r a b c d. (a -> r) -> (b -> r) -> (c -> r) -> (d -> r) -> Either4 a b c d -> r
```

#### `either5`

``` purescript
either5 :: forall r a b c d e. (a -> r) -> (b -> r) -> (c -> r) -> (d -> r) -> (e -> r) -> Either5 a b c d e -> r
```

#### `either6`

``` purescript
either6 :: forall r a b c d e f. (a -> r) -> (b -> r) -> (c -> r) -> (d -> r) -> (e -> r) -> (f -> r) -> Either6 a b c d e f -> r
```

#### `either7`

``` purescript
either7 :: forall r a b c d e f g. (a -> r) -> (b -> r) -> (c -> r) -> (d -> r) -> (e -> r) -> (f -> r) -> (g -> r) -> Either7 a b c d e f g -> r
```

#### `either8`

``` purescript
either8 :: forall r a b c d e f g h. (a -> r) -> (b -> r) -> (c -> r) -> (d -> r) -> (e -> r) -> (f -> r) -> (g -> r) -> (h -> r) -> Either8 a b c d e f g h -> r
```

#### `either9`

``` purescript
either9 :: forall r a b c d e f g h i. (a -> r) -> (b -> r) -> (c -> r) -> (d -> r) -> (e -> r) -> (f -> r) -> (g -> r) -> (h -> r) -> (i -> r) -> Either9 a b c d e f g h i -> r
```

#### `either10`

``` purescript
either10 :: forall r a b c d e f g h i j. (a -> r) -> (b -> r) -> (c -> r) -> (d -> r) -> (e -> r) -> (f -> r) -> (g -> r) -> (h -> r) -> (i -> r) -> (j -> r) -> Either10 a b c d e f g h i j -> r
```


