{-# LANGUAGE SafeImports #-}
module C ( main' ) where

import safe B

main' = do
    let n = mainM 1
    print $ n

