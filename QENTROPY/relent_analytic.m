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



## Author: sandh <sandh@DESKTOP-J16R45C>
## Created: 2018-04-28
## 
## This program computes the analytic expressions of  Tsallis (given q)
## and shannon relative entropies. 
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

function [qrelent_analytic shrelent_analytic] = relent_analytic(q, kapr_est, mur_est, momr, kapp_est, mup_est, momp)


     clear qrelent_analytic; clear shrelent_analytic; 

    

## Compute gampr = (kapr_est/kapp_est)^.5

    alf = 1 ./ (q-1)  ; 

    clear gampr; clear gamq ;
##    gampr = (kapp_est/kapr_est)^(.5)   ;

    gampr = (kapr_est/kapp_est)^(.5)   ;
    gamq = (gampr)^(1-q)  ;

    term1 = -qlog(gampr, q);
    term2 = .5*gamq * (gampr^2 - 1)  ;
    term3 = gamq*(alf - .5)*kapr_est* (mup_est- mur_est)^2  ;

    
    qrelent_analytic = term1 + term2 + term3  ;


## Compute Shannon relative entropy

##   gam_sh = momr(2) / momp(2)  ;
   gam_sh = momp(2) / momr(2)  ;
   
   term1_sh = -log(gam_sh)  ;
   term2_sh = .5*(gam_sh^2 - 1)  ;
   term3_sh = .5*((momr(1) - momp(1))/momr(2))^2 ;


   shrelent_analytic = term1_sh + term2_sh + term3_sh   ;


endfunction
    
