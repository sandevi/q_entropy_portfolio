##Copyright (C) 2012 Sandhya
## 
## This function uses measured fisher information matrix to compute error in q and beta
## Created: 9-19-2015

function [ errq, errb errmu] = fisher_measurerrmuqb(lrx,  mu, th, kp, sg)

 
    clear errq; clear errb; clear errmu; 
   
## compute q and beta from theta and kappa    
   
   
    thi = th  ; 
    q = 1/thi + 1;
    bet = kp*thi  ;

    clear lr;
    lr = (lrx - mu) / sg ;
    n = length(lr)  ;

    clear x2; clear y2;

    
    
    x2 = (lr .* lr)  ;


    clear g2; clear y2; clear yk2;  clear lpdt1 ; clear lpdt2  ; clear f11;
    

## compute theta derivative


    y2 = log(1 + kp*x2)   ;
    yk2 = (x2 ./ ( 1 .+ kp*x2))  ;

    g2 =  (digamma2(thi) - digamma2(thi - 0.5))  ;

    lpdt1 =  -(thi^2)*(g2 .- y2)  ;

    lpdt2 =  lpdt1 + (0.5*thi)* (1 - 2*bet * yk2)    ;

    f11 =  sum((lpdt2 .* lpdt2 ))  ;

##    printf(" th kpt bet  f11   %f  %f  %f  %f\n",th,  kp, bet,  f11)  ;

## Compute kappa  derivative
      
    clear lpdk1  ; clear lpdk2  ;  clear f22; 


    lpdk1 = 0.5 / bet  ;
    
    lpdk2 = lpdk1 .- yk2  ; 
  
    f22 = sum(lpdk2 .* lpdk2) ;

##    printf(" th kp bet f22 %f  %f  %f  %f\n",th, kp, bet, f22)   ;

##  Compute mu derivative

    clear lpdx1; clear lpdx2; clear f33; 

    y = sqrt(kp) * lr  ;
    

    fac = (2*sqrt(kp)*th) /sg ;

    lpdx1 =  y ./ ( 1 .+ y .* y)  ;

    lpdx2 =  fac*(lpdx1)  ;


    f33 =  sum(lpdx2 .* lpdx2)  ;


##  Compute cross derivatives

    clear f12; clear f13  ; clear f23;


    f12 = sum(lpdt2 .* lpdk2)  ;
    f13 = 0  ;
    f23 = 0  ;
     

##  Compute Fisher Info matrix elements in q, b

    clear fqb; clear ifqb ;

    fqb = [f11 f12 f13; f12 f22 f23; f13 f23 f33]   ;


    ifqb = inv(fqb)  ;
    

    errq = sqrt((ifqb(1,1))) ; errb = sqrt((ifqb(2,2))) ; errmu = sqrt((ifqb(3,3)))  ;


##    printf(" errq errb errmu  %f  %f  %f\n",errq, errb, errmu)  ;

 endfunction  
