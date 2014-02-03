# Apple/XCTest Macro Reference #

The full list of assertions is located in:

    Applications/Xcode.app/Contents/Developer/Library/Frameworks/XCTest.framework/Headers/XCTestAssertions.h

This is a symlink to the current version installed on the machine.  The order
of test assertions below is the same order as they appear in
`XCTestAssertions.h`.

### Unconditional Failure ###
- _XCTFail_ - Generates a failure unconditionally.

### Nil Tests ###
- _XCTAssertNil_ - Generates a failure when the test expression is not nil.
- _XCTAssertNotNil_ - Generates a failure when the test expression is nil.

### Boolean Tests ###
- _XCTAssert_ - Generates a failure when expression evaluates to false.
- _XCTAssertTrue_ - Generates a failure when expression evaluates to false.
- _XCTAssertFalse_ - Generates a failure when the expression evaluates to true.

### Equality Tests ###
- _XCTAssertEqualObjects_ - Generates a failure when `[a1 isEqual:a2]` is
  false (or one is nil and the other is not).
- _XCTAssertNotEqualObjects_ - Generates a failure when `[a1 isEqual:a2]` is
  false (or both are nil).
- _XCTAssertEqual_ - Generates a failure when the first argument is not equal
  to the second argument. This test is for C scalars, structs and unions.
- _XCTAssertNotEqual_ - Generates a failure when the first argument is equal
  to the second argument. This test is for C scalars, structs and unions.
- _XCTAssertEqualWithAccuracy_ - Generates a failure when the first argument
  is not equal to the second argument within + or - accuracy. This test is for
  scalars such as floats and doubles, where small differences could make these
  items not exactly equal, but works for all scalars.
- _XCTAssertNotEqualWithAccuracy_ - Generates a failure when the first
  argument is equal to the second argument within + or - accuracy. This test
  is for scalars such as floats and doubles, where small differences could
  make these items not exactly equal, but works for all scalars.

### Exception Tests ###
- _XCTAssertThrows_ - Generates a failure when expression does not throw an
  exception.
- _XCTAssertThrowsSpecific_ - Generates a failure when expression does not
  throw an exception of a specific class.
- _XCTAssertThrowsSpecificNamed_ - Generates a failure when expression does
  not throw an exception of a specific class with a specific name.  Useful for
  those frameworks like _AppKit_ or _Foundation_ that throw generic
  _NSException_ w/specific names (`NSInvalidArgumentException`, etc).
- _XCTAssertNoThrow_ - Generates a failure when expression does throw an
  exception.
- _XCTAssertNoThrowSpecific_ - Generates a failure when expression does throw
  an exception of the specitied class. Any other exception is okay (i.e. does
  not generate a failure).
- _XCTAssertNoThrowSpecificNamed_ - Generates a failure when expression does
  throw an exception of a specific class with a specific name.  Useful for
  those frameworks like _AppKit_ or _Foundation_ that throw generic
  _NSException_ w/specific names (`NSInvalidArgumentException`, etc).

vim: filetype=markdown shiftwidth=2 tabstop=2
