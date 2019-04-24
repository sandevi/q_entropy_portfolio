##Copyright (C) 2012 Sandhya
## 
##
## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 05-03-2014

function [  kpfinal]  = kappaestonly(x, tht, kpmin, thresh)


   clear x2  ; clear th; clear kpfinal; clear errb;

   global x2  ;
   global th  ;

   th = 1 / tht; 

   clear kpfinal;  

   clear xt;  
   xt = x( abs(x) >= thresh)  ;

   x2 = xt .* xt ;
 

##  estimate kappa


   [kpf fval info] = fsolve("fkappa", kpmin)  ;


	 
   kpfinal =  kpf  ;
   q = th + 1;
   bet = kpfinal*tht  ;
		 
##   printf(" kpf fval info = %f %e %f  \n", kpf, fval, info) ;  

## Compute fisher error
 
##   errb = fisher_measurerrbonly(xt, q, bet)  ;

##   printf(" kpf tht errb %f %f %f\n", kpf, tht, errb)  ;

endfunction  
