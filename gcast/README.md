# GCast

Tried to abuse gcast in Data.Typable. It seems on the surface that you
could get the same result as GND since gcast type is:

~~~~ {.haskell}
gcast :: (Typeable a, Typeable b) => c a -> Maybe (c b)
~~~~

So the worrying thing here is how gcast can work with any 'c'
parameter. Indeed even if I haven't exported the constructors of a
data type gcast still works through that structure.

## Result

However I believe it is safe. To get a result like GND we don't just
need to be able to see through 'c', we need to be able to change the
type. gcast and related functions are safe as they aren't meant to
change the type. When you get a 'Just x', the Typeable a and Typeable
b should be the same type (since their TypeRep's should match). gcast
and related are really oracles that answer the question, is my forall
x type actually concrete type 'y'. Its like an 'instanceof' operation
in Java with the conversion as well. GND though go further than that,
it allows us to actually change the types which is the issue.

