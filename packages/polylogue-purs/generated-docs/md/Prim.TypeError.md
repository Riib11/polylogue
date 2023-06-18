## Module Prim.TypeError

The Prim.TypeError module is embedded in the PureScript compiler. Unlike `Prim`, it is not imported implicitly. It contains type classes that provide custom type error and warning functionality.
#### `Warn`

``` purescript
class Warn (message :: Doc) 
```

The Warn type class allows a custom compiler warning to be displayed.

For more information, see
[the Custom Type Errors guide](https://github.com/purescript/documentation/blob/master/guides/Custom-Type-Errors.md).

#### `Fail`

``` purescript
class Fail (message :: Doc) 
```

The Fail type class is part of the custom type errors feature. To provide
a custom type error when someone tries to use a particular instance,
write that instance out with a Fail constraint.

For more information, see
[the Custom Type Errors guide](https://github.com/purescript/documentation/blob/master/guides/Custom-Type-Errors.md).

#### `Doc`

``` purescript
data Doc :: Type
```

`Doc` is the kind of type-level documents.

This kind is used with the `Fail` and `Warn` type classes.
Build up a `Doc` with `Text`, `Quote`, `QuoteLabel`, `Beside`, and `Above`.

#### `Text`

``` purescript
data Text :: Symbol -> Doc
```

The Text type constructor makes a Doc from a Symbol
to be used in a custom type error.

For more information, see
[the Custom Type Errors guide](https://github.com/purescript/documentation/blob/master/guides/Custom-Type-Errors.md).

#### `Quote`

``` purescript
data Quote :: forall (k :: Type). k -> Doc
```

The Quote type constructor renders any concrete type as a Doc
to be used in a custom type error.

For more information, see
[the Custom Type Errors guide](https://github.com/purescript/documentation/blob/master/guides/Custom-Type-Errors.md).

#### `QuoteLabel`

``` purescript
data QuoteLabel :: Symbol -> Doc
```

The `QuoteLabel` type constructor will produce a `Doc` when given a `Symbol`. When the resulting `Doc` is rendered
for a `Warn` or `Fail` constraint, a syntactically valid label will be produced, escaping with quotes as needed.

For more information, see
[the Custom Type Errors guide](https://github.com/purescript/documentation/blob/master/guides/Custom-Type-Errors.md).

#### `Beside`

``` purescript
data Beside :: Doc -> Doc -> Doc
```

The Beside type constructor combines two Docs horizontally
to be used in a custom type error.

For more information, see
[the Custom Type Errors guide](https://github.com/purescript/documentation/blob/master/guides/Custom-Type-Errors.md).

#### `Above`

``` purescript
data Above :: Doc -> Doc -> Doc
```

The Above type constructor combines two Docs vertically
in a custom type error.

For more information, see
[the Custom Type Errors guide](https://github.com/purescript/documentation/blob/master/guides/Custom-Type-Errors.md).


