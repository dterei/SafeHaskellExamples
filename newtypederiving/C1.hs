{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE GADTs #-}

{-
    This should be able to fail since while Z a has two constructors
    we have used GADTs to give them both different types (Z Int
    and Z Moo respectively). However using newtype deriving we
    have a function that allows Moo ~ Int (while newtypes have this
    as their underlying representation they are meant to be
    differentiated on the type level).
-}

class IsInt t where
    isInt :: c Int -> c t
instance IsInt Int where isInt = id

newtype Moo = Moo Int deriving ( IsInt, Show )

{-
instance IsInt Moo where
    isInt :: c Int -> c t
    isInt = id
-}

data Z a where
  ZI :: Double -> Z Int
  ZM :: (Int, Int) -> Z Moo

foo :: Z Moo -> Moo
foo (ZM (i, _)) = Moo i
foo (ZI _     ) = undefined

main = do
    print $ foo (isInt (ZI 4.0))

-- isInt :: IsInt t => c Int -> c t
--   isInt :: IsInt Int => c Int -> c Int
--   isInt :: IsInt Moo => c Int -> c Moo
-- 
-- Moo ~ Int
--
-- ZI :: Double -> Z Int
-- ZM :: (Int, Int) -> Z Moo
--
-- foo :: Z Moo -> Moo
--

-- a = ZI 4.0  :: Z Int
-- b = isInt a :: IsInt t => Z t
--             :: Z Moo
-- c = foo b   :: Moo
-- d = print c :: IO ()

