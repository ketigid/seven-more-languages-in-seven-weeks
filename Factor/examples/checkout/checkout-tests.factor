USING: examples.checkout examples.tuples tools.test kernel arrays ;
IN: examples.checkout-tests

: <sample-cart> ( -- cart )
  "7lang2" 24.99 2 <cart-item> "noderw" 10.99 1 <cart-item> 2array ;
: <sample-cart-2> ( -- cart )
  "7lang2" 24.99 5 <cart-item> "noderw" 10.99 5 <cart-item> 2array ;

{ T{ checkout f 3 60.97 9.13 4.49 74.59 } }
[ <sample-cart> <checkout> sample-checkout ]
unit-test

{ T{ checkout f 10 179.9 21.17 0.0 201.07 } }
[ <sample-cart-2> <checkout> checkout-processing ]
unit-test
