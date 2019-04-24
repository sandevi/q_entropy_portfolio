##Copyright (C) 2012 Sandhya
## 
## This function computes the fisher measured and expected error in mle
## q and beta estimates
##
##  Input:
##  x = log returns. 
##  th and kp are the estimated theta and kappa values
##
## Output:
##  erqm, erbm, erqe and erbe are the measured and estimated fisher errors
## in q and beta respectively. 
##  
## 
## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 9-19-2015

function [ erqm erbm ermum erqe erbe ermue] =est_mlerrqbmu(x, mu, th, kp, sg)  ;

 
    clear erqm; clear erbm; clear ermum;  clear erqe; clear erbe; clear ermue;
   
    n = length(x)  ;
    
##  Compute measured error

    [erqm erbm ermum] = fisher_measurerrmuqb(x, mu, th,kp,sg)  ;

##  Compute expected  error


    [erqe erbe ermue] = fisher_errormuqb(n,th,kp,sg)  ;


 endfunction  
