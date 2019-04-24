##Copyright (C) 2012 Sandhya
## 
## This program computes the  slope and intercept for a linear fit of the data
## No fit is done if the no. of points is less than 20
## x,y  = input data 
## slp and icept are the slope and intercept respectively
 

## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-01-20

function [p xtest ytest] = linfit(x,y)


   clear p; 
   
   p = polyfit(x,y,1);

##  Check the error

   yr = polyval(p,x)  ;
   err = mean(abs(yr .- y))  ;
   err2 = sqrt(var(yr .-y)) ;


##  Check the goodness of the fit
   
   xtest = linspace(min(x), max(x),length(x)); 
   ytest  = polyval(p,xtest);

   

   
