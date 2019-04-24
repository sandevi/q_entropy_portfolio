##Copyright (C) 2012 Sandhya
## 
## This program  detrends sp500 monthly data with CPI
## The CPI data is monthly. The first entry in CPI should be one month 
## earlier than the month in the first entry of stock data.
## The month & year of the second row of cpi data shold be the same as the 
## month & year of the first row of stock data
## The month & year of last row of stock data should be the same as the 
## month and year of the last low of cpi data 
## The no. of days in the last momth should be at least 20 days long
##
## Input: stock data and cpi monthly data
## Output Detrended stock data


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 9/22/2013

function [ ret retcpint] = spcpidtrnd(dat, cpi_in)

     clear cpi; clear sp;
	 
    [cpi sp] = cpi_format(cpi_in, dat)  ;

	lc = length(cpi);
	lsp = length(sp)  ;
	
	clear ret ;
	clear retcpint ;
	
	if(lc < 2)
	   disp(' length of cpi data should be at least 2')
	   return
	endif
	
	if(abs(cpi(2,2) - sp(1,3)) > .01)
       disp('  the starting year of the stock data and cpi dont match')
	   return
	endif
	
	if(abs(cpi(2,1) - sp(1,1)) > .01)
       disp('  the starting month of the stock data and cpi dont match')
	   return
	endif

##
    clear tim;
 	clear xi;
	clear cpintrp ;
	
	iy = 1  ;
	im = 2  ;
	id = 0  ;
	
	for i = 1:lsp-1
	
	  if(abs(sp(i+1,1) - sp(i,1)) < .001)
	     id = id + 1;
	  else	
	  
##  interpolate monthly cpi to daily values
	  
         id = id + 1  ;
         xi = (1:id) ;
         tim(1) = 0 ;
		 tim(2) = id  ;
		 cm = cpi(im-1:im,3) ;
         cmi = interp1(tim,cm,xi)  ;
         cpint(iy:iy+id-1) = cmi  ;
		 
		 iy = iy + id  ;
		 im = im + 1  ;
		 id = 0  ;
		 
		 clear xi;
		 clear cmi;
		 
	  endif	 
	endfor  
	
##  Handle the last part of the data	
	
	     id = id + 1  ;
		 if (id > 10)
           xi = (1:id) ;
           tim(1) = 0 ;
	       tim(2) = max(20,id)  ;
		   cm = cpi(im-1:im,3) ;
           cmi = interp1(tim,cm,xi)  ;
           cpint(iy:iy+id-1) = cmi  ;
         endif
		
        lint = length(cpint)  ;
##  Detrend the data	
         disp(' length of data and length of cpint = '); disp(lsp); disp(lint); 
   	
	if( abs(lsp - lint) > .01)
	   disp(' length of stock data and that of interpolated cpi do not agree')
	   disp(' check the conditions (see info) of the data')
       return
    endif
	
	spcp = sp(1:lint,:)  ;
	spcp(1:lint,4) = sp(1:lint,4) - reshape(cpint,lint,1) ;
	spcp(1:lint,5) = sp(1:lint,5) - reshape(cpint,lint,1) ;
	spcp(1:lint,6) = sp(1:lint,6) - reshape(cpint,lint,1) ;
	spcp(1:lint,7) = sp(1:lint,7) - reshape(cpint,lint,1) ;
	spcp(1:lint,9) = sp(1:lint,9) - reshape(cpint,lint,1) ;
	ret = spcp;
    retcpint = reshape(cpint,lint,1)  ;  	
	
    endfunction
