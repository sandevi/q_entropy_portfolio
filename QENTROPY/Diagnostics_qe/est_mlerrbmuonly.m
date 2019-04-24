##Copyright (C) 2012 Sandhya
## 
## This function computes the fisher measured and expected error in mle
## beta estimates, given q
##
##  Input:
##  x = log returns. 
##  th and kp are the estimated theta and kappa values
##
## Output:
##  erbm and erbe are the measured and estimated fisher errors
##  beta respectively. 
##  
## 
## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 9-19-2015

function [ erbm  erbe ermum ermue] = est_mlerrbmuonly(x, mu, th, kp)  ;

 
    clear erbm;  clear erbe; clear ermum; clear ermue  ;
   
    n = length(x)  ;

    q = 1./th + 1;
    bet = th*kp  ;

    
##  Compute measured error

    [erbm  ermum ] = fisher_measurerrbmuonly(x, mu, th, kp)  ;

##  Compute expected  error


    [ erbe ermue] = fisher_errorbmuonly(n, th, kp)  ;


 endfunction  
