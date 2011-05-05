{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Main ( main ) where

import Data.Set

class IsoInt a where
    convFromInt :: item Int -> item a

instance IsoInt Int where
    convFromInt = id

newtype Down a = Down a deriving (Eq, Show, IsoInt)

instance Ord a => Ord (Down a) where
    compare (Down a) (Down b) = compare b a

asSetDown :: Set (Down Int) -> Set (Down Int)
asSetDown = id

a1 = toAscList . asSetDown . convFromInt . fromAscList $  [0..10]
a2 = toAscList . asSetDown . fromAscList . convFromInt $ [0..10]

main = do
    print a1
    print a2

-- [0..10] :: [Int]
-- fromAscList :: Eq a => [a] -> Set a
-- convFromInt :: IsoInt a => item Int -> item a
--    convFromInt :: IsoInt Int => item Int -> item Int
--    convFromInt :: IsoInt (Down a) => item Int -> item (Down a)
-- asSetDown :: Set (Down Int) -> Set (Down Int)
--
-- fromAscList [0..10] :: Set Int
-- (asSetDown . convFromInt) :: Set Int -> Set (Down Int)

