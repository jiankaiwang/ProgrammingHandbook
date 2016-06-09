# Parallel

<script type="text/javascript" src="js/general.js"></script>

###Fine-grained, coarse-grained, and embarrassing parallelism
---

Applications are often classified according to ** how often their subtasks need to synchronize or communicate with each other **. An application exhibits ** fine-grained parallelism ** if its subtasks must communicate many times per second; it exhibits ** coarse-grained parallelism ** if they do not communicate many times per second, and it is ** embarrassingly parallel ** if they rarely or never have to communicate. Embarrassingly parallel applications are considered the easiest to parallelize.

###Cluster
---

In a computer system, a cluster is ** a group of servers and other resources that act like a single system ** and enable high availability and, in some cases, load balancing and parallel processing.

###Symmetric Multi-Processing (SMP)
---

* Symmetric multiprocessing (SMP) ** involves a symmetric multiprocessor system hardware and software architecture where two or more identical processors connect to a single, shared main memory, have full access to all I/O devices, and are controlled by a single operating system instance that treats all processors equally **, reserving none for special purposes. Most multiprocessor systems today use an SMP architecture. ** In the case of multi-core processors, the SMP architecture applies to the cores, treating them as separate processors **.

* SMP systems are tightly coupled multiprocessor systems with a pool of homogeneous processors running independently, each processor executing different programs and working on different data and with capability of sharing common resources (memory, I/O device, interrupt system and so on) and connected using a system bus or a crossbar.

###Computing compare 
---

* Symmetric Multiprocessing

Some libraries, often to preserve some similarity with more familiar concurrency models (such as Python's threading API), employ parallel processing techniques which limit their relevance to SMP-based hardware, mostly due to the usage of process creation functions such as the UNIX fork system call. However, a technique called process migration may permit such libraries to be useful in certain kinds of computational clusters as well, notably single-system image cluster solutions (Kerrighed, OpenSSI, OpenMosix being examples).

* Cluster Computing

Unlike SMP architectures and especially in contrast to thread-based concurrency, ** cluster (and grid) architectures offer high scalability due to the relative absence of shared resources **, although this can make the programming paradigms seem somewhat alien to uninitiated developers. In this domain, some overlap with other distributed computing technologies may be observed (see Distributed Programming for more details).

* Cloud Computing

Cloud computing is similar to cluster computing, ** except the developer's compute resources are owned and managed by a third party, the "cloud provider" **. By not having to purchase and set up hardware, the developer is able to run massively parallel workloads cheaper and easier.

* Grid Computing

Grid computing is the collection of computer resources from multiple locations to reach a common goal. ** The grid can be thought of as a distributed system with non-interactive workloads that involve a large number of files. Grid computing is distinguished from conventional high performance computing systems such as cluster computing in that grid computers have each node set to perform a different task/application **. Grid computers also tend to be more heterogeneous and geographically dispersed (thus not physically coupled) than cluster computers. Although a single grid can be dedicated to a particular application, commonly a grid is used for a variety of purposes. Grids are often constructed with general-purpose grid middle ware software libraries.








