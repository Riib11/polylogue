## Module Foreign.Object.Unsafe

#### `unsafeIndex`

``` purescript
unsafeIndex :: forall a. Object a -> String -> a
```

Unsafely get the value for a key in a object.

This function does not check whether the key exists in the object.


