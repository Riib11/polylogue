## Module Effect.Uncurried

This module defines types for effectful uncurried functions, as well as
functions for converting back and forth between them.

This makes it possible to give a PureScript type to JavaScript functions
such as this one:

```javascript
function logMessage(level, message) {
  console.log(level + ": " + message);
}
```

In particular, note that `logMessage` performs effects immediately after
receiving all of its parameters, so giving it the type `Data.Function.Fn2
String String Unit`, while convenient, would effectively be a lie.

One way to handle this would be to convert the function into the normal
PureScript form (namely, a curried function returning an Effect action),
and performing the marshalling in JavaScript, in the FFI module, like this:

```purescript
-- In the PureScript file:
foreign import logMessage :: String -> String -> Effect Unit
```

```javascript
// In the FFI file:
exports.logMessage = function(level) {
  return function(message) {
    return function() {
      logMessage(level, message);
    };
  };
};
```

This method, unfortunately, turns out to be both tiresome and error-prone.
This module offers an alternative solution. By providing you with:

 * the ability to give the real `logMessage` function a PureScript type,
   and
 * functions for converting between this form and the normal PureScript
   form,

the FFI boilerplate is no longer needed. The previous example becomes:

```purescript
-- In the PureScript file:
foreign import logMessageImpl :: EffectFn2 String String Unit
```

```javascript
// In the FFI file:
exports.logMessageImpl = logMessage
```

You can then use `runEffectFn2` to provide a nicer version:

```purescript
logMessage :: String -> String -> Effect Unit
logMessage = runEffectFn2 logMessageImpl
```

(note that this has the same type as the original `logMessage`).

Effectively, we have reduced the risk of errors by moving as much code into
PureScript as possible, so that we can leverage the type system. Hopefully,
this is a little less tiresome too.

Here's a slightly more advanced example. Here, because we are using
callbacks, we need to use `mkEffectFn{N}` as well.

Suppose our `logMessage` changes so that it sometimes sends details of the
message to some external server, and in those cases, we want the resulting
`HttpResponse` (for whatever reason).

```javascript
function logMessage(level, message, callback) {
  console.log(level + ": " + message);
  if (level > LogLevel.WARN) {
    LogAggregatorService.post("/logs", {
      level: level,
      message: message
    }, callback);
  } else {
    callback(null);
  }
}
```

The import then looks like this:
```purescript
foreign import logMessageImpl
 EffectFn3
   String
   String
   (EffectFn1 (Nullable HttpResponse) Unit)
   Unit
```

And, as before, the FFI file is extremely simple:

```javascript
exports.logMessageImpl = logMessage
```

Finally, we use `runEffectFn{N}` and `mkEffectFn{N}` for a more comfortable
PureScript version:

```purescript
logMessage ::
  String ->
  String ->
  (Nullable HttpResponse -> Effect Unit) ->
  Effect Unit
logMessage level message callback =
  runEffectFn3 logMessageImpl level message (mkEffectFn1 callback)
```

The general naming scheme for functions and types in this module is as
follows:

* `EffectFn{N}` means, an uncurried function which accepts N arguments and
  performs some effects. The first N arguments are the actual function's
  argument. The last type argument is the return type.
* `runEffectFn{N}` takes an `EffectFn` of N arguments, and converts it into
  the normal PureScript form: a curried function which returns an Effect
  action.
* `mkEffectFn{N}` is the inverse of `runEffectFn{N}`. It can be useful for
  callbacks.


#### `EffectFn1`

