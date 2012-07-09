-- Can we abuse the defaulting mechanism to create abstract types we shouldn't
-- be allowed to?
module T where

import M

default (G)

-- seems like a bad result
-- NOTE: G must be an instance of 'Num' for the below to compile
bad :: G
bad = -1
-- but really GHC generates the following:
-- bad :: G
-- bad = negate (fromInteger(1))
--
-- which reduces to:
-- bad :: G
-- bad = mkG 71

-- NOTE: G must be an instance of 'Fractional' for the below to compile
bad2 :: G
bad2 = 1.243

