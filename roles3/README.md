# GND & Roles

Explore the rule that newtype selectively hides the coercion instance depending
on if the constructor is in scope or not.

## Result

Safe. Although some worry about gaining access to dictionary, but seems can
only do when using polymorphic types (concrete types incurr the constructor
check, even when declaring the dictionary is passed in). So seems safe.

