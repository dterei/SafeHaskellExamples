module ControlMonadSTLazy where

import Control.Monad
import Control.Monad.ST.Lazy
-- import Control.Monad.ST.Unsafe
import Data.STRef.Lazy

sumST :: Num a => [a] -> a
sumST xs = runST $ do
    n <- newSTRef 0
    forM_ xs $ \x -> do
        modifySTRef n (+x)
    readSTRef n

badST :: ()
badST = runST $ unsafeIOToST $ putStrLn "Hello World"

