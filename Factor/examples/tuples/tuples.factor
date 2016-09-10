USING: kernel math accessors ;

IN: examples.tuples

TUPLE: cart-item name price quantity ;

: <dollar-cart-item> ( name -- cart-item ) 1.00 1 cart-item boa ;
: <one-cart-item> ( -- cart-item ) T{ cart-item { quantity 1 } } ;
: <cart-item> ( name price quantity -- cart-item ) cart-item boa ;
: <price-cart-item> ( price -- cart-item ) "default" swap 1 cart-item boa ;
: apply-discount ( cart-item discount -- cart-item ) [ dup price>> dup ] dip * - >>price ;