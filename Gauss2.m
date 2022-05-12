%{
-> Gauss u dva cvora na [-1,1]:
    preciznost stupnja 3
    int_[-1,1] = f( -sqrt(3)/3 ) + f( sqrt(3)/3 )

%}


function int = Gauss2 (f, a, b)
  
  x0 = sqrt(3)/3;
  
  int = f( (a+b)/2 - x0*(b-a)/2 ) + f( (a+b)/2 + x0*(b-a)/2 ); 
  int = ((b-a)/2)*int;
  
  
end
