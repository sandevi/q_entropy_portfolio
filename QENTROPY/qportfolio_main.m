## Copyright (C) 2017 sandhya Devi
##


## This pgm  estimates the 'relative risk' of a portfolio (or individual
## equities) as compared to a market index(ex: S&P 500, Nasdaq----)
## The risks are Tsallis q-relative entropy, Kullback-Liebler relative entropy,
## 'beta' of the Capital Asset Pricing Model and relative standard Deviation.

## The pgm can be used to construct risk optimal portfolios.

## References
## 1.  Financial Market Dynamics: Superdiffusive or not? Sandhya Devi
## Journal Of Statistical Mechanics Theory and Experiment 2017(8)
## DOI: 10.1088/1742-5468/aa8199
## 2.  Financial Portfolios based on Tsallis Relative Entropy as the-------- 
##   arXiv:1901.04945 
##
## Input:
##
## ref_file: Name of the reference file containing index data (preferably daily data) in .csv format
## ex: ref_file = '\fullpath\refdat.csv'


## Directory containing exclusively the individual stocks to be used to
## construct risk optimal portfolios.

## ex: '\fullpath\*.csv' 
##

## The data should have two header followed by data
##
## ex:
##
## Ticker symbol
## date  open  High  Low  Close  Adj_close  Volume
## 1/4/1995 459.209991	459.269989	457.200012	459.109985	459.109985	262450000
## The date is treated as having 3 columns. The data columns are 4 -9
## Any of the data columns 4-8 can be used for the analysis. Default(preferred)
## is 8  since it is adjusted for dividend and splits.
## Also the data should not have 'null' characters in it.
##
## out_path: Name of the directory path to which the output file containing
## risk estimates to be written;
## ex: '\fullpath\' 
##
## mm1, dd1, yr1: month, day, year of the date when investment starts.
## (ex: today's date)
## Note: The risk parameters are calculated for  this date. For this,
## there should be at least 6 yrs  of daily data (both reference and 
## the portfolio equity data) prior to this date. (see reference 2).
##
## nd_est: Portfolio turn over timein days. Default = 66 days (3 mnths)
##
## nd_b: no: of days (samples) to be used for the parameters of Ttsallis
## relative entropy estimation. (min = default 1300 smpls. More the better).
##
## col:  column no. to be used for estimation; The data is assumed to have
## 9 columns, month/day/year open hi low close adj.close volume (default = 8)
##


##Output

## outfile: Text file containing the  equity ticker symbol and the risk values
## for all equities provided.
##
## outfile(columns);  Ticker symbol Tsallis rel. entropy, Kulback-Liebler
## rel. entropy, beta of CAPM, relative standard deviation.
##
##
## Minimal usage
##
##  [ outfil ] = qportfolio_main(ref_file, stk_dir,  mm1, dd1, yr1, nd_est) 
##
## Full usage
##
##  [ outfil ] = qportfolio_main(ref_file, stk_dir,  mm1, dd1, yr1,  nd_est, nd_b,  col)
##
## ## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 3-19-2019
##

function [ outfil ] = qportfolio_main(ref_file, stk_dir, out_path,  mm1, dd1, yr1,  nd_est=66, nd_b=1300, col=8) 

   clock

   clear cr; 

##
    [  ticker cr] = ganesh(ref_file, stk_dir, col, mm1, dd1, yr1, nd_b, nd_est) ;

## sort the equities acoording to the risk parameter Tsolls entropy

     
    clear acr; clear tks ;

    [s id] = sort(cr(:,1),'ascend')  ;
    acr(:,1) = s;
    acr(:,2:4) = cr(id,2:4) ;
    tks(:, 1:5) = ticker(id, 1:5)  ;


## write the ticker and cr values to a file

   outfil = strcat(out_path, 'risk.txt') ;
   fdout = fopen(outfil, 'w')  ;

## Write header

   fprintf(fdout,"%s  %s   %s   %s   %s\n",'ticker','q-rel.ent', 'KL-rel. ent', 'beta', 'rel.sigma');

   lcr = length(ticker) ;
   for i = 1 :lcr
     fprintf(fdout, "%s  %f    %f    %f    %f\n", tks(i,:), acr(i,:))  ;
   endfor

   fclose(fdout)  ;   


    clock
   
endfunction
