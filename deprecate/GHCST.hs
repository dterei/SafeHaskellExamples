module GHCST where

import GHC.ST

bad1 = liftST 

bad2 = unsafeInterleaveST

