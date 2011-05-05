{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Main ( main ) where

import B2

class FromNat a where
    fromNat :: Nat -> a

instance FromNat Nat where
    fromNat = id

class IsoNat a where
    convToNat :: a -> Nat

instance IsoNat Nat where
    convToNat = id

class IsoInt a where
    convFromInt :: Int -> a

instance IsoInt Int where
    convFromInt = id

newtype Down a = Down a deriving (Eq, Show, IsoNat, IsoInt, FromNat)

badDown :: Down Int
badDown = Down (-1)

okDown :: Down Nat
okDown = Down zero

getNat :: Int
getNat = fromNat zero

badNat = convToNat $ okDown

main = do
    print "Hello"
    

-- [0..10] :: [Int]
-- convToNat :: IsoNat a => a -> Nat
--    convToNat :: IsoNat Nat => Nat -> Nat
--    convToNat :: IsoNat (Down a) => (Down a) -> Nat

