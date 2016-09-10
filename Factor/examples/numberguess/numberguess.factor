USING: kernel io math math.parser random namespaces combinators ;

IN: examples.numberguess

SYMBOL: secret
SYMBOL: s-min
SYMBOL: s-max

: ask-number ( min max -- ) [ number>string ] bi@ swap "Enter a number " write write "-" write write ": " write flush ;

: read-number ( -- n ) readln string>number ;

: print-number ( n -- ) number>string print ;

: print-higher ( -- ) "Higher" print ;

: print-lower ( -- ) "Lower" print ;

: print-correct ( -- ) "Correct" print ;

: print-invalid ( -- ) "Invalid" print ;

: process-number ( min max guess -- new-min new-max )
    dup
    [ {
        { [ dup secret get = ] [ nip nip dup print-correct ] }
        { [ dup secret get > ] [ 2dup > [ nip ] [ drop ] if print-lower ] }
        { [ dup secret get < ] [ 3dup nip < [ rot drop swap ] [ drop ] if print-higher ] }
    } cond ]
    [ drop print-invalid ] if
;

: process-guess ( -- new-min new-max )
    s-min get s-max get [ ask-number ] 2keep
    read-number
    process-number
    s-max set s-min set
    s-min get s-max get
    ;

: game-loop ( -- continue? )
    process-guess
    = not
;

: run ( -- )
    "Welcome to number guess " write flush
    100 random dup secret set number>string print flush
    1 s-min set
    100 s-max set
    [ game-loop ] loop
;

MAIN: run