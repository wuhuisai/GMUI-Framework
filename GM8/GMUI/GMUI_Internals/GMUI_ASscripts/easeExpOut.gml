#define easeExpOut
/// Exponential Ease for moving controls smoothly
// easeExpOut(t,b,c,d) where t is current time, b is start value, c is change in value, and d is duration

var _t,_b,_c,_d;

_t = argument0;
_b = argument1;
_c = argument2;
_d = argument3;


return _c * ( -power( 2, -10 * _t/_d ) + 1 ) + _b;

