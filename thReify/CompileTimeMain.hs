module CompileTimeMain where

import CompileTime

main :: IO ()
main = do
    putStrLn ( $(thGetTime "compile") )
    putStrLn (unsafeGetTime "run")

