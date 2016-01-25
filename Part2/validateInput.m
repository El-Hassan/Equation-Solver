function [valid,eqs]  = validateInput(in)

    valid = 1 ;
    eqs={};
    idx=1;
    equal = 0 ;
    temp = '' ;
    for i=1:length(in) ;
       
        if(in(i)==',')
            if(equal==0)
               eqs=0;
               valid=0;
               return ;
            end
            eqs{idx} = temp;
            temp = '' ;
            idx = idx +1 ;
            equal = 0 ;
            continue ;
        elseif ((in(i)=='-' ||in(i)=='+')&& (in(i-1)=='-' || in(i-1)=='+' ) )
            eqs=0;
            valid = 0;
            return ;    
        elseif(in(i)=='=')
            if(equal>0 || (i>1 && (in(i-1)=='-' || in(i-1)=='+' )))
                eqs=0;
                valid = 0;
                return ;
            end
            equal = 1 ;
        elseif(i>1 && in(i)=='.' && in(i-1)=='.')
            eqs=0;
            valid = 0;
            return ;
        elseif(equal==1 && ( (~(in(i)=='-' || in(i)=='.')&&isnan(str2double(in(i))))||(in(i)=='-' && ~(in(i-1)=='=') ) ) )
            eqs=0;
            valid = 0;
            return ;
        end
        
        temp = strcat(temp,in(i));
    end
    eqs{idx} = temp ;
    if(equal==0)
           eqs=0;
           valid=0;
    end
