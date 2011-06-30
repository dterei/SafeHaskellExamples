module Foreign2 where

import Foreign

bad :: IO a -> a
bad = unsafePerformIO

