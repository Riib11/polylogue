module AI.Prompt.Summarize where

import Prelude

import AI.Prompt as Prompt
import Data.Identity (Identity(..))
import Data.Template as Template
import Effect (Effect)
import Effect.Class.Console (log)
import Prim.Row (class Lacks, class Nub, class Union)
import Text.Pretty (bullets)
import Type.Proxy (Proxy(..))

system :: forall prms m. Monad m => Prompt.Prompt prms () m
system = Template.fromFunction \{} -> pure $
  "You are a writing assistant that concisely and accurately summarizes documents. You should:" <> 
  bullets
    [ "cover every section, in order"
    , "include every important detail"
    , "summarizeaat mostly at a conceptual level"
    , "include some specific details" ]

prompt :: forall prms m. Monad m => Prompt.Prompt (document :: String | prms) () m
prompt = Template.fromFunction \{document} -> pure 
  $ "Summarize the following document:" <> "\n\n"
  <> document

maxLength
  = Template.inject (Proxy :: Proxy "summarize")
  $ Template.fromFunction \{summarize, maxLength} -> pure
    $ summarize <> "\n\n"
    <> "Your summaries can be up to " <> maxLength <> " long."

example ∷ Prompt.Prompt ( document ∷ String , maxLength ∷ String ) () Identity
example
  = prompt
  # maxLength

evaluatedExample ∷ String
evaluatedExample 
  = Template.evaluateWith example
      { document: "This is my document"
      , maxLength: "three sentences"
      }
  # \(Identity x) -> x

previewedExampled ∷ String
previewedExampled 
  = Prompt.preview 
      ( example 
        # Template.substitute (Proxy :: Proxy "document") "This is my document" )
  # \(Identity x) -> x

main :: Effect Unit
main = do
  log evaluatedExample
  log "===================="
  log previewedExampled