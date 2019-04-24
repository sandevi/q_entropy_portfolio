##Copyright (C) 2012 Sandhya
## 
## This function uses expected fisher information matrix to compute errors in q and beta at the estimated values

## Created: 1-12-2016

function [ errq errb errmu ] = fisher_errormuqb(n, th, kp, sg)

 
 clear errq; clear errb;  clear errmu;
   
    
    bet = kp*th  ;  


## Compute expected fisher matrix

    clear f11; clear f12; clear f22 ; clear f13; clear f23; clear f33 ;

    f11 = (th^4)*(trigamma(th) - trigamma(th-0.5)) + 0.25*(th^2)*(2*th + 5)/(th+1)  ;

    f12 = (.75/bet) *(th/(th+1))  ;

    f22 = - (0.25/bet^2) * ((2*th-1) / (th+1))  ;

    f13 = f23 = 0  ;


    f33 = -2*(kp/(sg^2)) * (th-.5) *(th - 1. / (th+ 1))  ;


    clear f;

    f = -n*([f11 f12 f13; f12 f22 f23; f13 f23 f33]) ;




## Compute expected fisher error matrix in q,b


    clear ifqb; 

    ifqb = inv(f)  ;
    
    errq = sqrt((ifqb(1,1))) ; errb = sqrt((ifqb(2,2)))  ; errmu = sqrt((ifqb(3,3))) ; 

endfunction
