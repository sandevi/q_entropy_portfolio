##Created by Sandhya Devi
## 3-15-26
##
 
function [kap1  kap2  mu_est kappa_est flg]  = kappa1and2_est(x, col, r1, r2, nd_t, q, bth=1.5, mul = -.0005, niter=8 )


          clear mu_est; clear kapppa_est; clear kap1; clear kap2;  
    	
	 
      clear lrx1;  clear mom1;
		 
	 [lrx1 mom1] = percent_return(x,1,col,r1,r2, 0, 0, 0, 0)    ;

	 clear lrx;  clear mom ;

	 [lrx mom] = percent_return(x,nd_t,col,r1,r2, 0 , 0, 0, 0)    ;


##  cut of  the highest .1 percentile of data (outlier?)

	 clear thresh; clear lrst;

	 thresh = prctile(abs(lrx),99.9,1) ;
         lrst = lrx(abs(lrx) <= thresh)  ;


##   estimte  kappa  given q

     thetat = 1 / (q-1)  ;
     kptmn = bth / (thetat*nd_t); 
     mutmin = mul*nd_t ; 
     momt = mom(1) ;
     sig1 = mom1(2)  ;

     

    clear mu_est; clear kappa_est ; 
      
    [kappa_est mu_est flg] = kappamuestonly(lrst, momt, sig1, thetat, kptmn, mutmin, niter)  ;


    if(flg < 0)
       kap1 = 0 ;
       kap2 = 0 ;
       return
    endif       
	    
## Compute Fisher erros for kappa_est  ond mu_est nly

         kappa_est = kappa_est/(sig1^2)  ;

         [erbm erbe ermum ermue] = est_mlerrbmuonly(lrx, mu_est, thetat, kappa_est)  ;

	  erbm = erbm *(sig1^2) ;
	  erbe = erbe *(sig1^2) ;

	 if( kappa_est == 0)
           printf(" estimated kappa value is zero\n")  ;
           printf(" large q and/or beta value!!!!\n")  ;
	   return
         endif


## Compute kap12, true kappa_est, mu_est


     clear kap12; 
     kap12 = (momt - mu_est)  ;

     kap2 = kappa_est / (1 + kappa_est * kap12^2)  ;
     kap1 = 2 * kap12 * kap2  ;
	 

 endfunction
