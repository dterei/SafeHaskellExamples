{-# LANGUAGE FlexibleInstances #-}
module UntrustedPlug where

import TrustedLib

instance
  Pos a where
    res _ = False

instance
  Pos [Int] where
    res _ = error "This curry is poisoned!"

function :: Int
function = 3

