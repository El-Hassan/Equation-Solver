function [ pieces ] = split( string )

    idx=1;
    pieces ={};
    pieces{1}='';
    for i=1:length(string) ;
            num = 1;
            if(string(i)=='+'||string(i)=='=')
                num=0;
                idx =idx+1;
                pieces{idx}='';
            elseif(string(i)=='-'&& i>1 )
                if(~(string(i-1)=='='))
                       idx =idx+1;
                end
                num=0;
                pieces{idx}='-';
           end
    
        if(num==1)
            pieces{idx}=strcat(pieces{idx},string(i));
        end
    end
     


end

