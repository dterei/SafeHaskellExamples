-- Code taken from
-- http://stackoverflow.com/questions/12735274/breaking-data-set-integrity-without-generalizednewtypederiving/12744568#12744568

module A ( U(..) ) where

data U = X | Y deriving (Eq, Show)

