## Copyright (C) 2017 sandhya Devi
##


## This pgm  estimates risk. The risk measures are Tsallis q-gaussian entropy,
##  Kullback-Liebler entropy, beta (CAPM) and relative standard deviation.
## 
## Input: 
## refdat:  Reference data file name (csv file, given as a string, extension incuded.)
## st_dir:  Directory containg  Stock data for risk computation.
##
## col:  column no. to be used for risk measure estimation 
##
## mm1, dd1, yr1: the month , day and yr for starting the calculation.
##

## nd_b: data over nd_b days prior to the starting date are used for
## risk measure estimation.


##Output

## cr: The cell containing the values of risk measures

 
## Author: Sandhya devi
## Created: 2017-09-08
## 

function [ ticker cr ] = ganesh(ref_file, stk_dir,  col, mm1, dd1, yr1, nd_b, nd_est)
##
##
    clear cr;

##  Read reference stock data

    clear a; clear fid;
    fid = fopen(ref_file,"rt")  ;

##  Open file for output


    a = textscan(fid, '%d-%d-%d, %f %f %f %f %f %f', 'Delimiter',',', 'CollectOutput',1, 'HeaderLines',2);

    fclose(fid);

    clear mt; clear md;  

     mt = a{1} ;
     md = a{2}  ;
    
    ref_dat = zeros(length(mt),9) ;
    ref_dat(:,1:3) = mt;
    ref_dat(:,4:9) = md ; 

    clear refd;

##  Remove NaNs and zero returns from the data 
	 sd = 2.2077e-310  ;
	 [refd] = data_process(ref_dat, col, sd)  ;


## check if enough smpls are available for estimation
 
       
	check_dat = julian(refd(1,1),refd(1,2),refd(1,3));
        check_start = julian(yr1,mm1,dd1)  ;

        if(check_start - check_dat < nd_b)
         printf(" Error! Not enough samples prior to today for risk estimation \n") ;
	 printf(" Get the reference data from an earlier date \n") ;
          flgx = -1  ;
	  return
        endif



## get the date for data  nd_b smpls. earlier


        ind_today = ([ yr1  mm1  dd1 ])  ;
	
        clear idx; clear idx0 ;

        idx = find(refd(:,1) == yr1 & refd(:,2) == mm1 & refd(:,3) == dd1) ;

	if(isempty(idx))
	  printf(" ERROR!! The given present date is not in the reference data!!!\n") ;
          return
        endif

	idx0 = idx - nd_b ;
	ind_start = [refd(idx0,1) refd(idx0,2) refd(idx0,3)]  ;


	clear refx ;
        [refx flg] = data_start_align(ind_start, refd)  ;

	 if (flg != 0)
            printf(" no stock data for today's date! \n")  ;		 
            return
         endif
	
        clear refd  ;
	refd = refx ;
	
	r2 = nd_b  ; r1 = r2 - nd_b + 1 ;

##  Estimate Tsallis parameters q from 1 day % returns every dyr years 

    
     [d cmom cparm] = tsallisq_mu(refd, col, r1, r2, 1)  ;
	 
	  a = cell2mat(cparm);
	  mom = cell2mat(cmom);
	  sg1 = mom(2) ;
          q = a(1,4) ;
     

##   Estimate kappa1 and kappa2 for reference data using nd_est days returns

     clear mur_est; clear kapr_est; clear kapr12;  

     [ kapr1 kapr2 mur_est kapr_est flg] = kappa1and2_est(refd, col, r1, r2, nd_est, q)   ;


##     printf(" kapr1 kapr2 mur_est kapr_est %f %f %f %f\n", kapr1, kapr2, mur_est,kapr_est )  ;

     clear ref_parms;
     [ref_parms] = [ kapr1 kapr2 mur_est kapr_est] ;

## Compute relative risk vs relative percentage return every
## nd_t up to nd_t*num_turnovers*nd_t days


     [ ticker cr] = risk_datain(ref_parms, refd, stk_dir, col, ind_start, sd, r1, r2, nd_b, nd_est, q ) ;



 
endfunction
