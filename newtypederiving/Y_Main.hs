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


-- ## our coercion function
-- By deriving IntIso, we can get `intIso :: c I -> c Int`
--
-- Pre 7.10 we didn't need to declare the outertype, but 7.10 fixed that as it
-- could break type-safety.
-- class IntIso t where
--     intIso :: c t -> c Int

-- 7.10+ we need to declare the outer type. But through this we can create our
-- `coerce` function without importing `Data.Coerce`.
class IntIso t where
    intIso :: MinList t -> MinList Int

-- This approach doesn't change anything
-- type role IntIso representational _
-- class IntIso c t where
--     intIso :: c t -> c Int

instance IntIso Int where
    intIso = id
--


-- ## our corrupt Int type
newtype I = I Int deriving (Eq, Show, IntIso)
instance Ord I where
    compare (I a) (I b) = compare b a
--


-- ## Our Lists
-- A good list
a1 :: MinList Int
a1 = foldl insertMinList (newMinList $ head nums) (tail nums)

-- A good list using own Ord instance
a2 :: MinList I
a2 = foldl (\x y -> insertMinList x $ I y) (newMinList $ I $ head nums) (tail nums)

-- Our evil list
a2' :: MinList Int
a2' = intIso a2
--


-- ## Run
nums :: [Int]
nums = [1,4,0,1,-5,2,3]

main = do
    print a1
    print a2
    print a2'
--

