%% Polak: Computational methods in optimization; Str 32, Algoritam 16

function x = Gradient_method_s(A, J, gradJ, x0 )
 x = x0;
 k = 0;
 printf("Gradijentna metoda uz jednostavne iteracije...\n");
 if norm(gradJ(x)) < eps
  printf('broj iteracija Gradijentne metode: %d\n', k);
  return;
 end 
 A_inv = inv(A);
 epsilon = 1;
 lambda0 = 1e-1;
 while norm(gradJ(x)) > 1e-4
  s  = - A_inv*gradJ(x);
  x_new = x + lambda0*s;
  if J(x_new)<J(x) 
    x = x_new;
    lambda0 = lambda0*2; 
  else
    lambda0 = lambda0/2;
  endif 
  if k>50
    printf('\nbroj iteracije Gradijentne metode uz jednostavne iteracije: %d\n',k);
    break;
  endif
  k = k + 1;
 end
 
end