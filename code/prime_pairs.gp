primepairs(K) = 
{
  \\ Declare local variables
  my(k, kk, P, N, filename, p, alpha, t, m, q, flag);

  \\ read the input tuple
  k = K[1];
  kk = K[2];
  if (k <= kk, 
    \\ read the pre-computed primitive elements
    P = read("elements-100million");
    N = #P;

    \\ CSV filename to write in if executed
    filename = Str(k, "-", kk, ".csv");
    
    \\ number before the first prime in the primitive element list
    p = 1; \\ prime(10^8)

    \\ Loop over all the N primes after the first p primes
    for (i = 1, N, 
      p = nextprime(p + 1);
      alpha = P[i]; 

      \\ ord_q(p) = k, ord_p(q) = kk, q < p
      if (p % kk == 1,
        t = (p - 1) / kk;
      
        \\ Compute the set of prime numbers q
        for (s = 1, kk - 1,
          m = s * t;
          if (gcd(m, p - 1) == t,
            q = lift(Mod(alpha, p)^m);
            if (q % k == 1,
              if (ispseudoprime(q),
              
                \\ Check the condition for p and q
                if (Mod(p, q)^k == 1,
                  flag = 1;
                  for (d = 1, k - 1,
                    if (k % d == 0,
                      if (Mod(p, q)^d == 1,
                        flag = 0;
                        break;
                      );
                    );
                  );
                  \\ If the condition is satisfied, write to the CSV file
                  if (flag,
                    write(filename, p, ",", q);
                  );
                );                
              );
            );
          );
        );
      );
    
      \\ ord_q(p) = kk, ord_p(q) = k, q < p
      if (kk != k && p % k == 1,
        t = (p - 1) / k;
      
        \\ Compute the set of prime numbers q
        for (s = 1, k - 1,
          m = s * t;
          if (gcd(m, p - 1) == t,
            q = lift(Mod(alpha, p)^m);
            if (q % kk == 1,
              if (ispseudoprime(q),
              
                \\ Check the condition for p and q
                if (Mod(p, q)^kk == 1,
                  flag = 1;
                  for (d = 1, kk - 1,
                    if (kk % d == 0,
                      if (Mod(p, q)^d == 1,
                        flag = 0;
                        break;
                      );
                    );
                  );
                  \\ If the condition is satisfied, write to the CSV file
                  if (flag,
                    write(filename, q, ",", p);
                  );
                );
              );
            );
          );
        );
      );
    );
  );
}

export(primepairs);

forstep(m = 2, 50, 2, 
  forstep(n = m, 50, 2, 
    parforvec(X = [[m, m + 1], [n, n + 1]], primepairs(X));
  );
);
