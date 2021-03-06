function [xi,ei , conv, time ] = fbisection( func ,x1,x2 ,es,maxit )
    f=eval(strcat('@(x)',func));
    tic; 
    if( f(x1) == 0)
        conv = 1 ;
        time = toc;
        xi(1) = x1 ;
        ei(1) = 0 ;
        return
    elseif(f(x2) == 0)
        conv = 1 ;
        time = toc;
        xi(1) = x2 ;
        ei(1) = 0 ;
        return 
    elseif(f(x1)*f(x2) >0)
      %  disp('there is no root in the interval given');
        conv  = 0 ;
        time = toc;
        xi(1) = 0 ;
        ei(1) = 0 ;
        return 
    end 
    it = 0 ;
    xr=0;
   
    while(1)
        it = it + 1 ;
        lastXr = xr;
        xr = (x1+x2)/2 ;
        ea = abs((xr -lastXr)/xr)  ;
        xi(it) = xr ;
        ei(it) = ea ;
        z = round(xr);
            
        if(f(xr) == 0)
           % display('exact root !'); 
            conv = 1 ;
            time = toc ;
            return ;
        elseif(abs(f(z)) == inf)
            conv = 0 ;
            time = toc ; 
            return ;
       
        elseif(f(x1) * f(xr) < 0)
            x2 = xr ;
        else
            x1 = xr ;
        end 
        if(f(xr) * f(x1) == 0)
            ea= 0;
        end
        if(ea <= es && it >= maxit)
            conv = 1 ;
            break ;
        elseif(ea > es && it >= maxit)
             conv = 0  ;
             time = toc ;
             break ;
        end  
    end
    time = toc;
    e(1)=1;
end

