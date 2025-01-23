# On pairs of primes with small order reciprocity

This repository contains the implementation of the algorithms and the results of the computations described in the paper.

**arXiv:** [Link to the paper]

**Authors:** Craig Costello and Gaurish Korpal

## Repository Organization

### Code

```
code/
├── combine_vectors.gp
├── prime_pairs.gp
└── primitive_elements.gp
```

This directory consists of all the PARI/GP scripts used. 

- `combine_vectors.gp` combines the smaller (primitive element) vectors into a bigger one using PARI's `concat` function.
- `prime_pairs.gp` is an implementation of our algorithm from the paper that reads the precomputed vector of primitive elements and then searches for $(k,k')$-prime pairs in parallel for $(k,k')\in \{(m,n), (m,n+1), (m+1,n), (m+1,n+1)\}$ where $2 \leq m \leq n \leq 51$. 
- `primitive_elements.gp` runs PARI's `znprimroot` function in parallel to compute desired length vectors of primitive elements.

### Data

```
data/
├── prime_pairs-1_100e6.tar.gz
└── prime_pairs-100e6plus1_200e6.tar.gz
```

The file names follow the pattern of `prime_pairs-M_N.tar.gz` which contains prime pairs for primes lying between $M$ and $N$ (both included). Furthermore, 100e6 means $100 \times 10^6$ and 100e6plus1 means $100 \times 10^6 + 1$. 

The above `.tar.gz` compressed archives were generated as follows:

```bash
$ tar -czvf prime_pairs-M_N.tar.gz prime_pairs-M_N/
```

One can access the contents of these archives by navigating to the directory and using the following command:

```bash
$ tar -xzvf prime_pairs-M_N.tar.gz 
```

This will create a directory called `prime_double-M_N/`. 

```
prime_pairs-M_N/
├── *.csv
├── elements-M_N.txt
├── frequency_table.tex
├── frequency_table-abc.tex
├── frequency_table-abc.pdf
├── frequency_table.py
└── prime_pairs-M_N.gp
```

There are many CSV files called `a-b.csv` each containing all the $(a,b)$-prime pairs for primes lying between $M$ and $N$ (both included). In addition to those, it contains the following files:

- `elements-M_N.txt` contains a vector of all primitive elements for primes lying between $M$ and $N$ (both included).
- `frequency_table.py` is a Python script that combs through all the CSV files and generates `frequency_table.tex`.
- `frequency_table-abc.tex` is a manually edited version of the Python-generated LaTeX file that can be compiled using pdfTeX to obtain `frequency_table-abc.pdf`.
- `prime_pairs-M_N.gp` is the GP script that reads the primitive elements vector and generates the CSV files.

## System Requirements

The code was written and tested on a system with the following specifications:

**CPU:** AMD Ryzen Threadripper PRO 3995WX (128)

**Memory:** 128624MiB = 128GiB

**OS:** Ubuntu 22.04.4 LTS x86_64

**Software:** GP/PARI CALCULATOR Version 2.15

### Software Installation Steps:

```bash
$ sudo apt install build-essential libreadline-dev libgmp3-dev bison 
$ git clone https://pari.math.u-bordeaux.fr/git/pari.git 
$ cd pari
$ git branch pari-2.15 origin/pari-2.15 
$ git checkout pari-2.15 
$ env MAKE="make -j128"
$ sudo ./Configure --tune --mt=pthread --time=ftime
$ sudo make all
$ sudo make bench
$ sudo make test-parallel
$ sudo make install
```

### Software Configuration 

Copy the file `pari/misc/gprc.dft` to `$HOME/.gprc`

```
// minimal housekeeping
\\ Limit output of commands to first 40 lines to avoid terminal 
\\ choking on thousands of lines output.
lines = 40

\\ Save GP history between sessions.
histfile = "~/.gp_history"

// total memory allocated = parisize + (nbthreads x threadsize)
\\ Set PARI typical stack size to 40 Mbytes = 4*10^7 bytes (will grow as
\\ needed, up to parisizemax)
parisize = 40M

\\ Set maximal stack size. A safe value is half of the system memory.
parisizemax = 64G

\\ In parallel mode, each thread allocates its own private stack for its computations.
\\ It is not easy to estimate reliably a sufficient value for threadsize
\\ because PARI itself will parallelize computations and we recommend to 
\\ not set this value explicitly
\\ threadsize = DO NOT SET

\\ Limit PARI threads stack size to 100 Mbytes = 10^8 bytes
threadsizemax = 10G

// GP startup operations
\\ GP precomputes a list of all primes less than primelimit at initialization time
\\ can build fast sieves on demand to quickly iterate over primes up to the square of primelimit.
\\ Biggest precomputed prime (= precprime(10^6))
\\ values beyond 10^8 allowing to iterate over primes up to 10^16, do not seem useful.
primelimit = 10M
```
