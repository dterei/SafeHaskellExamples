{-# LANGUAGE DeriveGeneric #-}
module GenUse (Cerial(..), Bin(..), Tree(..)) where

import GenBin (Cerial(..), Bin(..))
import GHC.Generics

data Tree a = Leaf a | Node (Tree a) (Tree a) deriving (Show, Eq, Generic)

instance (Cerial a) => Cerial (Tree a)

