{-# LANGUAGE Safe #-}
{-# LANGUAGE FlexibleContexts #-}
module UnsafePlugin (
    runPlugin
  ) where

import safe RIO
import safe ReCoerce

-- We defer the creation of the dictionary, relying on trusted code generting
-- it for us, somewhat in a confused deputy manner.
runPlugin :: Coercible a (String) => a -> RIO ()
runPlugin lv = do
  rPutStrLn "plugin..."
  let (v) = coerce lv
  rPutStrLn $ "Labeled value: " ++ v

