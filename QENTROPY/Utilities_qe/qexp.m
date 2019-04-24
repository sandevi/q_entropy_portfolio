##Copyright (C) 2012 Sandhya
## 
## This program computes q exponential of a function


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created:  6/01/2014
 
function y = qexp(x,q)
 
if q == 1
    y = exp(x);
else
    y = (1+(q-1)*x) .^(1/(1-q));
end

 
