## Module Prim

The `Prim` module is embedded in the PureScript compiler in order to provide compiler support for certain types &mdash; for example, value literals, or syntax sugar. It is implicitly imported unqualified in every module except those that list it as a qualified import.

`Prim` does not include additional built-in types and kinds that are defined deeper in the compiler such as Type wildcards (e.g. `f :: _ -> Int`) and Quantified Types. Rather, these are documented in [the PureScript language reference](https://github.com/purescript/documentation/blob/master/language/Types.md).

#### `Function`

``` purescript
data Function :: Type -> Type -> Type
```

A function, which takes values of the type specified by the first type
parameter, and returns values of the type specified by the second.
In the JavaScript backend, this is a standard JavaScript Function.

The type constructor `(->)` is syntactic sugar for this type constructor.
It is recommended to use `(->)` rather than `Function`, where possible.

That is, prefer this:

    f :: Number -> Number

to either of these:

    f :: Function Number Number
    f :: (->) Number Number

#### `Array`

``` purescript
data Array :: Type -> Type
```

An Array: a data structure supporting efficient random access. In
the JavaScript backend, values of this type are represented as JavaScript
Arrays at runtime.

Construct values using literals:

    x = [1,2,3,4,5] :: Array Int

#### `Record`

``` purescript
data Record :: Row Type -> Type
```

The type of records whose fields are known at compile time. In the
JavaScript backend, values of this type are represented as JavaScript
Objects at runtime.

The type signature here means that the `Record` type constructor takes
a row of concrete types. For example:

    type Person = Record (name :: String, age :: Number)

The syntactic sugar with curly braces `{ }` is generally preferred, though:

    type Person = { name :: String, age :: Number }

The row associates a type to each label which appears in the record.

_Technical note_: PureScript allows duplicate labels in rows, and the
meaning of `Record r` is based on the _first_ occurrence of each label in
the row `r`.

#### `Number`

``` purescript
data Number :: Type
```

A double precision floating point number (IEEE 754).

Construct values of this type with literals.
Negative literals must be wrapped in parentheses if the negation sign could be mistaken
for an infix operator:

    x = 35.23 :: Number
    y = -1.224e6 :: Number
    z = exp (-1.0) :: Number

#### `Int`

``` purescript
data Int :: Type
```

A 32-bit signed integer. See the `purescript-integers` package for details
of how this is accomplished when compiling to JavaScript.

Construct values of this type with literals. Hexadecimal syntax is supported.
Negative literals must be wrapped in parentheses if the negation sign could be mistaken
for an infix operator:

    x = -23 :: Int
    y = 0x17 :: Int
    z = complement (-24) :: Int

Integers used as types are considered to have kind `Int`.
Unlike value-level `Int`s, which must be representable as a 32-bit signed integer,
type-level `Int`s are unbounded. Hexadecimal support is also supported at the type level.

    type One :: Int
    type One = 1
    
    type Beyond32BitSignedInt :: Int
    type Beyond32BitSignedInt = 2147483648
    
    type HexInt :: Int
    type HexInt = 0x17

Negative integer literals at the type level must be
wrapped in parentheses if the negation sign could be mistaken for an infix operator.

    type NegativeOne = -1
    foo :: Proxy (-1) -> ...

#### `String`

``` purescript
data String :: Type
```

A String. As in JavaScript, String values represent sequences of UTF-16
code units, which are not required to form a valid encoding of Unicode
text (for example, lone surrogates are permitted).

Construct values of this type with literals, using double quotes `"`:

    x = "hello, world" :: String

Multi-line string literals are also supported with triple quotes (`"""`):

    x = """multi
       line"""

At the type level, string literals represent types with kind `Symbol`.
These types will have kind `String` in a future release:

    type Hello :: Symbol
    type Hello = "Hello, world"

#### `Char`

``` purescript
data Char :: Type
```

A single character (UTF-16 code unit). The JavaScript representation is a
normal `String`, which is guaranteed to contain one code unit. This means
that astral plane characters (i.e. those with code point values greater
than `0xFFFF`) cannot be represented as `Char` values.

Construct values of this type with literals, using single quotes `'`:

    x = 'a' :: Char

#### `Boolean`

``` purescript
data Boolean :: Type
```

A JavaScript Boolean value.

Construct values of this type with the literals `true` and `false`.

The `True` and `False` types defined in `Prim.Boolean` have this type as their kind.

#### `Partial`

``` purescript
class Partial 
```

The Partial type class is used to indicate that a function is *partial,*
that is, it is not defined for all inputs. In practice, attempting to use
a partial function with a bad input will usually cause an error to be
thrown, although it is not safe to assume that this will happen in all
cases. For more information, see
[purescript-partial](https://pursuit.purescript.org/packages/purescript-partial/).

#### `Type`

``` purescript
data Type :: Type
```

`Type` is the kind of all proper types: those that classify value-level terms.
For example the type `Boolean` has kind `Type`; denoted by `Boolean :: Type`.

#### `Constraint`

``` purescript
data Constraint :: Type
```

`Constraint` is the kind of type class constraints.
For example, a type class declaration like this:

    class Semigroup a where
      append :: a -> a -> a

has the kind signature:

    class Semigroup :: Type -> Constraint

#### `Symbol`

``` purescript
data Symbol :: Type
```

`Symbol` is the kind of type-level strings.

Construct types of this kind using the same literal syntax as documented
for strings.

    type Hello :: Symbol
    type Hello = "Hello, world"


#### `Row`

``` purescript
data Row :: Type -> Type
```

`Row` is the kind constructor of label-indexed types which map type-level strings to other types.
The most common use of `Row` is `Row Type`, a row mapping labels to basic (of kind `Type`) types:

    type ExampleRow :: Row Type
    type ExampleRow = ( name :: String, values :: Array Int )

This is the kind of `Row` expected by the `Record` type constructor.
More advanced row kinds like `Row (Type -> Type)` are used much less frequently.


