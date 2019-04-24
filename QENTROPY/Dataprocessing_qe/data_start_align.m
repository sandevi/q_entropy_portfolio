## Copyright (C) 2018 sandh
## 
## -*- texinfo -*- 
## this function aligns the the reference data with the given starting date.
##

## Author: sandh <sandh@DESKTOP-J16R45C>
## Created: 2018-01-06

function [refx, flgx] = data_start_align(ind_start, refd)
##
##
    clear refx ; flgx = 0 ;
    
       ind_ref =  [ refd(1,1), refd(1,2),refd(1,3) ]  ;

        sf =  ind_ref .- ind_start ;
	

	k= 1 ;
	while any(sf)
	    ++k ; 
	   ind_ref =  [ refd(k,1), refd(k,2),refd(k,3) ]  ;
           clear sf; 
	   sf = ind_ref .- ind_start;
	   if (any(sf) == 0)
            break		  
           endif 
	endwhile	
	
	l1 = length(refd)  ;
	
	clear refx ;
	refx = refd(k:l1,:)  ;

endfunction
