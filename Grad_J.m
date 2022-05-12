function y = Grad_J (A, F, p, epsilon, x) % x je stupac
    n = max(size(F))/2 - 1;
    y = zeros(2*n+2,1); phi = zeros(2*n+2,1); % Desna strana
    for i = 1:2:2*n
      phi(i) = (epsilon) * (x(i)<p(i)).*(p(i)-x(i));%.^2;
    endfor
    y = A*x - phi - F;
    
endfunction
