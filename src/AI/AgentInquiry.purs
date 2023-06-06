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

addInquiry :: forall states errors queryLabel queries_ queries' m a b.
  Functor m => 
  IsSymbol queryLabel => Cons queryLabel (Inquiry a b) queries_ queries' =>
  Proxy queryLabel ->
  (a -> AgentM states errors m b) ->
  Class states errors queries_ m ->
  Class states errors queries' m
addInquiry label f = addQuery label (\(Inquiry a k) -> k <$> f a)

inquire :: forall label states errors queries m a b c. 
  Cons label (Inquiry a b) c queries => IsSymbol label =>
  Proxy label -> a -> Class states errors queries m ->
  AgentM states errors m b
inquire label input = query (FV.inj label (Inquiry input identity))
