function x = Newton (f, df, x0)
  x = x0;
  k = 0;
  %printf("...Newtonova metoda...\n");

  if norm(f(x0), 2) < 1e-12
    x = x0;
    %printf('...broj iteracija Newtona: %d\n', k); 
    return;
  end
  while 1
    x = x - df(x)\f(x);
    C = df(x);
    D = f(x);

    if norm(x0-x)/norm(x0)<1e-4   
     k = k + 1;
     printf('...broj iteracija Newtona: %d\n', k);
     break;
    else
     x0 = x;
     k = k+1;
    end
  end
  
end
