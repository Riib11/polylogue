-- | A simple query type.
module AI.AgentInquiry where

import AI.Agent
import Prelude

import Data.Functor.Variant as FV
import Data.Symbol (class IsSymbol)
import Prim.Row (class Cons)
import Type.Proxy (Proxy)

-- | Inquiry

data Inquiry a b c = Inquiry a (b -> c)
derive instance Functor (Inquiry a b)

defineInquiry label f = defineQuery label (\(Inquiry a k) -> k <$> f a)

defineInquiry label f = defineQuery label (\(Inquiry a k) -> k <$> f a)

inquire :: forall label input output states errors queries_ queries m.
  IsSymbol label => Cons label (Inquiry input output) queries_ queries =>
  Proxy label -> input ->
  QueryF states errors queries m output
inquire label input = query label (Inquiry input identity)
