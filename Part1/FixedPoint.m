function [x,itrations,timeElapsed,prec,flag] = FixedPoint(fun,Maximumiterations,x0,es)
    
    f=eval(strcat('@(x)',fun)); 
    ea = zeros (1,Maximumiterations); 
    ea(1) = 1;    % approximate error at each step array
    i = 1;
    x = zeros (1,Maximumiterations);
    x(1) = x0;     % Xi array
    flag = 1 ;
    tic;
    while( i<=Maximumiterations && ea(i)>es )
        i = i+1;
        x(i) = f(x(i-1));
        ea(i) = abs(abs(x(i) -x(i-1) )/x(i));
         if(x(i)==inf)
            flag=0;
            break;
         end
         if(f(x(i))==0)
             % not sure about this it's in the lecture but doesn't make sense
            break;
        end
    end
    timeElapsed = toc;
   % Xi = x;
    itrations = i;
	prec = ea;
end

