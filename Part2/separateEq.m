function [ symbols,Coef ,flag] = separateEq( eq)

flag = 1 ;
spl=split(eq);
Coef = zeros(1,length(spl));
symbols={};
idx=1;
for i=1:length(spl) ;
    
    term = spl{idx};
    isNum = isstrprop(term,'digit');
    tempCoef='';
    tempSymb='';
    getCo=1;
    for j=1:length(term) ;
        
        if( getCo==1 && (isNum(j)==1 || term(j)=='-' || term(j)=='.'))
            tempCoef = strcat(tempCoef,term(j));
        else
            getCo=0;
            tempSymb = strcat(tempSymb,term(j));
        end 
    end

    if(tempCoef=='-')
        tempCoef='-1';
    end   
    Coef(idx)=str2double(tempCoef);
    if(isnan(Coef(idx)))
         if(~(length(tempCoef)==0))
                flag = 0 ;
                Coef= 0;
                return ;
         end
        Coef(idx)=1;
    end
    symbols{idx}=tempSymb;
    
    if(length(symbols{idx})==0)
        symbols{idx}=' ';
    end
    idx = idx + 1 ;
 
end

end

