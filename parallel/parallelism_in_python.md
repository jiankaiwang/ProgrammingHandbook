# Parallelism in Python

<script type="text/javascript" src="../js/general.js"></script>

* Package : {PP} 

###Background
---

* "Parallel Python", PP, is the useful and open source package in python script. It provides two types of elementary parallel computing, SMP and cluster. The following are offical examples showing how to use pp package.

###SMP-based computing
---

* Symmetric multiprocessing (SMP) involves a symmetric multiprocessor system hardware and software architecture where two or more identical processors connect to a single, shared main memory, have full access to all I/O devices, and are controlled by a single operating system instance that treats all processors equally.

```Python
import math, sys, time
import pp

def isprime(n):
    """Returns True if n is prime and False otherwise"""
    if not isinstance(n, int):
        raise TypeError("argument passed to is_prime is not of 'int' type")
    if n < 2:
        return False
    if n == 2:
        return True
    max = int(math.ceil(math.sqrt(n)))
    i = 2
    while i <= max:
        if n % i == 0:
            return False
        i += 1
    return True
    
def sum_primes(n):
    """Calculates sum of all primes below given integer n"""
    return sum([x for x in xrange(2,n) if isprime(x)])

print """Usage: python sum_primes.py [ncpus]
    [ncpus] - the number of workers to run in parallel, 
    if omitted it will be set to the number of processors in the system
"""

# tuple of all parallel python servers to connect with
ppservers = ()
#ppservers = ("10.0.0.1",)

if len(sys.argv) > 1:
    ncpus = int(sys.argv[1])
    # Creates jobserver with ncpus workers
    job_server = pp.Server(ncpus, ppservers=ppservers)
else:
    # Creates jobserver with automatically detected number of workers
    job_server = pp.Server(ppservers=ppservers)

print "Starting pp with", job_server.get_ncpus(), "workers"

# basic format of job submit
# f1 = job_server.submit(func1, args1, depfuncs1, modules1)
# f2 = job_server.submit(func1, args2, depfuncs1, modules1)
# Submit a job of calulating sum_primes(100) for execution. 
# sum_primes - the function
# (100,) - tuple with arguments for sum_primes
# (isprime,) - tuple with functions on which function sum_primes depends
# ("math",) - tuple with module names which must be imported before sum_primes execution
# Execution starts as soon as one of the workers will become available
job1 = job_server.submit(sum_primes, (100,), (isprime,), ("math",))

# Retrieves the result calculated by job1
# The value of job1() is the same as sum_primes(100)
# If the job has not been finished yet, execution will wait here until result is available
result = job1()

print "Sum of primes below 100 is", result

start_time = time.time()

# The following submits 8 jobs and then retrieves the results
inputs = (100000, 100100, 100200, 100300, 100400, 100500, 100600, 100700)
jobs = [(input, job_server.submit(sum_primes,(input,), (isprime,), ("math",))) for input in inputs]

# not official, save the sum result
totalSum = []
totalSumWithKey = {}

for input, job in jobs:
    print "Sum of primes below", input, "is", job()
    totalSum.append(job())
    totalSumWithKey.setdefault(input,job())

print "Time elapsed: ", time.time() - start_time, "s"
job_server.print_stats()    
```

###Example result
---

```Bash
# the executing result

Usage: python sum_primes.py [ncpus]
    [ncpus] - the number of workers to run in parallel, 
    if omitted it will be set to the number of processors in the system

Starting pp with 4 workers
Sum of primes below 100 is 1060
Sum of primes below 100000 is 454396537
Sum of primes below 100100 is 454996777
Sum of primes below 100200 is 455898156
Sum of primes below 100300 is 456700218
Sum of primes below 100400 is 457603451
Sum of primes below 100500 is 458407033
Sum of primes below 100600 is 459412387
Sum of primes below 100700 is 460217613
Time elapsed:  1.44400000572 s
Job execution statistics:
 job count | % of all jobs | job time sum | time per job | job server
         9 |        100.00 |       5.3900 |     0.598889 | local
Time elapsed since server creation 1.4470000267
0 active tasks, 4 cores
```
