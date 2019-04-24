##Copyright (C) 2012 Sandhya
## 
## This program computes the forward percent returns of an equity 'a'
##  tau is the delay; 
## col is the column (month day year, open, high, low, close, volume)
## Default: col = 7
##  r1,r2 are the 1st and last rows to be considered for computation
## Default: r1 = 1
## Default: r2 = length(a) 
## opt:  option to standardise the returns
## Default: opt = 0
## Output: ret: the logreturns at time i for the delay tau: 
## ret(i) = log(a(i) - log(a(i-tau))


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-01-20

function [ ret mom] = percent_return(a, tau, col,r1,r2, thresh_lo, thresh_hi, opt,opt_depop)

     l = length(a);
     clear ret ; clear mom; clear retl;clear x ;

	 if(nargin  == 7)
	    opt = 0;
	 endif
	 	 
	 if( r2 == 0)
	    r2 = length(a); 
	 endif

     if(r1 == 0)
        r1 = 1 ;
     endif

     if(col == 0)
       col = 7  ;
     endif	   

	 
     x = a(:,col) ;    
	 ret = x ;

##
     k = 0  ;
     
     if(opt_depop == 0)

       for i = r1+tau: r2
         k = k + 1;	     
         retl(k) = (ret(i) -  ret(i-tau))/ ret(i-tau) ; 
       endfor
     

     else

       for i = r1+tau: tau :r2
         k = k + 1;	     
         retl(k) = (ret(i) -  ret(i-tau)) / ret(i-tau) ; 
       endfor

     endif   
     

     clear ret;
     ret = retl  ;	 
	 ret = reshape(ret,length(ret),1);
	 clear retl;
##   
   
     clear x;
	 x = ret ;
	 mom = moment4(x) ;

##   Threshold the data

    if(opt == 1)
	
     clear x_limited; clear mom ;
	[ x_limited  mom ] = limit_ret(x, thresh_lo, thresh_hi)  ;
     clear ret;
     ret = x_limited ;

    endif	  
##
  
 endfunction
