function y = Fun_J (A, F, p, epsilon, x) % x je stupac
    n = max(size(F))/2 - 1;
    phi = 0;
    for i = 1:2:2*n
      phi += (x(i)<p(i)).*(p(i)-x(i)).^2;
    endfor
    phi = (epsilon/2)*phi;
    y = 0.5*(x')*(A*x) + phi - F'*x;
endfunction
