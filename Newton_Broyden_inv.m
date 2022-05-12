function x = Newton_Broyden_inv(f, df, x0)
  y0 = f(x0);
  S = eye(max(size(x0)));
  k = 0;
  S = inv(df(x0)); 
  printf("Newton-Broyden-inv metoda...\n");
  while 1
    d = S*y0;
    x = x0 - d;
    y = f(x);
    S1 = S;
    A = -d-S*(y-y0);
    A = A*(-d)'*S;
    A = A./( (-d)'*S*(y-y0) );
    S = S + A;
    if norm(f(x), 2)<1e-4 || k>2
     k = k + 1;
     printf('broj iteracija Newton-Broyden-inv: %d\n', k);
     break;
    else
     x0 = x;
     y0 = y;
     k = k + 1;
    end
  endwhile
endfunction
