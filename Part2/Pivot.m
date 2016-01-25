function [finalo] = Pivot(a, o, s, n, k) 
            p = k ;
           big = abs(a(o(k),k)) / s(o(k)) ;
            for i = k+1 : n 
               dummy = abs(a(o(i),k) / s(o(i)));
                 if (dummy > big) 
                    big = dummy;
                    p = i;
                 end
            end
          dummy = o(p);
          o(p) = o(k);
          o(k) = dummy;
		  finalo = o ;
end