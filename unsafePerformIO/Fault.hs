module Main where

import Data.IORef
import System.IO.Unsafe

test :: IORef [a]
test = unsafePerformIO $ newIORef []
     
main :: IO ()
main = do
    writeIORef test [42]
    bang <- readIORef test
    print (bang :: [Either Int Float])

