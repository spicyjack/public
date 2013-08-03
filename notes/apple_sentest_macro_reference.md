# Apple/SenTest Macro Reference #

## Unconditional Failure #
- STFail - Fails the test case.

## Equality Tests ##
- **STAssertEqualObjects** - Fails the test case when two objects are different.
- **STAssertEquals** - Fails the test case when two values are different.
- **STAssertEqualsWithAccuracy** - Fails the test case when the difference
  between two values is greater than a given value.

## Nil Tests ##
- **STAssertNil** - Fails the test case when a given expression is not nil.
- **STAssertNotNil** - Fails the test case when a given expression is nil.

## Boolean Tests ##
- **STAssertTrue** - Fails the test case when a given expression is false.
- **STAssertFalse** - Fails the test case when a given expression is true.

## Exception Tests ##
- **STAssertThrows** - Fails the test case when an expression doesn’t raise an
  exception.
- **STAssertThrowsSpecific** - Fails the test case when an expression doesn’t
  raise an exception of a particular class.
- **STAssertThrowsSpecificNamed** - Fails the test case when an expression
  doesn’t raise an exception of a particular class with a given name.
- **STAssertNoThrow** - Fails the test case when an expression raises an
  exception.
- **STAssertNoThrowSpecific** - Fails the test case when an expression raises
  an exception of a particular class.
- **STAssertNoThrowSpecificNamed** - Fails the test case when an expression
  doesn’t raise an exception of a particular class with a given name.
- **STAssertTrueNoThrow** - Fails the test case when an expression is false or
  raises an exception.
- **STAssertFalseNoThrow** - Fails the test case when an expression is true or
  raises an exception.

vim: filetype=markdown shiftwidth=2 tabstop=2
