## Copyright (C) 2017 sandhya Devi
##

function [qrelent_analytic shrelent_analytic stk_bet sigpr flg] = risk_estimate(ref_parms, x1, x2, col, r1, r2, nd_est, q)

## This pgm  estimates risk measures
## 

## Author: Sandhya Devi <sandh@ASUS-2013>
## Created: 2017-05-08
## 
##
 
    flg = 0  ;
     clear qrelent; clear qrelent_analytic;  
     clear shrelent; clear shrelent_analytic; clear stk_bet ; 


##   Extract reference data parameters

      clear kapr1; clear kapr2

       kapr1 = ref_parms(1); kapr2 = ref_parms(2) ;
       mur_est = ref_parms(3); kapr_est = ref_parms(4)  ;
      
##   Estimate for x2,  kapp1 and kapp2  for nt days  

     clear kapp1; clear kapp2;  


     [ kapp1 kapp2 mup_est kapp_est flg] = kappa1and2_est(x2, col, r1, r2, nd_est, q) ;

    if(flg < 0)
      qrelent_analytic = NaN ;
      shrelent_analytic = NaN ;
      stk_bet = NaN ;
      sigpr = NaN; 
      dat2_ret = 0 ;
      dat2_ret_in = 0;
      return
    endif


##  Compute data rel. entropies

	clear rx; clear ry;

        [rx momntr] = percent_return(x1, nd_est, col, r1, r2, 0, 0, 0, 0) ;
	[ry momntp] = percent_return(x2, nd_est, col, r1, r2, 0, 0, 0, 0) ;


##  Compute relative sigma and risk parameter beta wrt to refdat 	
	
        clear sigpr;

	sigpr = momntp(2) /momntr(2)  ;

	clear stk_bet ;
	
	stk_bet = stockbeta(rx, ry) ;



##     compute reletive q and sh entropies  



      [qrelent_analytic shrelent_analytic] = relent_analytic(q,kapr_est, mur_est, momntr, kapp_est, mup_est, momntp)  ;

      if( abs(imag(qrelent_analytic)) ) > 0
	 flg = -1;
         qrelent_analytic = NaN ;
         shrelent_analytic = NaN ;
	 dat2_ret = 0 ;
	 dat2_ret_in = 0 ;
         return
      endif	 
         	 

 endfunction
