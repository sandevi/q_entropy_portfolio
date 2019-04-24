## Copyright (C) 2017 sandhya Devi
##

function [ ticker cr ] = risk_datain(ref_parms, refd, stk_dir, col, ind_start, sd, r1, r2, nd_b, nd_est, q)



##Output

## cr is the cell containing the istock ticker symbol and values of risk measures 
 

## Author: Sandhya Devi <sandh@ASUS-2013>
## Created: 2017-05-08
## 
##
 
    clear cr;  clear ticker  ;


##  Compute risk parametes wrt to refdat 	

     count = 0 ;
     count_stknum = 0  ;
     count_rej = 0;  

     clear flcsv ;

     flcsv = dir(stk_dir) ;

     for i = flcsv'
	     
        ++count_stknum  ;

## load data for which relative entropies have to be computed

     flname = i.name;

     warning ('off', 'Octave:data-file-in-path')

     clear dati ; clear tkr;


     [tkr dati] = csvdatard1(flname)  ;


##   check that the data starts from or earlier than mm1 dd1 yr1

     ind2 =  [ dati(1,1) dati(1,2) dati(1,3) ]  ;
        	
     flg = 1  ;
    
     check1 = julian(ind2(1), ind2(2), ind2(3)) ;
     check_start = julian(ind_start(1), ind_start(2), ind_start(3)) ;

     
     if(check1 > check_start)
	  printf(" Warning! The start date of equity  %s\n", tkr) ;
	  printf(" is later than the start date for estimation %d %d %d\n", ind_start) ;
          flg = -1;
	  ++count_rej ;
     

     else

##  Throw away stks that have nulls

       clear dat2;
       dat2 = data_process(dati, col, sd)  ;

       if(length(dat2) < (length(dati) - 4))
	  flg = -1  ;   
          ++count_rej ;
	  printf(" stkno,  input length, output length = %f %f %f\n",count_stknum, length(dati),length(dat2)) ;
       endif


     endif


    if( flg > 0)

##  Align the data with ind_start

       clear datx; clear flg1 ;
       [datx flg1] = data_startdate_align(ind_start, dat2)  ;

       if(flg1 < 0)
          ++count_rej ;
	  printf(" no match  for start date") ;
	  printf(" equity   = %s\n", tkr)  ;
       endif	  
     

       if(flg1 > 0)

        flg2 = 1 ;
        if(length(datx) < (length(refd) - 4))
	  flg2 = -1  ;   
          ++count_rej ;
	  printf(" stk,  Reference stk length, equity length = %s %f %f\n",tkr, length(refd),length(datx)) ;
        endif

	 if(flg2 > 0)
	       
  
       clear dat2;
       dat2 = datx ;

	 
        clear x1;
	clear x2 ;

         x1 = refd;
	 x2 = dat2;


##   Compute q_relative entropy, Shannon relative entropy, relative return and stock beta


       flg3 = 0 ;
       [qrelent_analytic shrelent_analytic stk_bet sigpr flg3] = risk_estimate(ref_parms, x1, x2, col, r1, r2, nd_est, q)  ;

       if(flg3 == 0)
	  ++count ;
	 ticker(count,:) = tkr ; 
	 cr(count,:) =   [ qrelent_analytic shrelent_analytic stk_bet sigpr ]  ;

       endif	 
     
      endif

     endif

   endif  

	 
endfor

 printf(" No. of equities rejected  %f \n", count_rej)  ;

endfunction
