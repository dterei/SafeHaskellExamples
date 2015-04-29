{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
module Main where

-- import Sub ( T() )
import Sub ( T(..) )
import Data.Coerce

class Default a where
  def :: a

instance Default Int where
  def = 0

-- > Can only derive (i.e., coerce :: Int -> T) when `MkT` constructor is in
-- > scope.
deriving instance Default T
-- instance Default T where
--   def = coerce (def :: Int)
--   -- coerce :: Int -> T

main :: IO ()
main = do
  print (def :: Int)
  print (def :: T)

