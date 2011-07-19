{-# LANGUAGE DeriveDataTypeable, StandaloneDeriving #-}
module Main where

import G
import Data.Typeable

data H = H String deriving (Typeable, Show)

data G = G Int deriving (Show)

instance Typeable G where
    typeOf _ = typeOf (undefined :: H)

instance Typeable P where
    typeOf _ = typeOf (undefined :: G)

main = do
    let h = H "Hello World"
        g = G 1
        Just h' = (cast h) :: Maybe G
        Just p' = (cast p) :: Maybe G
        Just px = (cast $ incrG p') :: Maybe P
    putStrLn $ show h
    putStrLn $ show g
    putStrLn $ show h'
    putStrLn $ showP p
    putStrLn $ show p'
    putStrLn $ showP px

incrG :: G -> G
incrG (G n) = G $ n + 1

