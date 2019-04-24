##Copyright (C) 2012 Sandhya
## 
## This program computes qlog of a variable   


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 6/01-2014

 
function y = qlog(x,q)

clear y ;
  
if q == 1
    y = log(x);
else
   y =  ( x .^(1-q) -1 ) / (1 - q)   ;
end

endfunction    
