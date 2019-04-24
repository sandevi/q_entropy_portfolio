
function fk = func_kappath(kpa)

   global x2;
   
   clear y2; clear mxy2; clear ly2;



     y2 = ( 1 .+ kpa *  x2 )  ;
     mxy2 = mean(kpa*x2 ./ y2);
     ly2 =  mean(log(y2)) ;


     clear thk ;
     thk  = 0.5 ./  mxy2   ;

     g1 = digamma2(thk) - digamma2(thk-0.5)  ;

   
     fk = g1 - ly2  ;

##     printf(" kpa, fk  %f  %f\n", kpa, fk)  ;

endfunction  
