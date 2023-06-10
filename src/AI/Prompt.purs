module AI.Prompt where

import Prelude

import Data.Template (Template)

type PromptTemplate prms args m = 
  Template prms args m String

type SystemAndPromptTemplate prms args m = 
  Template prms args m {system :: String, user :: String}