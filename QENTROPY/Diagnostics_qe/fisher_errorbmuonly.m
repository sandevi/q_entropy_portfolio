##Copyright (C) 2012 Sandhya
## 
## This function uses expected fisher information matrix to compute errors in beta, given q

## Created: 1-12-2016

function [  errb  errmu] = fisher_errorbmuonly(n, th, kp)

 
 clear errb; clear errmu  ;  

 bet = kp*th  ;
   
    

## Compute expected fisher matrix for b and mu

     clear f22 ; clear f33; 

     f22 = - (0.25/bet^2) * ((2*th-1) / (th+1))  ;

     f33 = -2*(kp) * (th-.5) *(th - 1. / (th+ 1))  ; 

     f23 = 0;

     clear f;


    f = -n*([ f22 f23; f23 f33 ]) ;

      
## Compute expected fisher error matrix in b mu


    clear ifbm  ;
    ifbm = inv(f)  ;
    
    
    errb = sqrt( (ifbm(1,1)) )  ; errmu = sqrt( (ifbm(2,2)) )  ; 


endfunction
