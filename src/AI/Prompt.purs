module AI.Prompt where

import Prelude

import Control.Monad.Reader (ReaderT)

newtype Prompt metas vars m = 
  Prompt (ReaderT {metas :: Record metas, args :: Record vars} m String)

