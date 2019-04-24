##
## This pgm estimates the transformed tsallis parameters thet, kappa and mu
## using MLE method
##
## Input:
##
## Created by Sandhya Devi
## 3_15_2016
##

function [kap_f mu_f flg]  = kappamuestonly(x, momt, sig1, tht, kpmin,  mumin,niter)

   clear yt; clear kp; clear sg ;

   global yt; global kp; global sg ;

   clear kap_f; clear mu_f ; 

   flg = 0  ;
   

##  Search the solution for mu 


    mu = momt ;
    sg = sig1 ;

    for iter = 1: niter

    clear y;

    y = (x -  mu) /sg  ;

    thresh = prctile(abs(y), 20, 1)  ;

    [kap] =  kappaestonly(y,tht,kpmin, thresh);

    if( abs(imag(kap)) > 0)
	flg = -1 ;
        kap = NaN
        return
    endif	

    
    yt = x   ;
    kp = kap   ;
    mu0 = mu ;
   
    
##    [mu fval info] = fzero("func_mu", -.01) ;
    [mu fval info flg1 outp] = fzero_new("func_mu", -mu0) ;

    if( info != 1)
     printf(" Solution singular valued  in fzero_new in kappamuestonly \n") ;  
     printf(" mu fval info flg1 %f %f %f %f\n",  mu, fval, info, flg1) ;
     flg = -1 ;
     mu_f = NaN ;
     kap_f = kap;
     return
    endif 

     
    if(flg1  != 0)
       printf(" no solution is found in fzero_new in kappamuestonly \n") ;
       flg = -1 ;
       mu_f = NaN ;
       kap_f = kap;
       return
    endif

    difx = 0  ;
    if(abs(mu) > 0)
      difx = 100*abs((mu - mu0)/mu0)  ;
      if(difx <= .08)
         kap_f = kap; mu_f = mu ;
        return
      endif
    endif      

    end


     kap_f = kap; mu_f = mu;


     clear yt; clear kp; clear sg;


endfunction  
