##Copyright (C) 2012 Sandhya
## 
## This program computes Tsallis (given q)and Shannon relative entropies. 
## Input:
##
## x: reference data
## y: data whose rel entropy need to be measured
## fac: factor that determines the no. of bins for histogram
## q: Tsallis q parameter
## Output:
## 
## qrelent: Tsallis Relative Entropy
## shent:   Shannon Relative Entropy

## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 04 -04-2017

function [  qrelent shrelent ]  = relentropy(x, y, fac, q)

     clear qrelent; clear shrelent;


     clear hsx; clear hsy; clear hsxy; clear xy; clear dxy;


##   Normalise both distributions 


     [hsx xy nb dxy] = mypdf(x, fac, 0, 0)  ;

##  extract hsx at same values as hsy      

      [hsy xy] = hist(y, xy)  ;



      clear norm ; 
      norm = sum(hsx);

##   Compute relative distribution

     hsxy = hsy ./ hsx  ;

##   remove Nan's and Inf's from hsxy

    
## Compute relative q-entropy

    clear crosq_xy ; clear hsxyq ;
    hsxyq =  (((hsxy).^(q-1))-1) / (q-1) ;
    qrelent = (sum((hsy/norm) .* hsxyq)) ; 
   
  

## Compute Shannon Entropy

   shrelent = sum ((hsy/norm) .* mylog(hsxy))  ;
  

endfunction
