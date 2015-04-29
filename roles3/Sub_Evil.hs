{-# LANGUAGE ScopedTypeVariables #-}
module Sub_Evil (
    plugin
  ) where

import Data.Coerce

import Types ( T() )

-- Can gain access to dictionary without constructor if passed in at location
-- that can access constructor.
plugin :: forall a b. (Show a, Show b, Coercible a b) => a -> b -> IO ()
plugin x y = do
  putStrLn $ "A : " ++ show x
  putStrLn $ "B : " ++ show y
  putStrLn $ "A': " ++ show (coerce x :: b)

