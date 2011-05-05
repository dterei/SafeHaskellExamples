GHC allows typeclass instance functions to overlap. This allows
any module to change the behaviour of any other part of the code
that calls a typeclass function by providing a more specific
instance that the one currently being used at that call site.

An attacker can use this to change the behaviour of the TCB code.
While you can protect against it by only calling typeclass
functions with concrete instance types (so they are already the
most specific instance) this is not ideal.

results
-------

Unsafe.

