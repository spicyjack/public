## PHPUnit Assertion List ##
Based on http://themsaid.github.io/2013/09/18/phpunit-assertions/, for PHPUnit
version 4.8

    // complex assertions
    assertThat(<complex assertion>);

    // array sizes
    assertCount($count, $array[, $message]);
    assertEmpty($array[, $message]);

    // For multidimensional arrays, test the presence of a key
    assertArrayHasKey($key, $array[, $message]);
    assertArrayNotHasKey($key, $array[, $message]);

    // More array goodies
    assertArraySubset($subset, $array[, $message]);
    assertContainsOnlyInstancesOf($className, $haystack[, $message]);
    assertContainsNotOnlyInstancesOf($className, $haystack[, $message]);

    // Search of $needle in $haystack array, or substring of $haystack string
    assertContains($needle, $haystack[, $message, $ignoreCase]);
    assertNotContains($needle, $haystack[, $message, $ignoreCase]);
    assertContainsOnly($type, $haystack[, $isNativeType, $message]);
    assertContainsNotOnly($type, $haystack[, $isNativeType, $message]);

    // Type of variable
    assertInternalType($type, $actual[, $message]);
    assertNotInternalType($type, $actual[, $message]);
    assertNull($data[, $message]);
    assertNotNull($data[, $message]);

    // comparisons of primitive types and object attributes
    assertEquals($expected, $actual[, $message]);
    assertNotEquals($expected, $actual[, $message]);
    assertGreaterThan($expected, $actual[, $message]);
    assertGreaterThanOrEqual($expected, $actual[, $message]);
    assertLessThan($expected, $actual[, $message]);
    assertLessThanOrEqual($expected, $actual[, $message]);

    // Same type and value
    assertSame($expected, $actual[, $message]);
    assertNotSame($expected, $actual[, $message]);

    // string tests
    assertStringEndsWith($suffix, $string[, $message]);
    assertStringEndsNotWith($suffix, $string[, $message]);
    assertStringStartsWith($prefix, $string[, $message]);
    assertStringStartsNotWith($prefix, $string[, $message]);
    assertStringEqualsFile($expectedFile, $string[, $message]);
    assertStringNotEqualsFile($expectedFile, $string[, $message]);

    // String formats
    // the format specifier is described in the HTML pages on the PHPUnit site
    assertStringMatchesFormat($format, $string[, $message]);
    assertStringNotMatchesFormat($format, $string[, $message]);
    assertStringMatchesFormatFile($formatFile, $string[, $message]);
    assertStringNotMatchesFormatFile($formatFile, $string[, $message]);

    // regexp tests
    assertRegExp($pattern, $string[, $message]);
    assertNotRegExp($pattern, $string[, $message]);

    // truthyness
    assertTrue($condition[, $message]);
    assertFalse($condition[, $message]);

    // files on the filesystem
    assertFileExists($path[, $message]);
    assertFileNotExists($path[, $message]);
    assertFileEquals($expected, $actual[, $message]);
    assertFileNotEquals($expected, $actual[, $message]);

    // Tests of object classes
    assertInstanceOf($expected, $actual[, $message]);
    assertNotInstanceOf($expected, $actual[, $message]);
    assertClassHasAttribute($attributeName, $className);
    assertClassNotHasAttribute($attributeName, $className);
    assertClassHasStaticAttribute($attributeName, $className);
    assertClassNotHasStaticAttribute($attributeName, $className);

    // Tests of attributes
    assertAttributeEquals($expected, $actual);
    assertAttributeNotEquals($expected, $actual);
    assertAttributeContains($needle, $haystack);
    assertAttributeNotContains($needle, $haystack);
    assertAttributeOnlyInstancesOf($className, $haystack[, $message]);
    assertAttributeNotOnlyInstancesOf($className, $haystack[, $message]);
    assertAttributeGreaterThan($expected, $actual[, $message]);
    assertAttributeGreaterThanOrEqual($expected, $actual[, $message]);
    assertAttributeLessThan($expected, $actual[, $message]);
    assertAttributeLessThanOrEqual($expected, $actual[, $message]);
    assertAttributeInstanceOf($expected, $actual[, $message]);
    assertAttributeNotInstanceOf($expected, $actual[, $message]);
    assertAttributeInternalType($type, $actual[, $message]);
    assertAttributeNotInternalType($type, $actual[, $message]);
    assertObjectHasAttribute($attribName, $object[, $message]);
    assertNotObjectHasAttribute($attribName, $object[, $message]);
    assertAttributeSame($expected, $actual[, $message]);
    assertAttributeNotSame($expected, $actual[, $message]);

    // XML
    assertEqualXMLStructure($expected, $actual[, $message]);
    assertXMLFileEqualsXMLFile($expected, $actual[, $message]);
    assertXMLFileNotEqualsXMLFile($expected, $actual[, $message]);
    assertXMLStringEqualsXMLFile($expectedFile, $actual[, $message]);
    assertXMLStringNotEqualsXMLFile($expectedFile, $actual[, $message]);
    assertXMLStringEqualsXMLString($expected, $actual[, $message]);
    assertXMLStringNotEqualsXMLString($expected, $actual[, $message]);

    // JSON
    assertJsonFileEqualsJsonFile($expected, $actual[, $message]);
    assertJsonStringEqualsJsonFile($expectedFile, $actual[, $message]);
    assertJsonStringEqualsJsonString($expected, $actual[, $message]);

vim: filetype=markdown shiftwidth=2 tabstop=2
