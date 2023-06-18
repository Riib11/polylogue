module AI.Agent.Control.Main where

import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Control.Monad.Reader (runReaderT)
import Type.Proxy (Proxy(..))

_main = Proxy :: Proxy "main"

type States states = Agent.States states
type Errors errors = Agent.Errors errors
type Queries queries = Agent.Queries
  ( main :: Agent.Inquiry Unit Unit
  | queries )

extend main = Agent.defineInquiry _main main

main :: forall states errors queries m. Monad m => Agent.QueryF (States states) (Errors errors) (Queries queries) m Unit
main = Agent.inquire _main unit

runMain = runReaderT main
