function [Xi,time,er] = LUDecomposition(a, b, n, tol) 
  tic ;
 [A,o,er] = Decompose(a, n, tol) ;
  if (er == -1) 
    time = toc ;
    return ;
  end 
  %finalo = o;
  [Xi] = Subistitute(A, o, n, b) ;
  time = toc ;
end
