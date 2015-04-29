# GND Superclasses

GND allows you to create essentially incoherent instances. Given a type T and a
newtype wrapper T', GND when deriving a Class C with superclass C' for T' will
generate an instance C T' but that uses C' T, not C' T' as the super class for
that dictionary.

## Result

Can't figure out how to break. This allows you to create new type aliases to
existing dictionaries, but it doesn't seem to allow any way to create a new
dictionary and alias it to an existing type.

Well, look at BadInsert. I can't override existing types and behavior, but I
can create my own new types that violate invariants. However, is this any
different from orphan instances?

