## Module Test.Spec.Assertions

#### `AnyShow`

``` purescript
newtype AnyShow a
  = AnyShow a
```

A newtype with an unsafe `Show` instance for any type.
Useful if you want to test a type for which you cannot provide a `Show` instance.
Usage:
```purescript
(AnyShow $ MyInt 3) `A.shouldEqual` (AnyShow $ MyInt 3)
```

##### Instances
``` purescript
Newtype (AnyShow a) a
(Eq a) => Eq (AnyShow a)
Show (AnyShow a)
```

#### `expectError`

``` purescript
expectError :: forall m t. MonadError Error m => m t -> m Unit
```

#### `fail`

``` purescript
fail :: forall m. MonadThrow Error m => String -> m Unit
```

#### `shouldContain`

``` purescript
shouldContain :: forall m f a. MonadThrow Error m => Show a => Eq a => Show (f a) => Foldable f => f a -> a -> m Unit
```

#### `shouldEqual`

``` purescript
shouldEqual :: forall m t. MonadThrow Error m => Show t => Eq t => t -> t -> m Unit
```

#### `shouldNotContain`

``` purescript
shouldNotContain :: forall m f a. MonadThrow Error m => Show a => Eq a => Show (f a) => Foldable f => f a -> a -> m Unit
```

#### `shouldNotEqual`

``` purescript
shouldNotEqual :: forall m t. MonadThrow Error m => Show t => Eq t => t -> t -> m Unit
```

#### `shouldNotReturn`

``` purescript
shouldNotReturn :: forall m t. MonadThrow Error m => Eq t => Show t => m t -> t -> m Unit
```

Asserts that `m t` does not return `t`

#### `shouldNotSatisfy`

``` purescript
shouldNotSatisfy :: forall m t. MonadThrow Error m => Show t => t -> (t -> Boolean) -> m Unit
```

#### `shouldReturn`

``` purescript
shouldReturn :: forall m t. MonadThrow Error m => Eq t => Show t => m t -> t -> m Unit
```

Asserts that `m t` returns `t`

#### `shouldSatisfy`

``` purescript
shouldSatisfy :: forall m t. MonadThrow Error m => Show t => t -> (t -> Boolean) -> m Unit
```


