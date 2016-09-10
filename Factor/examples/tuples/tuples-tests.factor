USING: kernel tools.test accessors math ;

USE: examples.tuples

IN: examples.tuples-test

{ T{ cart-item f f f f } } [ cart-item new ] unit-test
{ T{ cart-item f f 4.95 f } } [ cart-item new 4.95 >>price ] unit-test
{ 4.95 } [ cart-item new 4.95 >>price price>> ] unit-test
{ T{ cart-item f f 12.5 f } } [ cart-item new 25.00 >>price [ 0.5 * ] change-price ] unit-test
{ T{ cart-item f "Seven Languages Book" 25.0 1 } } [ "Seven Languages Book" 25.00 1 cart-item boa ] unit-test
{ T{ cart-item f "Paint brush" 1.0 1 } } [ "Paint brush" <dollar-cart-item> ] unit-test
{ T{ cart-item f f f 1 } } [ <one-cart-item> ] unit-test
{ T{ cart-item f "orange" 0.59 f } } [ T{ cart-item f "orange" 0.59 } ] unit-test
{ T{ cart-item f "7lang2" 24.99 2 } } [ "7lang2" 24.99 2 <cart-item> ] unit-test
{ T{ cart-item f "default" 9.87 1 } } [ 9.87 <price-cart-item> ] unit-test
{ T{ cart-item f "default" 78.0 1 } } [ 100.0 <price-cart-item> 0.22 apply-discount ] unit-test