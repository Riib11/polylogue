module Record.Contract where

import Prim.Row (class Union)
import Unsafe.Coerce (unsafeCoerce)

contract :: forall row1 row2 row3. Union row1 row2 row3 => Record row3 -> Record row1
contract = unsafeCoerce
