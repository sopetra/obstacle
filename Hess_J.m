function Jac = Hess_J (A, F, p, epsilon, x) % x je stupac
    n = max(size(F))/2 - 1;
    Jac = zeros(2*n+2,2*n+2);
    %phi = zeros(2*n+2,1); % Desna strana
    phi_jac = zeros(2*n+2,2*n+2); % Jakobijeva matrica
    for i = 1:2:2*n
      phi_jac(i,i) = epsilon * (x(i)<p(i));%*(p(i)-x(i)).^2;
    endfor      
    Jac = A + phi_jac;
endfunction
