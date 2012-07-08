module M (Jail(), lockAway) where

data Jail a = Jail a deriving Show

lockAway :: Int -> Jail Int
lockAway x | x < 0     = Jail 0
           | otherwise = Jail x

