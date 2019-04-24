##Copyright (C) 2012 Sandhya
## 
## This program computes log of a variable, needed to compute shannon entropy
## log(x =0) is seto zero


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 6/01-2014

 
function y = mylog(x)

clear y ;
  
  y = 0;
  
  if x > 0
     y = log(x)  ;
  endif


endfunction    
