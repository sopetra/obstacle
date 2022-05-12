function M = M0 (h, x, fun)
  M = zeros(4,4);
  
  f = @(y) ((y-x)/h-1)^2*(2*((y-x)/h)+1); %fija lijevo
  g = @(y) (3-2*((y-x)/h))*((y-x)/h)^2;   %fija desno
  u = @(y) ((y-x)/h)*(1-(y-x)/h)^2;       %derivacija lijevo
  v = @(y) (-(1-(y-x)/h)*((y-x)/h)^2);    %derivacija desno
  
  F1 = @(y) fun(y).*f(y).*f(y);
  F2 = @(y) fun(y).*f(y).*u(y);
  F3 = @(y) fun(y).*f(y).*g(y);
  F4 = @(y) fun(y).*f(y).*v(y);
  
  M(1,1) = Gauss2(F1,x,x+h);
  M(1,2) = M(2,1) = Gauss2(F2,x,x+h);
  M(1,3) = M(3,1) = Gauss2(F3,x,x+h);
  M(1,4) = M(4,1) = Gauss2(F4,x,x+h);
  
  G1 = @(y) fun(y).*u(y).*u(y);
  G2 = @(y) fun(y).*u(y).*g(y);
  G3 = @(y) fun(y).*u(y).*v(y);
  
  M(2,2) = Gauss2(G1,x,x+h);
  M(2,3) = M(3,2) = Gauss2(G2,x,x+h);
  M(2,4) = M(4,2) = Gauss2(G3,x,x+h);

  H1 = @(y) fun(y).*g(y).*g(y);
  H2 = @(y) fun(y).*g(y).*v(y);
  
  M(3,3) = Gauss2(H1,x,x+h);
  M(3,4) = M(4,3) = Gauss2(H2,x,x+h);
  
  K1 = @(y) fun(y).*v(y).*v(y);
  M(4,4) = Gauss2(K1,x,x+h);
  
end
