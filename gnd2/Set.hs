{-# LANGUAGE RoleAnnotations #-}
module Set (Set, insert, empty) where

import Data.List (sort)

-- > data or newtype doesn't matter as we're making use of the lifting instances
-- > which aren't subject to the constructor export control.
-- data Set a = MkSet [a] deriving (Eq, Show)
newtype Set a = MkSet [a] deriving (Eq, Show)

-- > i.e., we get the following instances
--
-- > axioms
-- instance Coercible a a
--
-- > unwrapping instances:
-- instance Coercible [a] b => Coercible (Set a) b
-- instance Coercible a [b] => Coercible a (Set b)
--
-- > lifting instances:
-- instance Coercible a b => Coercible (Set a) (Set b)
--
-- > Unwrapping instances are only available when the `MkSet` constructor is in
-- > scope, but lifting instances are always available unless we declare `Set a`
-- > to be nominal in the `a` type parameter.
--
-- > explicit nominal role fixes the issue
-- type role Set nominal

insert :: Ord a => a -> Set a -> Set a
insert x (MkSet xs) = MkSet $ sort $ x:xs

empty :: Set a
empty = MkSet []

