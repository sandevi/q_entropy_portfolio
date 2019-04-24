##Copyright (C) 2012 Sandhya
## 
## This program generates a normalised tsallis pdf, given the parameters q and lamda
##  np is the no. of bins for the histogram   


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-11-01


 
function [v ir ic]  = min2d(x)

clear v ; clear ir; clear ic;

clear w; clear iw;
[w iw] = min(x)  ;
s = size(x);
if (s(1) == 1)
   ir = 1; ic =iw; v = w;
elseif (s(2) == 1)
   ir = iw; ic = 1; v = w;
else   
   [wc ic] = min(w) ;
    ir = iw(ic)  ;
    v = wc;
endif
endfunction    
 
