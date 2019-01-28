# Apple/XCTest Macro Reference #

## Links ##
- Testing with Xcode (PDF) - http://tinyurl.com/nct32aq
- http://iosunittesting.com/xctest-assertions/

## Assertions ##

The full list of assertions is located in the file `XCTTestAssertions.h` in
the `/Applications/Xcode.app` folder.

## Comments and compiler warnings ##
- If you add **FIXME**/**TODO**/**???**/**!!!** comments to code, Xcode will
  make jump bar targets for them
- To make compiler warnings, use the `#warning` compiler directive
- To make compiler errors, use the `#error` compiler directive

### Unconditional Failure ###
- `XCTFail` - Generates a failure unconditionally.

### Nil Tests ###
- `XCTAssertNil` - Generates a failure when the test expression is not nil.
- `XCTAssertNotNil` - Generates a failure when the test expression is nil.

### Boolean Tests ###
- `XCTAssert` - Generates a failure when expression evaluates to false.
- `XCTAssertTrue` - Generates a failure when expression evaluates to false.
- `XCTAssertFalse` - Generates a failure when the expression evaluates to true.

### Equality Tests ###
- `XCTAssertEqualObjects` - Generates a failure when `[a1 isEqual:a2]` is
  false (or one is nil and the other is not).
- `XCTAssertNotEqualObjects` - Generates a failure when `[a1 isEqual:a2]` is
  false (or both are nil).
- `XCTAssertEqual` - Generates a failure when the first argument is not equal
  to the second argument. This test is for C scalars, structs and unions.
- `XCTAssertNotEqual` - Generates a failure when the first argument is equal
  to the second argument. This test is for C scalars, structs and unions.
- `XCTAssertEqualWithAccuracy` - Generates a failure when the first argument
  is not equal to the second argument within + or - accuracy. This test is for
  scalars such as floats and doubles, where small differences could make these
  items not exactly equal, but works for all scalars.
- `XCTAssertNotEqualWithAccuracy` - Generates a failure when the first
  argument is equal to the second argument within + or - accuracy. This test
  is for scalars such as floats and doubles, where small differences could
  make these items not exactly equal, but works for all scalars.

### Exception Tests ###
- `XCTAssertThrows` - Generates a failure when expression does not throw an
  exception.
- `XCTAssertThrowsSpecific` - Generates a failure when expression does not
  throw an exception of a specific class.
- `XCTAssertThrowsSpecificNamed` - Generates a failure when expression does
  not throw an exception of a specific class with a specific name.  Useful for
  those frameworks like `AppKit_ or _Foundation` that throw generic
  `NSException` w/specific names (`NSInvalidArgumentException`, etc).
- `XCTAssertNoThrow` - Generates a failure when expression does throw an
  exception.
- `XCTAssertNoThrowSpecific` - Generates a failure when expression does throw
  an exception of the specitied class. Any other exception is okay (i.e. does
  not generate a failure).
- `XCTAssertNoThrowSpecificNamed` - Generates a failure when expression does
  throw an exception of a specific class with a specific name.  Useful for
  those frameworks like `AppKit_ or _Foundation` that throw generic
  `NSException` w/specific names (`NSInvalidArgumentException`, etc).

vim: filetype=markdown shiftwidth=2 tabstop=2
