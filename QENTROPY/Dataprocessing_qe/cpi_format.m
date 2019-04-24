## Copyright (C) 2017 sandh
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
## @deftypefn {Function File} {@var{retval} =} cpi_format (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: sandh <sandh@DESKTOP-J16R45C>
## Created: 2017-04-15

function [cpi_out dat_out] = cpi_format(cpi_in, dat)

clear cpi_out ; clear dat_out

clear cp2; cp2 = cpi_in(:,2:13);
##
## convert matrix to column vector
##
s = size(cpi_in) ;
ll = s(1) * (s(2) - 1)  ;
cpi1 = zeros(ll,4)  ;
#
kij = 0  ;
for i = 1:s(1)

    for j = 1:12
	
      ++kij;
      cpi1(kij,1) = kij;
      cpi1(kij,2) = j ;
      cpi1(kij,3) = cpi_in(i,1);
	  cpi1(kij,4) = cpi_in(i,j+1)  ;
	  
	endfor
	
endfor

clear cpi_out  ;
[idx idy] = find(cpi1(:,4) > 0)  ;
cpi_out = cpi1(idx,:)  ;
##
## align data and cpi
##

clear dat_in; clear s;
s = size(dat)
dat_in = zeros(s(1), s(2)+1) ;

mn = min(cpi_in(:,1))  ;
for i = 1:length(dat)

        indsp = (dat(i,3) - mn)*12 + dat(i,1)  ;
        dat_in(i,1) = indsp ;
        dat_in(i,2:s(2)+1) = dat(i,:)  ;

endfor
##
## align the first row of data with cpi

clear cpl; clear dath; clear idx; clear idy ;
indspl = dat_in(1,1)  ;
[idx idy]= find((cpi_out(:,1)>= indspl-1)) ;
cpl = cpi_out(idx,:);
clear cpi_out ;
cpi_out = cpl(:,2:4) ;
dath = dat_in  ;
cph = cpl ;
##
## align the last rows of cpi and data
##
indsph = dat_in(s(1),1)  ;
lc = length(cpl)  ;
indcph = cpl(lc,1)  ;

##
if(indcph < indsph)
	clear dath; clear idxd; clear idyd ;
	[idxd idyd] =  find((dat_in(:,1) <= indcph)) ;
	dath = dat_in(idxd,:) ;

elseif(cpl(lc,1) > indsph)
       clear cph; clear idx ; clear idy ;
       [idx idy] = find((cpl(:,1) <= indsph)) ;
       cph = cpl(idx,:) ;
endif       

       clear cpi_out; clear dat_out ;

       cpi_out = cph(:,2:4)  ;
       dat_out = dath(:,2:s(2)+1) ;

endfunction
