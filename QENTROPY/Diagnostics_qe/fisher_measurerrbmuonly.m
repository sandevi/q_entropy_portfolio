##Copyright (C) 2012 Sandhya
## 
## This function uses measured fisher information matrix to compute error in q and beta
## Created: 9-19-2015

function [ errb errmu] = fisher_measurerrbmuonly(lrx, mu, th, kp)

 
      clear errb; clear errmu;
   
## compute q and beta from theta and kappa    

   
    bet = kp*th ; 

    clear lr;
    lr = (lrx - mu)  ;
    n = length(lr)  ;

    clear x2; clear yk2;


    
    x2 = lr .* lr  ;

## Compute beta derivative

     clear lpdk1  ;   clear lpdk2 ;  clear f22; 

    yk2 = (x2 ./ ( 1 + kp*x2))  ;

    lpdk1 = 0.5 / bet  ;
    
    lpdk2 = lpdk1 .- yk2  ; 
  
    f22 = sum(lpdk2 .* lpdk2) ;



## Compute mu derivative

     clear y; clear lpdx1 ;  clear lpdx2;  clear f33;

     y = sqrt(kp) * lr  ;
    

    fac = (2*sqrt(kp)*th)  ;

    lpdx1 =  y ./ ( 1 .+ y .* y)  ;

    lpdx2 =  fac*(lpdx1)  ;


    f33 =  sum(lpdx2 .* lpdx2)  ;

    
## Compute cross derivatives

    clear f23;

    f23 = 0; 

##  Compute Fisher Info matrix elements in  b

    clear fbm;  clear ifbm ;



    fbm =  [f22 f23 ; f23 f33]  ;

    ifbm = inv(fbm)   ;
    
    
    errb = sqrt((ifbm(1,1)))  ; errmu = sqrt((ifbm(2,2)))  ; 


 endfunction  
