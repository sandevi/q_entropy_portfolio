##Created by Sandhya Devi
## 3-15-26
##
 
function [d cmom cparm]  = tsallisq_mu(x, col=8,r1 , r2, delay=1, fac0=0, ql=1.2, qh=1.66, btl=.5, bth=1.5, mul = -.0005, niter=8)


    clear kapt;  clear thetat; clear mut; clear qent; clear shnent ;
    clear betat; clear qt;
	
	 
      clear lrx; clear lrst; clear mom1;
		 
	 [lrx mom1] = percent_return(x,delay,col,r1,r2, 0, 0, 0, 0)    ;

##  cut of  the highest .1 percentile of data (outlier?)

	 clear thresh; 
	 thresh = prctile(abs(lrx),99.9,1) ;
         lrst = lrx(abs(lrx) <= thresh)  ; 
		 
## cut of the lowest 5 percentile of the data for kappa estimation(noise) 
## and lowest 25 percentile for q estimation

	 clear thresh_th; clear thresh_kp;

	 thresh_th = prctile(abs(lrst), 20,1)  ;
         thresh_kp = prctile(abs(lrst), 5,1)  ;
	 
## compute the lower and upper limits of theta and kappa

         thh = (qh - 1)  ;
	 kptmin = thh*bth  ;
	 mutmin = mul*delay;
	 momt = mom1(1);
	 sig1 = mom1(2) ;
	   

	 
	 [thetat kapt mut ] = estkpthmu_mle(lrst, mom1(1), mom1(2), thh, kptmin,mutmin , niter)  ;


         if( thetat == 0 )
           printf(" estimated theta value is zero\n")  ;
           printf(" large q value!!!!\n")  ;
	   return
	 elseif( kapt == 0)
           printf(" estimated kappa value is zero\n")  ;
           printf(" large q and/or beta value!!!!\n")  ;
	   return
         endif

## Compute fisher measured and expected error

         [erqm erbm  ermum erqe erbe ermue] = est_mlerrqbmu(lrx, mut, thetat, kapt, mom1(2))  ;

	 
         qt =  (1 / thetat) + 1 ;
	 betat = kapt* thetat ;

	 
## store the output parameters in a cell array 	
   
	clear cmom; clear cparm; clear d;

	d{1} = ("i2 = moment, ci1-5 = interval,q,beta")  ;
	d{1,2} = ( "i = 1 - n_wks")  ;

	cmom{1,1} = mom1;
	cparm{1,1} = [thetat kapt mut qt betat  erqm erbm ermum erqe erbe ermue] ;
         	
	  
 endfunction
