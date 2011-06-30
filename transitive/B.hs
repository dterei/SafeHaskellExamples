{-# LANGUAGE Safe #-}
module B where

import A

mainM :: Int -> Int
mainM n = trace "Allowed Leak" $ n * 2

