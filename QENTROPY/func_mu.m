##Created by Sandhya Devi 6-20-2016


function fb = func_mu(mua)

   global yt;  global kp; global sg ; 
   
   clear x0; clear y0; clear xst ; clear p; clear pwt;


    clear mxy1 ;  clear mxy2;


     x0 =  (yt-mua) /sg   ;

     y0 = 1 .+ kp * x0 .* x0  ;
     
     mxy1 = mean(1 ./ y0);
     mxy2 =  mean( yt ./ y0 )  ;


     fb =  mxy1 * mua - mxy2   ;

##     printf(" mua, fb  %f  %f\n", mua, fb)  ;

endfunction  
