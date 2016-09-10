USING: math math.functions kernel accessors sequences namespaces ;

USE: examples.tuples

IN: examples.checkout

TUPLE: checkout item-count base-price taxes shipping total-price ;

CONSTANT: gst-rate 0.05
CONSTANT: pst-rate 0.09975

CONSTANT: base-shipping 1.49
CONSTANT: per-item-shipping 1.00
CONSTANT: flat-rate-shipping 5.0
CONSTANT: free-shipping-threshold 8.0

: per-item ( checkout -- shipping ) per-item-shipping * base-shipping + ;
: flat-rate ( checkout -- shipping ) free-shipping-threshold < [ flat-rate-shipping ] [ 0.0 ] if ;

: 2-sig-fig ( x -- y ) 100 * round 100 / ;

: shipping ( checkout shipping-calc -- shipping )
  [ dup item-count>> ] dip
  call 2-sig-fig >>shipping ; inline

: gst-pst ( price -- taxes ) [ gst-rate * ] [ pst-rate * ] bi + ;
: apply-tax ( price rate -- taxes ) * ;

: taxes ( checkout taxes-calc -- taxes )
  [ dup base-price>> ] dip
  call 2-sig-fig >>taxes ; inline

: sum ( seq -- n ) 0 [ + ] reduce ;
: cart-item-count ( cart -- count ) [ quantity>> ] map sum ;
: cart-item-price ( cart-item -- price ) [ price>> ] [ quantity>> ] bi * ;
: cart-base-price ( cart -- price ) [ cart-item-price ] map sum ;

: <base-checkout> ( item-count base-price -- checkout )
  f f f checkout boa ;
: <checkout> ( cart -- checkout )
  [ cart-item-count ] [ cart-base-price ] bi <base-checkout> ;

: total ( checkout -- total-price ) dup
  [ base-price>> ] [ taxes>> ] [ shipping>> ] tri + + 2-sig-fig >>total-price ;

: sample-checkout ( checkout -- checkout )
  [ gst-pst ] taxes [ per-item ] shipping total ;

: checkout-processing ( checkout -- checkout )
  [ 0.1177 apply-tax ] taxes [ flat-rate ] shipping total ;