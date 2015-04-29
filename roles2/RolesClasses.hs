{-# LANGUAGE GADTs #-}
{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE IncoherentInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
module RolesClasses where

import Data.Coerce

-- ===============================================
-- Can I Coerce dictionaries?
--

-- Can't do! Can't lower from nominal which comes about as `Eq a` is nominal.
-- type role Foo representational
data Foo a where
  Foo :: Eq a => Foo a

newtype Bar = Bar Int
instance Eq Bar where
  _ == _ = False


-- ===============================================
-- Coerce a newtype

newtype Car a = Car a
type Car' = Car Int

-- Can coerce newtype since constructor in scope and default is
-- representational
cast1 = coerce (1 :: Int) :: Car'


-- Can coerce since `B a` is representational by default
data B a where { B :: B a }
cast2 = coerce (B :: B Int) :: B Car'

-- Can't do since Foo a is nominal
-- cast = coerce (Foo :: Foo Int) :: Foo Bar


-- Can derive MEQ a (so a is behaving as representational)
-- i.e., MEQ Int -> MEQ Car
class MEQ a where { meq :: a -> a -> Bool }
instance MEQ Int where { meq a b = a == b }
deriving instance MEQ Car'

-- Only works when we reduce `MEQ a` to be representational from the default
-- nominal setting, as otherwise `A a` is also required to be nominal due to
-- the MEQ constraint.
type role MEQ representational
data A a where { A :: MEQ a => A a }
cast4 = coerce (A :: A Int) :: A Car'

