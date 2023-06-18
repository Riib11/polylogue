## Module Prim.Coerce

The Prim.Coerce module is embedded in the PureScript compiler. Unlike `Prim`, it is not imported implicitly. It contains an automatically solved type class for coercing types that have provably-identical runtime representations with [purescript-safe-coerce](https://pursuit.purescript.org/packages/purescript-safe-coerce).
#### `Coercible`

``` purescript
class Coercible (a :: k) (b :: k) 
```

Coercible is a two-parameter type class that has instances for types `a`
and `b` if the compiler can infer that they have the same representation.
Coercible constraints are solved according to the following rules:

* _reflexivity_, any type has the same representation as itself:
`Coercible a a` holds.

* _symmetry_, if a type `a` can be coerced to some other type `b`, then `b`
can also be coerced back to `a`: `Coercible a b` implies `Coercible b a`.

* _transitivity_, if a type `a` can be coerced to some other type `b` which
can be coerced to some other type `c`, then `a` can also be coerced to `c`:
`Coercible a b` and `Coercible b c` imply `Coercible a c`.

* Newtypes can be freely wrapped and unwrapped when their constructor is
in scope:

      newtype Age = Age Int

`Coercible Int Age` and `Coercible Age Int` hold since `Age` has the same
runtime representation than `Int`.

Newtype constructors have to be in scope to preserve abstraction. It's
common to declare a newtype to encode some invariants (non emptiness of
arrays with `Data.Array.NonEmpty.NonEmptyArray` for example), hide its
constructor and export smart constructors instead. Without this restriction,
the guarantees provided by such newtypes would be void.

* If none of the above are applicable, two types of kind `Type` may be
coercible, but only if their heads are the same. For example,
`Coercible (Maybe a) (Either a b)` does not hold because `Maybe` and
`Either` are different. Those types don't share a common runtime
representation so coercing between them would be unsafe. In addition their
arguments may need to be identical or coercible, depending on the _roles_
of the head's type parameters. Roles are documented in [the PureScript
language reference](https://github.com/purescript/documentation/blob/master/language/Roles.md).

Coercible being polykinded, we can also coerce more than types of kind `Type`:

* Rows are coercible when they have the same labels, when the corresponding
pairs of types are coercible and when their tails are coercible:
`Coercible ( label :: a | r ) ( label :: b | s )` holds when
`Coercible a b` and `Coercible r s` do. Closed rows cannot be coerced to
open rows.

* Higher kinded types are coercible if they are coercible when fully
saturated: `Coercible (f :: _ -> Type) (g :: _ -> Type)` holds when
`Coercible (f a) (g a)` does.

This rule may seem puzzling since there is no term of type `_ -> Type` to
apply `coerce` to, but it is necessary when coercing types with higher
kinded parameters.


