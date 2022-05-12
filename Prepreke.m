## Za funkcije definirane sa "function...end" (npr. P6 i P2), 
## koristiti P=@P6 u mainu. Za ostale funkcije primjerice P=P1

% P1 = KONSTANTA
konst = -1;
P1 = @(x) 0.*x + konst; 

% P2 = SKORO STEP
function z = P2(x)
  if(x < 1.8)
    z = -3;
  else
    z = sqrt(3)*(x - 2);
  end
end

% P3 = LINEARNA
P3 = @(x) (-1.*x); 

% P4 = PARABOLA
P4 = @(x) (-(3/4)*(x-1).^2+0.5);

% P5 = SINUS [0,4]
P5 = @(x) sin((pi/4).*x)-0.5;

%P6 = KRUZNICA U SREDINI INTERVALA
function z = P6(x)
  if(x<1.65 && x>0.35)
    z = sqrt((0.65)^2-(x-1).^2);
  else
    z = 0;
  end
endfunction

% P7 = NI KONVEKSNA NI KONKAVNA %na [0,4]
P7 = @(x) (1-4.*(x-2).^2).*((x-2).^2-0.5)+0.3;

% P8  
phi = pi/2;
P8 = @(x) -(3+(1/2).*sin(12*phi.*x)+sin(2*phi.*x)); 

