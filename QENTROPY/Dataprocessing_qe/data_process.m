## Copyright (C) 2017 sandh
## 
## Author: Sandhya Devi <sandh@DESKTOP-J16R45C>
## Created: 2017-05-15
##
## This program processes the input stock data for the following.
##
## 1. Remove NaN rows 

## 2. Add a small (~1e-10) random numbers to the adjusted dily close stock data.
## This is to avoid identical values on successive dates. 
##
## Input: 
## dat0: Input stock data
## col:  coumn of data to which noise needs to be added
##
## Output:
## dat_out:  The noise added data without NaN's
##
##
function [dat_out] = data_process(dat0, col, sd)

      clear dat_out ;  


##
## remove NaN's
##
    clear idx;
    idx = find(isnan(dat0(:,col))) ;
   
    if(isempty(idx))
       dat_in = dat0;
    else       
      dat0(idx,:) = [];
      dat_in = dat0;  
    endif  

##
## Add noise (~1e-12) to the data
##
    clear nois; clear dat_nois;

    rand("seed",sd)  ;
    nois = (1e-12)*( rand(length(dat_in),1) - .5) ;
    dat_nois = dat_in(:,col) .+ nois; 
    dat_in(:,col) = dat_nois ;
    
    dat_out = dat_in  ;
	   
endfunction
