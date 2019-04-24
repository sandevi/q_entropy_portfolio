
function fk  = fkappa( kpa)

   global x2 ;
   global th ;




    clear y2; 

    y2 = 1. + kpa .* x2  ;

    mxy2 = kpa* mean(x2 ./ y2 )  ;

    thf = 2.0 * mxy2  ;

    fk = th - thf  ; 

endfunction  
