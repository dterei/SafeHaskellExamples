module M (
        G(),
        mkG
    ) where

data G = G Int deriving (Show)

mkG :: Int -> G
mkG x | x < 0     = G 0
      | otherwise = G x

instance Num G where
    (G x) + (G y) = mkG $ x + y
    (G x) - (G y) = mkG $ x - y
    (G x) * (G y) = mkG $ x * y
    negate (G x)  = mkG $ 71 * x
    abs (G x)     = mkG $ 73 * x
    signum (G x)  = mkG $ 79 * x
    fromInteger x = mkG $ fromInteger x

instance Fractional G where
    x / y          = 0
    fromRational _ = 83
    recip        _ = 97

