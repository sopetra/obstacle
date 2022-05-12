%{
E [in]  = koeficijent elasticnosti
I [in]  = moment povrsine
b [in]  = stap je u elasticnom sredstvu 
n [in]  = broj elemenata
l [in]  = duljina stapa

A [out] = matrica krutosti dimenzije 2*n+2
F [out] = desna strana sustava
x [out] = vektor cvorova
y [out] = rjesenje sustava Ay=F; 
          parni indeksi: aproksimacija rjesenja u 
          neparni indeksi: aproksimacija derivacije od u 
%}

function [A,F,x,y] = fem_stap(E,I,b,f,n,l)
  
h = l/n; % n+1 cvorova -> 2*(n+1) nepoznanica
y = zeros(2*n+2,1);
x = [0:h:l];

B1 = zeros(2*n+2);
B2 = zeros(2*n+2);
F = zeros(2*n+2,1);

% uz EI -> uz drugu derivaciju
j = 1;
for i = 1:+2:2*n-1 % indeks intervala, ima n+1 cvorova
   B1(i:i+3,i:i+3) = B1(i:i+3,i:i+3) + M2(h,x(j),E,I);
   j ++;  
end
j = 1;

% uz b -> uz nultu derivaciju
for i = 1:+2:2*n-1 % indeks intervala, ima n+1 cvorova
   B1(i:i+3,i:i+3) = B1(i:i+3,i:i+3) + M0(h,x(j),b);
   j ++;  
end

 
A = B1 + B2;

% funkcional L
j = 1;
for i = 1:+2:2*n-1
   F(i:i+3) = F(i:i+3)+D(h,x(j),f);
   j ++;
end



% RUBNI UVJETI
  % Lijevi
    % u  
    A(1,:) = zeros(1,2*n+2);
    A(:,1) = zeros(1,2*n+2)';
    A(1,1) = 1;
    F(1) = 0;
    % u'  
    
    A(2,:) = zeros(1,2*n+2);
    A(:,2) = zeros(1,2*n+2)';
    A(2,2) = 1;
    F(2) = 0;
    
  % Desni
    % u  
    A(2*n+1,:) = zeros(1,2*n+2);
    A(:,2*n+1) = zeros(1,2*n+2)';
    A(2*n+1,2*n+1) = 1;
    F(2*n+1) = 0;
    % u'
    
    A(2*n+2,:) = zeros(1,2*n+2);
    A(:,2*n+2) = zeros(1,2*n+2)';
    A(2*n+2,2*n+2) = 1;
    F(2*n+2) = 0;
    
    
    
y = A\F;
end

