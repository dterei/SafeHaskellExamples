module T where

import Data.Typeable
import M

g :: (Typeable a) => c a -> Maybe (c Int)
g = gcast
