{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE IncoherentInstances #-}
module ExpDicts_Sub (
    MEQ(..),
    normMEQ
  ) where

-- Requires we explicitly use representational
type role MEQ representational
class MEQ a where { meq :: a -> a -> Bool }

instance MEQ Char where { meq _ _ = True }

normMEQ :: MEQ a => a -> a -> Bool
normMEQ a b = a `meq` b

