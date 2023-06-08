-- | A simple query type.
module AI.AgentInquiry where

import AI.Agent
import Prelude

import Data.Functor.Variant as FV
import Data.Symbol (class IsSymbol)
import Prim.Row (class Cons)
import Type.Proxy (Proxy)

-- | Inquiry

data Inquiry input output output' = Inquiry input (output -> output')
derive instance Functor (Inquiry input output)

defineInquiry :: forall queries_ queries input states errors queryLabel m output. IsSymbol queryLabel => Cons queryLabel (Inquiry input output) queries_ queries => Functor m => Proxy queryLabel -> (input -> AgentM states errors m output) -> Agent states errors queries_ m -> Agent states errors queries m
defineInquiry label f = defineQuery label (\(Inquiry a k) -> k <$> f a)

inquire :: forall label input output states errors queries_ queries m. IsSymbol label => Cons label (Inquiry input output) queries_ queries => Monad m => Proxy label -> input -> QueryF states errors queries m output
inquire label input = query label (Inquiry input identity)
