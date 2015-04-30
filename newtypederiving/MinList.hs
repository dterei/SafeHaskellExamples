-- | Here we expose a MinList API that only allows elements
-- to be inserted into a list if they are at least greater
-- than an initial element the list is created with.
module MinList (
        MinList, newMinList, insertMinList
    ) where

data MinList a = MinList a [a] deriving (Show)

newMinList :: Ord a => a -> MinList a
newMinList n = MinList n []

insertMinList :: Ord a => MinList a -> a -> MinList a
insertMinList s@(MinList m xs) n | n > m     = MinList m (n:xs)
                                 | otherwise = s

