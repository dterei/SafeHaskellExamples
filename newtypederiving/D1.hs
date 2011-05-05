{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

data family Z :: * -> *

class IsInt t where
    isInt :: c Int -> c t

instance IsInt Int where isInt = id

newtype Moo = Moo Int deriving(IsInt)

newtype instance Z Int = ZI Double
newtype instance Z Moo = ZM (Int,Int)

main = case isInt (ZI 4.0) of ZM tu -> print tu

