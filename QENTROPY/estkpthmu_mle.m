##
## This pgm estimates the transformed tsallis parameters thet, kappa and mu
## using MLE method
##
## Input:
##
## Created by Sandhya Devi
## 3_15_2016
##

function [theta_f kap_f mu_f]  = estkpthmu_mle(x, mom, sig1,  thmin, kpmin, mumin, niter)

   clear yt; clear th; clear kp; clear sg ; 

   global yt; global th; global kp;  global sg ; 

   clear theta_f; clear kap_f; clear mu_f ; 

   

##  Search the solution for mu 


    mu = mom ;
    sg = sig1 ;

   for iter = 1: niter

    clear y;

    y = (x - mu)/ sg ;

    thresh_t = prctile(abs(y), 20,1)  ;
    thresh_k = prctile(abs(y), 5, 1)  ;

    [theta kap] =  estkpth_mle(y,thresh_t,thresh_k,thmin, kpmin);
    
     yt = x ; 
     kp = kap  ;
     th = theta;
     mu0 = mu ;
	 
    [mu fval info] = fsolve("func_mu", mumin) ;

    difx = 0  ;
    if(abs(mu) > 0)
      difx = 100*abs((mu - mu0)/mu0)  ;
      if(difx <= .2)
        theta_f = theta; kap_f = kap; mu_f = mu ;
        return
      endif
    endif      

    
    
##    printf(" theta kap mu = %f %f %f\n", theta, kap,mu)  ; 

   end


    theta_f = theta; kap_f = kap; mu_f = mu ;

    clear yt; clear kp; clear sg; 

endfunction  
