{-# LANGUAGE Trustworthy #-}
{-# LANGUAGE FlexibleInstances #-}
module TrustedLib where

class Pos a where
    res :: a -> Bool

instance Pos [a] where
    res _ = True

