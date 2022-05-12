clear all;
%% -----------------------------------------------------------------------------
%% PREPREKA 
Prepreke;
P = P1;

%% -----------------------------------------------------------------------------
%% SVOJSTVA STAPA I SILA

E = 2e11; % [N/m^2 = Pa] Aluminij: 6.9e10; Čelik: 2e11; Željezo: 2.1e11
v = 0.005; % visina grede
d = 0.03; % debljina (sirina) grede
I = d*(v)^3*(1/12); %[m^4]
f = @(x) -2000; %[N] % -2
b = @(x) 0;
L = 2;

%% -----------------------------------------------------------------------------
%% FEM
n = 100; 
[A,F,x,y] = fem_stap(E,I,b,f,n,L);

%% Penalizacija bez uvjeta na derivacije
p = zeros(2*n+2,1);
j = 1;
for i = 1:2:2*n+2
  p(i) = P(x(j));
  j++;
end

%% -----------------------------------------------------------------------------
%% MINIMIZACIJA FUNKCIONALA J(v)=(1/2)A(v,v)-F(v) KORISTENJEM FUNKCIJE qp

v = zeros(2*n+2,1);
v(1:2:2*n+1) = 1;
B = diag(v);

% FEM + qp funkcija
options = optimset('MaxIter',1000);
[z, sol, info] = qp(p, A, -F, [], [], [], [], p, B, [], options);  

%% Plot rješenja qp funkcije
%figure(1) % usporedba
%plot(x,y(1:2:2*n+1),'--b',x,p(1:2:2*n+2),'-r',x,z(1:2:2*n+2),'-b');
%title("FEM + qp (Octave funkcija)");
%}
%% -----------------------------------------------------------------------------
%% PENALIZACIJSKA METODA

epsilon = 1; eta     = 10; IT = 1;  nrm = dnrm = [];  
u0      = y; j_eps_u = temp = 1000; 

j_eps = @(x) j_epsilon(p, epsilon, x);
j_u = j_eps(u0)./epsilon;
printf('\n Vrijednost funkcije j početne aproksimacije: %e\n', j_u);
printf('\n Faktor: %d\n', eta);

f2=figure(2)
hold on
box on
grid on; %ylim([-0.3,0.8]);
plot(x,y(1:2:2*n+2),'-k'); % rješenje bez prepreke
while( j_eps_u >= 1e-8 || temp >= 1e-8 ) 
%% Ako stavljamo veću točnost, v. Gradient_method (treba popraviti uvjet zaustavljanja u line searchu)
  J = @(x) Fun_J(A, F, p, epsilon, x); % Za gradijentne metode
  dJ  = @(x) Grad_J(A, F, p, epsilon, x); % = \nabla J(x) gdje je J(x)=0.5<Ax,x>-<F,x>+j_epsilon(x)
  hJ = @(x) Hess_J(A, F, p, epsilon, x); 
  printf('-----------------------------------------------------------------\n');
  printf('\n IT = %d epsilon = %e\n', IT, epsilon); printf("Penalizacija...\n");
  %% Biramo metodu kojom rjesavamo nelinearnu jednadzbu
  
  %% 1. Newtonova metoda -> direktno rjesavanje nelinearne jednadzbe
  u = Newton(dJ, hJ, u0);
  
  %% 1*. Newton-Broyden dobra verzija -> Newton + aproksimacija Df 
  %%     ukljucuje rjesavanje sustava u svakoj iteraciji 
  %u = Newton_Broyden(dJ, hJ, u0);
  
  %% 1**. Newton_Broyden dobra verzija -> Newton + aproksimacija Df^{-1} 
  %%      ukljucuje mnozenje u svakoj iteraciji
  %u = Newton_Broyden_inv(dJ, hJ, u0);    
  
  %% 2. Metoda najbrzeg spusta -> uzimamo ekvivalentnu formulaciju i 
  %%    rjesavamo minimizaciju funkcionala J(y)=0.5*<Ay,y>-<F,y>+j_{eps}(y);
  %%    koristi 1D Newtonovu metodu za line search
  %u = Gradient_method(A, dJ, hJ, u0); 
  
  %% 2*. Gradijentna metoda s jednostavnim iteracijama
  %u = Gradient_method_s(A, J, dJ, u0);
  
  %% 2***. Gradijentna metoda s pravilom iz Armijo 
  %u = Gradient_method_A(A, J, dJ, u0);  
  
  temp = norm(u0-u, 2);
  j_eps_u = j_eps(u); 
  printf('-> vrijednost penalizacije j_e: %e\n', j_eps_u); 
  printf('-> norma razlike uzastopnih aproksimacija: %e\n', temp);
  printf('\nNorma razlike s aproksimacijom Octave funkcije: %e\n', norm(u(1:2:2*n+2)-z(1:2:2*n+2), 2));
  printf('Norma razlike derivacije s aproksimacijom Octave funkcije: %e\n', norm(u(2:2:2*n+2)-z(2:2:2*n+2), 2));
  plot(x, u(1:2:2*n+2), '--b','LineWidth',1.0);
  nrm = [nrm; norm(u(1:2:2*n+2)-z(1:2:2*n+2), 2)];
  dnrm = [dnrm; norm(u(2:2:2*n+2)-z(2:2:2*n+2), 2)];
  
  epsilon = eta * epsilon;
  j_eps = @(x) j_epsilon(p, epsilon, x);
  IT = IT + 1;
  u0 = u; 
end

plot(x, u(1:2:2*n+2),'-g','LineWidth',1.6); 
plot(x, p(1:2:2*n+2),'-r');
printf('\nKRAJ\n');
hold off

f4=figure(4)
semilogy(nrm,'o-b'); grid on;
xlabel("IT"); ylabel('||x-x_{\epsilon}||_2');

