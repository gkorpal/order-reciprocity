\\ Get all the primitive elements modulo the Mth to Nth primes
\\ M = 10^m and N = 10^n; 0 < m < n 
\\ Split output into files with vectors of size K = 10^k <= N-M
\\ Usage: getprimitives(10, 100, 10);

getprimitives(M, N, K) =
{
	my(m, n, k, out, file, filename, remaining, current_size, start);
	file = 0;
	m = logint(M, 10);
	n = logint(N, 10);
	k = logint(K, 10);
	remaining = N - M + 1;
	while (remaining > 0,
		file = file + 1;
		current_size = min(K, remaining);
		start = M + (file - 1) * K; 
		out = parvector(current_size, i, lift(znprimroot(prime(start + i - 1))));
		filename = Str("elements-", m, "_", n, "_", k, "_", file);
		write(filename, out);
		remaining = remaining - current_size;
	);
}
