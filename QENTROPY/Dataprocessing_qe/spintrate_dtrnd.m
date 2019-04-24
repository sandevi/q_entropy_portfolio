##Copyright (C) 2012 Sandhya
## 
## This program  detrends sp500 monthly data with 10yr interest rate
## wealth
#  Both the data should be of same interval ie, daily, weekly ----
## Both sp500 & int. rate should start from  and end at the same date (m day yr) 
## Input: stock data and interest rate (short or long)
## Output Detrended stock data


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 9/22/2013

function [ spdtrnd irateint cum_intret] = spintrate_dtrnd( sp, irate)

    
    li = length(irate);
	lsp = length(sp)  ;
	 		
	
	if(abs(irate(1,3) - sp(1,3)) > .01)
       disp('  the starting year of the stock data and int rate dont match')
	   return
	endif
	
	if(abs(irate(1,1) - sp(1,1)) > .01)
       disp('  the starting month of the stock data and int rate dont match')
	   return
	endif
	
	if(abs(irate(1,2) - sp(1,2)) > .01)
       disp('  the starting date of the stock data and int rate dont match')
	   return
	endif
	
	
	
## length of sp500 is >. length of interest rate. Missing data
## in int rate. Interpolate int rate 

    if(li != lsp)  
	
      clear xsp;  
      clear xint;
	
	  aint = zeros(lsp,9)  ;
	  aint(1:li,1:9) = irate ;
	  clear bint  ;
	
		
	  for i = 2:lsp
	    
	     if( abs(sp(i,2) - aint(i,2)) >.01)
		 	 bint = prepad(aint(i:li,:),li-i+2,0) ;
          	 aint(i,1:3) = sp(i,1:3)  ;
			 aint(i,4:9) = 0.5*(irate(i-1,4:9) + irate(i,4:9));
			 aint(i+1:li+1,:) = bint(2:li-i+2,:) ;
			 clear bint;
			 ++li;
		 endif
	  endfor	
	  if(li != lsp)
	    disp(" error in interpolation of intrate ")
		return
      endif
	  
      irateint = aint; 
      
	else
	 irateint = irate;
	 	 
	endif 
	irateint(:,4:9) = (irateint(:,4:9))/(1200*254)  ;
	
## Compute cumulative interest rate
	   	
		clear cum_intret;
        cum_intret(:,4:9) = cumsum(irateint(:,4:9)) ; 
		for i = 4:9
		 cum_intret(:,i) = sp(1,i)*cum_intret(:,i)  ;
        endfor	
	
	  spdtrnd(:,1:3) = sp(:,1:3)  ;
      spdtrnd(:,4:9) = sp(:,4:9) - cum_intret(:,4:9) ;
	  
	  clear aint; clear bint;
	
    endfunction
