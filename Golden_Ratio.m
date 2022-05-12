%% Polak: Computational methods in optimization; Str 31, Algoritam 14

function x = Golden_Ratio (g, rho, epsilon)
  F1 = 0.38; F2 = 0.68;
  if(g(0) <= g(rho))
     a = 0; b = rho;
  else
     i = 0; c = 0;
     while g(c) > g(c + rho)
       c = c + rho;
       i = i + 1;
     endwhile
     b = c; a = c - 2*rho;
  endif
  j = 0; l = b - a;
  while l > epsilon && j<2
    v = a + F1*l; w = a + F2*l;
    if g(v) < g(w)
      b = w;
    else
      a = v;
    endif
    l = b - a;
    j = j + 1;

  endwhile
  x = (a + b)/2;
endfunction
