-- {-# LANGUAGE FlexibleInstances, OverlappingInstances, IncoherentInstances #-}
{-# LANGUAGE FlexibleInstances, OverlappingInstances #-}
module T where

class C a where
  f :: a -> String

instance C a where
  f _ = "a"

instance C Int where
  f _ = "Int"

instance C Double where
  f _ = "Double"

testI :: String
testI = f (7 :: Int)

testD :: String
testD = f (7 :: Double)

-- It is either an ambiguous error, or defaults to C a instance when
-- IncoherentInstances is used
-- testA :: String
-- testA = f 7

