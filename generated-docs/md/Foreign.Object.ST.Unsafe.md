## Module Foreign.Object.ST.Unsafe

#### `unsafeFreeze`

``` purescript
unsafeFreeze :: forall a r. STObject r a -> ST r (Object a)
```

Unsafely get the object out of ST without copying it

If you later change the ST version of the map the pure value will also change.


