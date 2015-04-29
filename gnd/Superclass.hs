{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Main where

data T = MkT { unpackT :: Int } deriving (Show)

class C a where
  op :: (Show a) => a -> String

instance C T where
  op x = show x

-- derived C uses `Show T` instance, not derived `Show TT` instance...
newtype TT = MkTT T deriving (Show, C)

main :: IO ()
main = do
  print $ MkT 1
  putStrLn $ op $ MkT 2
  print $ MkTT $ MkT 1
  putStrLn $ op $ MkTT $ MkT 2

