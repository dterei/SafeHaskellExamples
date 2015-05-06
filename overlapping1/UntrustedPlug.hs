{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fwarn-unsafe #-}
module UntrustedPlug where

import TrustedLib

instance
  {-# OVERLAPS #-}
  Pos [Int] where { res _ = 2 }

