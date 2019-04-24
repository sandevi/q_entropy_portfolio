## Copyright (C) 2017 sandh
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
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
## @deftypefn {Function File} {@var{retval} =} stockbeta (@var{input1}, @var{input2})
##
## This function computes the beta of a stock series w.r.t a reference time
## series such as S&P500
## Beta is defined as cov(data1,data2) / var(data1)
##
##Input:
##  data1: data1reference data series
##  data2: Stk for which beta needs to be computed
##
##  Note: data1 and data2 should be of same length
##
##Output:
##  stk_beta: beta for data2
##
## Author: Sandhya Devi (sandhya.r.devi@gmail.com)
## Created: 2017-04-29   

## @seealso{}
## @end deftypefn


function [stk_beta] = stockbeta(dat1, dat2)

 
    clear stk_beta ;

    stk_beta = cov(dat1,dat2) / var(dat1)  ;
   
  

  
endfunction  