``` purescript
data EffectFn1 t0 t1
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn1 a r)
(Monoid r) => Monoid (EffectFn1 a r)
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

#### `EffectFn3`

``` purescript
data EffectFn3 t0 t1 t2 t3
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn3 a b c r)
(Monoid r) => Monoid (EffectFn3 a b c r)
```

#### `EffectFn4`

``` purescript
data EffectFn4 t0 t1 t2 t3 t4
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn4 a b c d r)
(Monoid r) => Monoid (EffectFn4 a b c d r)
```

#### `EffectFn5`

``` purescript
data EffectFn5 t0 t1 t2 t3 t4 t5
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn5 a b c d e r)
(Monoid r) => Monoid (EffectFn5 a b c d e r)
```

#### `EffectFn6`

``` purescript
data EffectFn6 t0 t1 t2 t3 t4 t5 t6
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn6 a b c d e f r)
(Monoid r) => Monoid (EffectFn6 a b c d e f r)
```

#### `EffectFn7`

``` purescript
data EffectFn7 t0 t1 t2 t3 t4 t5 t6 t7
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn7 a b c d e f g r)
(Monoid r) => Monoid (EffectFn7 a b c d e f g r)
```

#### `EffectFn8`

``` purescript
data EffectFn8 t0 t1 t2 t3 t4 t5 t6 t7 t8
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn8 a b c d e f g h r)
(Monoid r) => Monoid (EffectFn8 a b c d e f g h r)
```

#### `EffectFn9`

``` purescript
data EffectFn9 t0 t1 t2 t3 t4 t5 t6 t7 t8 t9
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn9 a b c d e f g h i r)
(Monoid r) => Monoid (EffectFn9 a b c d e f g h i r)
```

#### `EffectFn10`

``` purescript
data EffectFn10 t0 t1 t2 t3 t4 t5 t6 t7 t8 t9 t10
```

##### Instances
``` purescript
(Semigroup r) => Semigroup (EffectFn10 a b c d e f g h i j r)
(Monoid r) => Monoid (EffectFn10 a b c d e f g h i j r)
```

#### `mkEffectFn1`

``` purescript
mkEffectFn1 :: forall a r. (a -> Effect r) -> EffectFn1 a r
```

#### `mkEffectFn2`

``` purescript
mkEffectFn2 :: forall a b r. (a -> b -> Effect r) -> EffectFn2 a b r
```

#### `mkEffectFn3`

``` purescript
mkEffectFn3 :: forall a b c r. (a -> b -> c -> Effect r) -> EffectFn3 a b c r
```

#### `mkEffectFn4`

``` purescript
mkEffectFn4 :: forall a b c d r. (a -> b -> c -> d -> Effect r) -> EffectFn4 a b c d r
```

#### `mkEffectFn5`

``` purescript
mkEffectFn5 :: forall a b c d e r. (a -> b -> c -> d -> e -> Effect r) -> EffectFn5 a b c d e r
```

#### `mkEffectFn6`

``` purescript
mkEffectFn6 :: forall a b c d e f r. (a -> b -> c -> d -> e -> f -> Effect r) -> EffectFn6 a b c d e f r
```

#### `mkEffectFn7`

``` purescript
mkEffectFn7 :: forall a b c d e f g r. (a -> b -> c -> d -> e -> f -> g -> Effect r) -> EffectFn7 a b c d e f g r
```

#### `mkEffectFn8`

``` purescript
mkEffectFn8 :: forall a b c d e f g h r. (a -> b -> c -> d -> e -> f -> g -> h -> Effect r) -> EffectFn8 a b c d e f g h r
```

#### `mkEffectFn9`

``` purescript
mkEffectFn9 :: forall a b c d e f g h i r. (a -> b -> c -> d -> e -> f -> g -> h -> i -> Effect r) -> EffectFn9 a b c d e f g h i r
```

#### `mkEffectFn10`

``` purescript
mkEffectFn10 :: forall a b c d e f g h i j r. (a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> Effect r) -> EffectFn10 a b c d e f g h i j r
```

#### `runEffectFn1`

``` purescript
runEffectFn1 :: forall a r. EffectFn1 a r -> a -> Effect r
```

#### `runEffectFn2`

``` purescript
runEffectFn2 :: forall a b r. EffectFn2 a b r -> a -> b -> Effect r
```

#### `runEffectFn3`

``` purescript
runEffectFn3 :: forall a b c r. EffectFn3 a b c r -> a -> b -> c -> Effect r
```

#### `runEffectFn4`

``` purescript
runEffectFn4 :: forall a b c d r. EffectFn4 a b c d r -> a -> b -> c -> d -> Effect r
```

#### `runEffectFn5`

``` purescript
runEffectFn5 :: forall a b c d e r. EffectFn5 a b c d e r -> a -> b -> c -> d -> e -> Effect r
```

#### `runEffectFn6`

``` purescript
runEffectFn6 :: forall a b c d e f r. EffectFn6 a b c d e f r -> a -> b -> c -> d -> e -> f -> Effect r
```

#### `runEffectFn7`

``` purescript
runEffectFn7 :: forall a b c d e f g r. EffectFn7 a b c d e f g r -> a -> b -> c -> d -> e -> f -> g -> Effect r
```

#### `runEffectFn8`

``` purescript
runEffectFn8 :: forall a b c d e f g h r. EffectFn8 a b c d e f g h r -> a -> b -> c -> d -> e -> f -> g -> h -> Effect r
```

#### `runEffectFn9`

``` purescript
runEffectFn9 :: forall a b c d e f g h i r. EffectFn9 a b c d e f g h i r -> a -> b -> c -> d -> e -> f -> g -> h -> i -> Effect r
```

#### `runEffectFn10`

``` purescript
runEffectFn10 :: forall a b c d e f g h i j r. EffectFn10 a b c d e f g h i j r -> a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> Effect r
```


