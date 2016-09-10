USING: examples.strings tools.test ;
IN: examples.strings-test

{ t } [ "racecar"  palindrome? ] unit-test
{ f } [ "standing" palindrome? ] unit-test