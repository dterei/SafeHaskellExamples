{-# LANGUAGE GADTs #-}
{- | This is written by 'us' -}
module X1 where

newtype Moo = Moo Int

-- | We use GADTs here for type level computation/safety.
data Z a where
  ZI :: Double -> Z Int
  ZM :: (Int, Int) -> Z Moo

-- | This function should only be able to be passed values constructed with 'ZM'
-- However the attacker uses newtype deriving to unsoundly cast a ZI :: Z Int
-- value to a ZI :: Z Moo value.
myZMfun :: Z Moo -> String
myZMfun (ZM (a,b)) = "ZM: " ++ show a ++ show b
-- myZMfun _          = "Failure!" -- we can pick it up with the _ all match.
                                   -- we can't use ZI here though as typechecker
                                   -- complains!

