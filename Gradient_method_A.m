%% Polak: Computational methods in optimization; Str 36, Algoritam 35

function x = Gradient_method_A (A, J, gradJ, x0 )
 x = x0;
 k = 0;
 printf("Gradijentna metoda Armijo...\n");
 if norm(gradJ(x)) < eps
  printf('broj iteracija Gradijentne metode: %d\n', k);
  return;
 end 
 A_inv = inv(A);
 rho = 1;
 alpha = 0.5; % alpha \in (0, 0.5) %0.5
 beta = 0.7; % beta \in (0.5, 0.8) %0.7
 while 1 
  s  = - A_inv*gradJ(x);
  if norm(s, 2) <= 1e-4 || k>30
    k = k + 1;
    printf('broj iteracija Gradijentne metode Armijo: %d\n', k);
    break;
  end
  g  = @(lambda) J(x + lambda*s) - J(x) - lambda*alpha*gradJ(x)'*s; 
  lambda0 = rho;
  l = 0;
  while g(lambda0) > 0 && l<50
    lambda0 = beta*lambda0;
    l = l + 1;
  endwhile
  lambda0
  x = x + lambda0*s;   
  k = k + 1;  
 end
 
end

