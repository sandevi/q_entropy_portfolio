##Copyright (C) 2012 Sandhya
## 
## This program generates a normalised tsallis pdf, given the parameters q and lamda
##  np is the no. of bins for the histogram   


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-11-01


 
function [tsa]  = qgaus_dist(x,q,lambda)

clear y ; clear tsa;

dx = (max(x) - min(x))/length(x) ;

for i = 1:length(x) 
   y(i) =  qgaus(-lambda*(x(i))^2,q);
endfor
norm = dx*sum(y);
tsa = y / norm   ;


endfunction    
 
function y = qgaus(x,q)
  
if q == 1
    y = exp(x);
else
    y = (1+(1-q)*x)^(1/(1-q));
end
