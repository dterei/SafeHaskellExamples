{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Main where

data T = MkT Int deriving (Show)

class C a where
  op :: (Show a) => a -> String

instance C T where
  op x = "T: " ++ show x

-- derived C uses `Show T` instance, not derived `Show TT` instance...
newtype TT = MkTT T deriving (Show, C)

main :: IO ()
main = do
  putStrLn $ op $ MkT 2
  putStrLn $ op $ MkTT $ MkT 2

