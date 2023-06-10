module AI.Prompt where

import Prelude

import Data.List (List)
import Data.List as List
import Data.Symbol (class IsSymbol, reflectSymbol)
import Data.Template (Template)
import Data.Template as Template
import Prim.Row (class Cons, class Lacks, class Union)
import Prim.RowList (class RowToList, RowList)
import Prim.RowList as RowList
import Record as R
import Type.Proxy (Proxy(..))
import Type.RowList (class ListToRow)
import Unsafe.Coerce (unsafeCoerce)

type Prompt prms args m = Template prms args m String

preview :: forall prms prmList prmRec args m. 
  RowToList prms prmList =>
  ReflectLabels prmList prmRec =>
  Monad m =>
  Prompt prms args m ->
  m String
preview prompt@(Template.Template temp) = do
  let placeholderArgs = reflectLabels (RowListProxy :: RowListProxy prmList)
  Template.evaluate
    (Template.union
      -- I did my best to get this to work, but had to resort to some coercions
      (R.union
        -- any instantiated args override placeholder args
        (unsafeCoerce temp.args :: {})
        (unsafeCoerce placeholderArgs :: {}))
      (unsafeCoerce prompt :: Prompt () () m))

data RowListProxy (xs :: RowList Type) = RowListProxy

class ShowLabels (xs :: RowList Type) where
  collectLabels :: RowListProxy xs -> List String

instance ShowLabels RowList.Nil where
  collectLabels _ = mempty

instance (IsSymbol x, ShowLabels xs) => ShowLabels (RowList.Cons x a xs) where
  collectLabels _ = reflectSymbol (Proxy :: Proxy x) List.: collectLabels (RowListProxy :: RowListProxy xs)

class ReflectLabels (xs :: RowList Type) r | xs -> r where
  reflectLabels :: RowListProxy xs -> Record r

instance ReflectLabels RowList.Nil () where
  reflectLabels _ = {}

instance 
  ( IsSymbol x
  , Lacks x r
  , ReflectLabels xs r
  , Cons x String r r'
  ) =>
  ReflectLabels (RowList.Cons x a xs) r' where
  reflectLabels _ = 
    R.insert
      (Proxy :: Proxy x)
      ("⸨" <> reflectSymbol (Proxy :: Proxy x) <> "⸩") 
      (reflectLabels (RowListProxy :: RowListProxy xs))
