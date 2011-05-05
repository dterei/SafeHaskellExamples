{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Main where

data II a where
    II :: II Int

instance Show (II a) where
    show II = "II"

class IC a where
    ic :: II a

instance IC Int where
    ic = II

newtype A = A Int deriving ( IC )

icA :: II A
icA = ic

icB :: II Int
icB = II

main = do
    putStrLn "Hello"
    putStrLn $ show icA
    putStrLn $ show icB

