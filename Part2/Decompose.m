function [finala,finalo,er] = Decompose(a, n, tol) 
        o = zeros (1,n) ;
        s = zeros (1,n) ;
        finala = zeros (n,n);
         for i = 1 : n 
            o(i) = i ;
            s(i) = abs(a(i,1)) ;
              for j = 2 : n
                if (abs(a(i,j)) > s(i))
                   s(i) = abs(a(i,j))  ;
                end
              end
          end 
               for k = 1 : n-1 
                [o]  =  Pivot(a, o, s, n, k) ;
                  if (abs(a(o(k),k)) / s(o(k)) < tol) 
                     er = -1 ;
					 return ;
                   end
                     for i = k+1 : n 
                          factor = a(o(i),k) / a(o(k),k) ;        
                            for j = k : n
                             a(o(i),j) = a(o(i),j) - factor * a(o(k),j) ;
                            end
                             a(o(i),k) = factor ;
                     end
               end 
if (abs(a(o(n),n) / s(o(n))) < tol)
er = -1 ;
return ;
end 
finalo = o ; 
er = 0 ;
finala =a ;
end