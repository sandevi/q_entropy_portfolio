##Copyright (C) 2012 Sandhya
## 
## This program generates a normalised tsallis pdf, given the parameters q and lamda
##  np is the no. of bins for the histogram   


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-11-01


 
function [v ir ic]  = max2d(x)

clear v ; clear ir; clear ic;

clear w; clear iw;
[w iw] = max(x)  ;
[wc ic] = max(w) ;
ir = iw(ic)  ;
v = wc;

endfunction    
 
