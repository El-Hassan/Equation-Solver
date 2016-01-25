    function [matrix,unknowns,ordered] = getMatrix(eqs,directive) % 0->a  , 1->b  , 2-> Aug

    ordered = 1 ;
    [unknowns,coef,flag] = separateEq(eqs{1});
    if(flag==0)
            ordered = -2;
          matrix(1,1) = 0;
          return;
    end
    for i=2:length(eqs) ;
        [symb,coef,flag] = separateEq(eqs{i});
        if(flag==0)
            ordered = -2;
          matrix(1,1) = 0;
          return;
    end
        unknowns= mergeUnknowns(unknowns,symb);
    end
    
    if((length(unknowns)-1) > length(eqs))
          ordered = -1;
          matrix(1,1) = 0;
          return;
    end
            
     idxStatic = 1;   
     toUnknowns =length(unknowns); 
     if(directive==0)
            toUnknowns = toUnknowns -1 ;
     elseif(directive == 1)
         idxStatic = length(unknowns);
     end
     
    for i=1:length(unknowns)-1 ;
        [symb,coef] = separateEq(eqs{i});
        idx = 1;
        idxUn = idxStatic ;
        toSym = length(symb) ;
        fromSym = 1;
        if(directive==0)
            toSym  = toSym -1 ;
        elseif(directive==1)
            fromSym = length(symb);
        end
        
        
        for j= fromSym:toSym ;
            while( idxUn <= toUnknowns & (~strcmp(symb{j},unknowns{idxUn})))
                matrix(i,idx)=0;
                idx= idx +1  ;
                idxUn = idxUn+1;
                 
            end
            
            if(idxUn > toUnknowns )
                ordered = 0 ;
                matrix(1,1) = 0;
                return;
            end
            matrix(i,idx) = coef(j);
            idx = idx + 1 ;
            idxUn = idxUn+1;
           
        end
    end
    






