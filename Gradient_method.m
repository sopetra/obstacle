function x = Gradient_method ( A, gradJ, hessJ, x0)
 x = x0;
 k = 0;
 printf("Gradijentna metoda...\n");
 if norm(gradJ(x)) < eps
  printf('broj iteracija Gradijentne metode: %d\n', k);
  return;
 end 
 A_inv = inv(A);
 while 1 
  s  = - A_inv*gradJ(x);
  g  = @(lambda) gradJ(x + lambda*s)'*(s);
  dg = @(lambda) (s)'*hessJ(x + lambda*s)*(s);
  lambda0 = Newton_search(g, dg, 0); 
  x = x + lambda0*s;
  if norm(gradJ(x)) <= 1e-4 || k>10 
    k = k + 1;
    printf('broj iteracija Gradijentne metode: %d\n', k);
    break;
  end 
  k = k + 1;
 end
 
end
        