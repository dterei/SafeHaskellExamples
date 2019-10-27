{-# LANGUAGE TemplateHaskell #-}
module B ( Class(..), mkSimpleClass ) where

import Language.Haskell.TH

class Class a where
	c :: a

mkSimpleClass :: Name -> Q [Dec]
mkSimpleClass name = do
	TyConI (DataD _ _ _ _ (NormalC conname _:_) _) <- reify name
	[d|instance Class $(conT name) where c = $(conE conname)|]

