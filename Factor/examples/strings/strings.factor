USING: sequences kernel ;

IN: examples.strings

: palindrome? ( str -- ? ) dup reverse = ;