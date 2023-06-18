{-
Welcome to a Spago project!
You can edit this file as you like.

Need help? See the following resources:
- Spago documentation: https://github.com/purescript/spago
- Dhall language tour: https://docs.dhall-lang.org/tutorials/Language-Tour.html

When creating a new Spago project, you can use
`spago init --no-comments` or `spago init -C`
to generate this file without the comments in this block.
-}
{ name = "my-project"
, dependencies =
  [ "aff"
  , "arrays"
  , "console"
  , "control"
  , "debug"
  , "dotenv"
  , "effect"
  , "either"
  , "enums"
  , "foldable-traversable"
  , "functors"
  , "homogeneous"
  , "lists"
  , "maybe"
  , "node-process"
  , "node-readline"
  , "options"
  , "ordered-collections"
  , "partial"
  , "prelude"
  , "record"
  , "refs"
  , "strings"
  , "transformers"
  , "tuples"
  , "unordered-collections"
  , "unsafe-coerce"
  , "uuid"
  , "variant"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
