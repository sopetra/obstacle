%{
-> Gauss u dva cvora na [-1,1]:
    preciznost stupnja 3
    int_[-1,1] = f( -sqrt(3)/3 ) + f( sqrt(3)/3 )

-> Gauss u 3 cvora na [-1,1]:
    preciznost stupnja 5
    int_[-1,1] = w1f(x1) + w2f(x2) + w3f(x3)
    w1 = 0.5555555556, w2 = 0.8888888889, w3 = 0.5555555556
    x1 = -0.7745966692, x2 = 0, x3 = -0.7745966692
%}

function d = D (h, x, fun)
  
  f = @(y) fun(y).*((y-x)/h-1)^2*(2*((y-x)/h)+1); %fija lijevo 
  g = @(y) fun(y).*(3-2*((y-x)/h))*((y-x)/h)^2;   %fija desno 
  u = @(y) fun(y).*((y-x)/h)*(1-(y-x)/h)^2;       %derivacija lijevo
  v = @(y) fun(y).*(-(1-(y-x)/h)*((y-x)/h)^2);    %derivacija desno 
  
  d = zeros(4,1);
  
  d(1,1) = Gauss2(f,x,x+h);
  d(2,1) = Gauss2(u,x,x+h);
  d(3,1) = Gauss2(g,x,x+h);
  d(4,1) = Gauss2(v,x,x+h);

end
