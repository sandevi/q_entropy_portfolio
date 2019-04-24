##Copyright (C) 2012 Sandhya
## 
## This program computes the first 4 moments
## mean, standard deviation, skew and kurtosis of a vector x
## The output vector mom contains the 4 moments
 

## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-01-20

function [ mom ] = moment4(x)

#  subtract the mean and std dev from x

   clear mom;
   clear xs ;
   xs = x;
  
   
## arithmetic mean 
  
   mom(1) = mean(xs,'a') ;

## standard dev.

   vr = var(xs) ;
   mom(2) = sqrt(vr) ;
   
## Skewness
   
   mom(3) = skewness(xs)  ;

## Kurtosis

   mom(4) = kurtosis(xs)  ;

 
   
