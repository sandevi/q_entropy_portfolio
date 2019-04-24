##Copyright (C) 2012 Sandhya
## 
## This program  detrends sp500 monthly data with CPI
##  The length of output ret is the minimum of cpi and monthly sp data


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2013-04-04

function [ ret ] = spdtrnd(sp, cpintercept, col,r1,r2)

    l = length(sp);

   clear ret ;
##
##
    
    clear tim;
    clear x;

    x = sp(:,col) ;

    for i = 1:l
       tim(i,1) = i;
    endfor;

    tim2 = tim.*tim  ;
    dtim = x.*tim  ;

    d = sum(x)/l  ;
    t = sum(tim)/l  ;
    dt = sum(dtim)/l  ;
    t2 = sum(tim2)/l  ;

    a = (dt - d*t)/(t2 -t*t)  ;
    b = ( dt*t - d*t2)/(t2 - t*t)  ;
    b = b - cpintercept ;
    ret = a*tim + b  ;

	
    clf(1)  ;
    figure(1);
	
    plot(tim,ret)

endfunction
