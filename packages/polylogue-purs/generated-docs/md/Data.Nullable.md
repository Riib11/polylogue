## Module Data.Nullable

This module defines types and functions for working with nullable types
using the FFI.

#### `Nullable`

``` purescript
data Nullable t0
```

A nullable type. This type constructor is intended to be used for
interoperating with JavaScript functions which accept or return null
values.

The runtime representation of `Nullable T` is the same as that of `T`,
except that it may also be `null`. For example, the JavaScript values
`null`, `[]`, and `[1,2,3]` may all be given the type
`Nullable (Array Int)`. Similarly, the JavaScript values `[]`, `[null]`,
and `[1,2,null,3]` may all be given the type `Array (Nullable Int)`.

There is one pitfall with `Nullable`, which is that values of the type
`Nullable T` will not function as you might expect if the type `T` happens
to itself permit `null` as a valid runtime representation.

In particular, values of the type `Nullable (Nullable T)` will ‘collapse’,
in the sense that the PureScript expressions `notNull null` and `null`
will both leave you with a value whose runtime representation is just
`null`. Therefore it is important to avoid using `Nullable T` in
situations where `T` itself can take `null` as a runtime representation.
If in doubt, use `Maybe` instead.

`Nullable` does not permit lawful `Functor`, `Applicative`, or `Monad`
instances as a result of this pitfall, which is why these instances are
not provided.

##### Instances
``` purescript
(Show a) => Show (Nullable a)
(Eq a) => Eq (Nullable a)
Eq1 Nullable
(Ord a) => Ord (Nullable a)
Ord1 Nullable
```

#### `null`

``` purescript
null :: forall a. Nullable a
```

The null value.

#### `notNull`

``` purescript
notNull :: forall a. a -> Nullable a
```

Wrap a non-null value.

#### `toMaybe`

``` purescript
toMaybe :: forall a. Nullable a -> Maybe a
```

Represent `null` using `Maybe a` as `Nothing`. Note that this function
can violate parametricity, as it inspects the runtime representation of
its argument (see the warning about the pitfall of `Nullable` above).

#### `toNullable`

``` purescript
toNullable :: forall a. Maybe a -> Nullable a
```

Takes `Nothing` to `null`, and `Just a` to `a`.


