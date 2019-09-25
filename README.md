# Programming Handbook



This book is designed to summarize different kinds of programming languages, including syntax, resource, etc. We also introduce software licenses, algorithms, database languages, parallel computing, compiler, etc, topics. It is also designed to summarize lots of implementation topics to meet needs in programming.



* Seed Project : Provide libraries or packages for the software development in multiple programming languages.

  * Seed library: https://github.com/jiankaiwang/seed
  * Seed Document: https://github.com/jiankaiwang/seed_document

* Reference
  * Github (main) : https://github.com/jiankaiwang/ProgrammingHandbook
  * Gitbook (update no more) : https://jiankaiwang.gitbooks.io/programming_languages/content/



## Content



* Software Engineering
    * [License](license/) : try to compare different types of software license
    * [Continuous Integration](continuous_integration/) : introduce different CI tools and how to embed into the developing process
* Programming Languages
    * [C++](cpp/) : generic, static, object-oriented type programming language, its famous pointer, passed-by-reference operating provides developers with high performance in using hardware resource
    * [Java](java/) : generic, static, object-oriented, safe type programming language, executed on JVM, and it is easy to deploy service on different platform
    * ~~[C#/ASP.NET](csharp/) (No More Update) : a generic, static, object-oriented type programming language, based on .NET framework, and ASP is the webpage language~~
    * [Android APP](android/) : extends from java, its famous JNI, NDK, etc. are the core to develop android app
    * [GO](go/) : a static, compiled, imperative type programming language, it supports pointer, passed-by-reference like C++, and also supports lightweight concurrency, etc.
    * [Swift](swift/) : a static, compiled, imperative type programming language, it is the next generation programming language to develop apps on iOS, macOS, etc.
    * [Python](python/) : generic, dynamic, object-oriented type programming language, is good for numeric data processing, it also used in IoT, machine learning, deep learning, web-server, etc.
    * ~~[Perl](perl/) (No More Update) : a dynamic, imperative type programming language, is good for handling text, and webpage processing~~
    * ~~[PHP](php/) (No More Update) : a dynamic, object-oriented, imperative type programming language, mainly used in webserver-side~~
    * [Node.js](nodejs/) : dynamic, imperative type programming language, mainly used is the backend, syntax is  highly similar with javascript
    * [Javascript](javascript/) : dynamic, imperative type programming language, mainly used in the frontend to control or modify DOM
    * [Typescript](typescript/) : dynamic, imperative type programming language, is created to make writing javascript more object-oriented, structured
    * [CSS](css/) : the webpage desginer, painter
    * [R](rscript/) : dynamic, imperative type programming language, mainly used in the statistics, mathematics fields
* Algorithm
* Database Languages
    * ~~[SQL Server](sqlserver/) (No More Update) : a database server highly supported in Microsoft environment, e.g. Windows, C#, Azure, etc.~~
    * [MySQL](mysql/) : the famous cross platform database server highly used in Liunx (LAMP) 
    * [Mongodb](mongodb/) : the document-based NoSQL database server 
    * [Redis](redis/) : the in-memory database server mainly used in web session, media storage, etc. 
    * [Cassandra](cassandra/) : the distributed database server which supports like-SQL commands 
    * [SQLite](sqlite/) : the simple, ACID-compliant, and no server engine required database
* [Parallel Computing](parallel/)
    * [OpenCL](opencl/): Its purpose is to execute generic parallel computing, and it supports not only CUDA, but also others devices, including ATI, Intel, ARM, etc.
    * [CUDA](cuda/) : It is created and promoted by NVIDIA, is also the official name of GPGPU, and only supports graphic cards made by itself. The main purpose is to execute  generic parallel computing.
    * [Movidius](movidius/) : Its core is built with Myriad 2 visual processing unit (VPU) and provides developers with low power, high effectivity and high scaling to conduct MI/AI training, or deployment. You can also find more information on the repository. (Refer to https://github.com/jiankaiwang/aiot)
* Compression
    * [lzstring](LZ-string/) : is a cross-platfrom compressed library, and supports lots of programming languages, e.g. C#, javascript, python, etc.
* Tools
    * [gcc/g++](gccgpp/) : the C/C++ Compiler
    * [Bazel](bazel/) : a useful compiled tool which supports C++, android, Java, etc.




