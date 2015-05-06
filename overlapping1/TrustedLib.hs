{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fwarn-unsafe #-}
module TrustedLib where

-- we want to allow untrusted code to override this instance!

class Pos a where
  res :: a -> Int

instance
  Pos a where { res _ = 0 }

instance
  Pos [a] where { res _ = 1 }

-- OVERLAPPABLE : Can be overlapped by other instances
-- OVERLAPPING  : This instance overlaps another instance
-- OVERLAPS     : => overlappable, overlapping
-- INCOHERENT   : Instance can be incoherent, => OVERLAPS

