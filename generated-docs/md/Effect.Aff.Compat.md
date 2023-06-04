## Module Effect.Aff.Compat

This module provides compatability functions for constructing `Aff`s which
are defined via the FFI.

#### `EffectFnAff`

``` purescript
newtype EffectFnAff a
  = EffectFnAff (EffectFn2 (EffectFnCb Error) (EffectFnCb a) EffectFnCanceler)
```

#### `EffectFnCanceler`

``` purescript
newtype EffectFnCanceler
  = EffectFnCanceler (EffectFn3 Error (EffectFnCb Error) (EffectFnCb Unit) Unit)
```

#### `EffectFnCb`

``` purescript
type EffectFnCb a = EffectFn1 a Unit
```

#### `fromEffectFnAff`

``` purescript
fromEffectFnAff :: EffectFnAff ~> Aff
```

Lift a FFI definition into an `Aff`. `EffectFnAff` makes use of `EffectFn` so
`Effect` thunks are unnecessary. A definition might follow this example:

```javascript
exports._myAff = function (onError, onSuccess) {
  var cancel = doSomethingAsync(function (err, res) {
    if (err) {
      onError(err);
    } else {
      onSuccess(res);
    }
  });
  return function (cancelError, onCancelerError, onCancelerSuccess) {
    cancel();
    onCancelerSuccess();
  };
};
```

```purescript
foreign import _myAff :: EffectFnAff String

myAff :: Aff String
myAff = fromEffectFnAff _myAff
````


### Re-exported from Effect.Uncurried:

#### `EffectFn3`

``` purescript
data EffectFn3 t0 t1 t2 t3
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn3 a b c r)
(Monoid r) => Monoid (EffectFn3 a b c r)
```

#### `EffectFn2`

``` purescript
data EffectFn2 t0 t1 t2
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn2 a b r)
(Monoid r) => Monoid (EffectFn2 a b r)
```

#### `EffectFn1`

``` purescript
data EffectFn1 t0 t1
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn1 a r)
(Monoid r) => Monoid (EffectFn1 a r)
```

#### `runEffectFn3`

``` purescript
runEffectFn3 :: forall a b c r. EffectFn3 a b c r -> a -> b -> c -> Effect r
```

#### `runEffectFn2`

``` purescript
runEffectFn2 :: forall a b r. EffectFn2 a b r -> a -> b -> Effect r
```

#### `runEffectFn1`

``` purescript
runEffectFn1 :: forall a r. EffectFn1 a r -> a -> Effect r
```

#### `mkEffectFn3`

``` purescript
mkEffectFn3 :: forall a b c r. (a -> b -> c -> Effect r) -> EffectFn3 a b c r
```

#### `mkEffectFn2`

``` purescript
mkEffectFn2 :: forall a b r. (a -> b -> Effect r) -> EffectFn2 a b r
```

#### `mkEffectFn1`

``` purescript
mkEffectFn1 :: forall a r. (a -> Effect r) -> EffectFn1 a r
```

