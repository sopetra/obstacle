%{
j_epsilon(x)= 1/(2epsilon) * sum_{i=0}^{n}(P(i)-x(2i))_+^2
Pretpostavljamo da je dim(p) = dim(y), p(i) = 0 za i=2,4,6,...
%}

function y = j_epsilon (p, epsilon, x)
  n = max(size(x))/2-1;
  y = 0;
  for i = 1:2:2*n+2
    y += (x(i)<p(i))*(p(i)-x(i)).^2;
  end 
  y = y/2;
  y = epsilon * y;
endfunction
