module AI.Prompt.Summarize where

import Prelude

import AI.Prompt as Prompt
import Data.Template as Template

template :: forall m prms. Applicative m => 
  Prompt.SystemAndPromptTemplate (document :: String | prms) () m
template = Template.fromFunction \{document} ->
  pure
    { system: "You are a writing assistant that concisely and accurately summarizes documents. You summarize at a high-level and make sure to cover every section of the document. You summarize each important detail from the document."
    , user: "Summarize the following document:\n\n" <> document
    }
