{-# LANGUAGE Trustworthy #-}
module Main where

import safe Untrusted
import safe TypeClassSafe
import TypeClassUnsafe
import BadSafeClassInstance

main = do
    let client  = run 1
        clientB = runB True
        clientI = runI 1
        badme = (same True)

    putStrLn "---------" 
    putStrLn $ "No EVIL should appear as in client..."
    putStrLn $ "client : 1 => " ++ show clientI
    putStrLn $ "clientB: True => " ++ show clientB
    putStrLn $ "clientI: 1 => " ++ show clientI

    putStrLn ""
    putStrLn "---------" 
    putStrLn $ "Expecting some EVIL as in Main now..."
    putStrLn $ "badme: True => " ++ show badme
    putStrLn ""
    return ()

