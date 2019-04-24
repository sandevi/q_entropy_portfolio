##Copyright (C) 2012 Sandhya
## 
## This program generates a normalised tsallis pdf, given the parameters q and lamda
##  np is the no. of bins for the histogram   


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-11-01


 
function [tsa]  = qgeneral_dist(x,q,lambda,alf)

clear y ; clear tsa;


for i = 1:length(x) 
    xab = abs(x(i))  ;
   y(i) =  qgaus(-lambda*(xab)^alf,q);
endfor
tsa = y    ;


endfunction    
 
function y = qgaus(x,q)
  
if q == 1
    y = exp(x);
else
    y = (1+(1-q)*x)^(1/(1-q));
end

endfunction
