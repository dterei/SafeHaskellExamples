{-# LANGUAGE RankNTypes, ScopedTypeVariables, StandaloneDeriving, GADTs, GeneralizedNewtypeDeriving, DeriveDataTypeable #-}

module Main where

import Data.Typeable

data Expr a where
    Lit :: Typeable a => a -> Expr a

class A a where
    mk :: a

class (Typeable a, A a) => B a where
    mkExpr :: Expr a
    mkExpr = Lit mk

instance B a => A (Expr a) where
    mk = mkExpr

instance A Bool where
    mk = True

newtype BOOL = BOOL Bool
    deriving (Typeable, A)

instance B Bool
deriving instance B BOOL

showType :: forall a . Expr a -> String
showType (Lit _) = show (typeOf (undefined :: a))

test1 = showType (mk     :: Expr BOOL) -- Prints "Bool" (wrong?)
test2 = showType (Lit mk :: Expr BOOL) -- Prints "Main.BOOL" (correct)

main = do
    print test1
    print test2

