-- | A simple query type.
module AI.AgentInquiry where

import Prelude

import AI.Agent
import Data.Functor.Variant as FV
import Data.Symbol (class IsSymbol)
import Prim.Row (class Cons)
import Type.Proxy (Proxy)

-- | Inquiry

data Inquiry a b c = Inquiry a (b -> c)
derive instance Functor (Inquiry a b)

inquire label input = query (FV.inj label (Inquiry input identity))
