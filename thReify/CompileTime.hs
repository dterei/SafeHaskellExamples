module CompileTime where

import Language.Haskell.TH
import System.IO.Unsafe

import Data.Time

getTime :: String -> IO String
getTime n = do
        time <- getCurrentTime
        return $ "Time (" ++ n ++ "): " ++ show time

unsafeGetTime :: String -> String
unsafeGetTime n = unsafePerformIO $ getTime n

thGetTime :: String -> Q Exp
thGetTime n = stringE $ unsafeGetTime n

