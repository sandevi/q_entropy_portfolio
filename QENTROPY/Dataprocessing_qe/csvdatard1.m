## Copyright (C) 2017 sandh
## 

##
function [tkr dat_out] = csvdatard1(flname)

      clear dat_out ; clear tkr;


## load data for which relative entropies have to be computed

        clear fid ; clear a; 

	     	fid = fopen(flname, 'rt') ;
## create ticker symbol of same length

     tk = fgets(fid) ;
     clear xtk;
     xtk = substr(tk, 18, -7) ;
     clear tkr;
     tkr = '     '  ;
     tkr(1:length(xtk)) = xtk;

a = textscan(fid, '%d-%d-%d, %f %f %f %f %f %f', 'Delimiter',',', 'CollectOutput',1, 'HeaderLines',1);
fclose(fid);

    clear mt ; clear md ;
    mt = a{1} ;
    md = a{2}  ;

    dat_out = zeros(length(mt),9) ;
    dat_out(:,1:3) = mt;
    dat_out(:,4:9) = md ;

	   
endfunction
