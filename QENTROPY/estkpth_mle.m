##
## This pgm estimates the transformed tsallis parameters theta and kappa using
## MLE method
##
## Input:
##
## Created by Sandhya Devi
## 3_15_2016
##

function [theta_f kap_f ]  = estkpth_mle(x,thresh_t, thresh_k, thmin, kpmin)

   clear x2 ;

   global x2 ;
   clear theta_f; clear kap_f; 

## printf("max val of kp = %f \n", kpmin)  ;
   

##  Search the solution for kappa 

    clear xk; 

    xk = x( abs(x) >= thresh_k) ;
##    xk = x( abs(x) >= thresh_t) ;


    x2 = xk .* xk  ;


    clear kpf; 
  
      [kpf fval info] = fsolve("func_kappath", kpmin)  ;

##      printf("kpf, fval, info = %f %e %f\n", kpf, fval, info)  ;
  
## compute Theta

 
    clear xt; clear x2t ; clear y2t  ;

    xt = x( abs(x) >= thresh_t) ;
##    xt = x( abs(x) >= thresh_k) ;

    x2t = xt .* xt  ;

    y2t =   1. + kpf .* x2t   ;

    mxy2 = mean(x2t ./ y2t )  ;

    thf = 2 * kpf * mxy2  ;

      theta_f = 1 /thf;  kap_f =  kpf  ;

##      printf(" final th, kp = %f %f \n",theta_f, kpf )  ;

##  Compute fisher errror for q and beta

##    clear errq; clear errb;

##    [errq errb] = fisher_measurerrqb(xt,theta_f, kap_f) ;

endfunction  
