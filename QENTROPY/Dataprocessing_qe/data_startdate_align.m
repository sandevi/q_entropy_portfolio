## Copyright (C) 2018 sandh
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## this function aligns the the reference data with the given starting date.
##

## Author: sandh <sandh@DESKTOP-J16R45C>
## Created: 2018-01-06

function [refx, flgx] = data_startdate_align(ind_start, refd)
##
##
    clear refx ; flgx = 1 ;
    
       ind_ref =  [ refd(1,1), refd(1,2),refd(1,3) ]  ;

        sf =  ind_ref .- ind_start ;
	
        sz = size(refd);

	k= 1 ;
	while any(sf)
	    ++k ;

	    if(k > sz(1))
	      flgx = -1 ;	    
              break
            endif

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
