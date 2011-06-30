module GHCIOArray where

import GHC.IOArray

bad1 = unsafeReadIOArray

bad2 = unsafeWriteIOArray

