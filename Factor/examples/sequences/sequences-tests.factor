USING: examples.sequences tools.test kernel ;
IN: examples.sequences-tests

{ 5 } [ { 4 5 6 } [ 5 = ] find-first ] unit-test
{ 6 } [ { 4 5 6 } [ 6 = ] find-first ] unit-test
{ f } [ { 4 5 6 } [ 7 = ] find-first ] unit-test