function x = Newton_Broyden (f, df, x0)
  y0 = f(x0);
  S = df(x0); 
  k = 0;
  printf("Newton-Broyden metoda...\n");

  while 1
    d = -S\y0;
    x = x0 + d;
    y = f(x);
    S1 = S;
    S = S + y*d'/(d'*d);
    nrm = norm(x-x0,2);
    if norm(f(x), 2)<1e-4
     k = k + 1;
     printf('broj iteracija Newton-Broyden: %d\n', k);
     break;
    else
     x0 = x;
     y0 = y;
     k = k + 1;
    end
  endwhile
endfunction
