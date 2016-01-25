
function [x] = Subistitute(a, o, n, b) 
          y = zeros (1,n);
          x = zeros (1,n);
          y(o(1)) = b(o(1)) ;
         for i = 2 : n 
            y(o(i) ) = b(o(i)) ;
         for j = 1 : i-1
          y(o(i) ) = y(o(i) ) - a(o(i),j) * y(o(j)) ;
         end
          %y(o(i)) = sum ;
         end 
        % x(n) = y(o(n)) / a(o(n),n) ;
         for i = n :-1 : 1 
        % sum = 0 ;
        x ( i ) =  y(o(i)) / a(o(i),i) ;
          for j = i+1 : n
           %sum = sum + a(o(i),j) * x(j) ;
            x ( i ) =  x ( i ) -  ((a(o(i),j) * x(j))/ a (o(i),i)) ;
          end
           %x(i) = (y(o(i)) - sum) / a(o(i),i) ;   
         end
        % fA = a ;
end






