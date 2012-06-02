{-# LANGUAGE GeneralizedNewtypeDeriving #-}
-- | We use newtype to create an isomorphic type to Int
-- with a reversed Ord dictionary. We now use the MinList
-- API of Y1 to create a new MinList. Then we use newtype
-- deriving to convert the newtype MinList to an Int
-- MinList. This final result breaks the invariants of
-- MinList which shouldn't be possible with the exposed
-- API of Y1.
module Main where

import Y1

class IntIso t where
    intIso :: c t -> c Int

instance IntIso Int where
    intIso = id

newtype I = I Int deriving (Eq, IntIso)

instance Ord I where
    compare (I a) (I b) = compare b a

a1, a2 :: MinList Int
a1 = foldl insertMinList (newMinList $ head nums) (tail nums)
a2 = intIso $ foldl (\x y -> insertMinList x $ I y) (newMinList $ I $ head nums) (tail nums)

nums :: [Int]
nums = [1,4,0,1,-5,2,3]

main = do
    print a1
    print a2

