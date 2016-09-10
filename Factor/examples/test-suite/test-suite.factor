USING: vocabs.files tools.test io io.streams.null kernel namespaces sequences vocabs prettyprint ;

USE: examples.greeter
USE: examples.strings
USE: examples.sequences
USE: examples.tuples
USE: examples.checkout

IN: examples.test-suite

SYMBOL: test-count

: test-all-examples ( -- )
  [ "examples" test ] with-null-writer
  test-failures get empty?
  [ "All tests passed." print ] [ :test-failures ] if ;

: test-one ( -- )
  0 test-count set
  "Test which vocab? " write flush readln
  "examples." swap append
  dup "Running tests for " swap append print
  test
  test-failures get empty?
  [ "All tests passed." print ] [ :test-failures ] if
;

MAIN: test-one