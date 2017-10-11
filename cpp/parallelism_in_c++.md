# Parallelism

<script type="text/javascript" src="../js/general.js"></script>

###Background
---

* OpenMP is the kind of open-sourced tools used in parallel computing. Mostly it is used in complied languages, e.g. C, C++, etc. The following are some examples showing how to use OpenMP.

###Used in Visual Studio C++
---

```cpp
// OpenMP might be activated by manual
// project > property > configuration property > C/C++ > language > open MP support > YES

#include <iostream>
#include <cstdlib>
#include <omp.h>

using namespace std;

void section(int getNum) {
	int getResult = 0;
	for(int i = 0; i < 10000; i++) { 
		getResult = i % 2;
	}
	cout << getNum << endl;
}

int main() {
	for(int i = 0 ; i < 20; i++) {
		section(i);
	}
	#pragma omp parallel for
	for(int i = 0 ; i < 20; i++) {
		section(i);
	}
	system("PAUSE");
	return 0;
}
```

###Used in C++ by GNU compiler
---

```cpp
/*

   DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.

   Copyright 2009 Sun Microsystems, Inc. All rights reserved.

   The contents of this file are subject to the terms of the BSD License("BSD")(the "License"). 
   You can obtain a copy of the License at: http://www.opensparc.net/pubs/t1/licenses/BSD+_License.txt

   The BSD License

   Redistribution and use in source and binary forms, with or without 
   modification, are permitted provided that the following conditions are met:

       * Redistribution of source code must retain the above copyright 
         notice, this list of conditions and the following disclaimer.
       * Redistribution in binary form must reproduce the above copyright 
         notice, this list of conditions and the following disclaimer in 
         the documentation and/or other materials provided with the 
         distribution.
       * Neither the name of Sun Microsystems, Inc. or the names of 
         contributors may be used to endorse or promote products derived 
         from this software without specific prior written permission.

   This software is provided "AS IS," without a warranty of any kind. ALL 
   EXPRESS OR IMPLIED CONDITIONS, REPRESENTATIONS AND WARRANTIES, INCLUDING ANY 
   IMPLIED WARRANTY OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR 
   NON-INFRINGEMENT, ARE HEREBY EXCLUDED. SUN MICROSYSTEMS, INC. ("SUN") AND 
   ITS LICENSORS SHALL NOT BE LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A 
   RESULT OF USING, MODIFYING OR DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES. 
   IN NO EVENT WILL SUN OR ITS LICENSORS BE LIABLE FOR ANY LOST REVENUE, PROFIT 
   OR DATA, OR FOR DIRECT, INDIRECT, SPECIAL, CONSEQUENTIAL, INCIDENTAL OR 
   PUNITIVE DAMAGES, HOWEVER CAUSED AND REGARDLESS OF THE THEORY OF LIABILITY, 
   ARISING OUT OF THE USE OF OR INABILITY TO USE THIS SOFTWARE, EVEN IF SUN HAS 
   BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

   You acknowledge that this software is not designed, licensed or intended for 
   use in the design, construction, operation or maintenance of any nuclear facility. 

*/

#include <stdio.h>
#include <stdlib.h>

#ifdef _OPENMP
  #include <omp.h>
  #define TRUE  1
  #define FALSE 0
#else
  #define omp_get_thread_num() 0
#endif

void funcA();
void funcB();
void funcC();
void funcD();

int main() {

	#ifdef _OPENMP
		(void) omp_set_dynamic(FALSE);
		if (omp_get_dynamic()) {printf("Warning: dynamic adjustment of threads has been set\n");}
		(void) omp_set_num_threads(4);
	#endif

	#pragma omp parallel 
	{
		#pragma omp sections
		{
			#pragma omp section
			(void) funcA();

			#pragma omp section
			(void) funcB();

			#pragma omp section
			(void) funcC();

			#pragma omp section
			(void) funcD();
		} /*-- End of sections block --*/
	} /*-- End of parallel region --*/
	system("PAUSE");
	return(0);
}

void funcA() {
	printf("In funcA: this section is executed by thread %d\n", omp_get_thread_num());
}

void funcB() {
	printf("In funcB: this section is executed by thread %d\n", omp_get_thread_num());
}

void funcC() {
	printf("In funcC: this section is executed by thread %d\n", omp_get_thread_num());
}

void funcD() {
	printf("In funcD: this section is executed by thread %d\n", omp_get_thread_num());
}
```

* usage

```bash
# the following is the complied command refered from OpenMP offical document
# since version of C11, C++ started to support OpenMP
# OpenMP could be used by FLAG for complier
# supposed that the above code was saved as 'fig4.16-sections.c' located on Desktop
# the platform is Windows 7 x64
cd ./Desktop

# gnu9x: C99 plus GNU extensions (needed for getopt)
gcc -c -O -std=gnu9x -fopenmp  fig4.16-sections.c

gcc -o fig4.16.exe fig4.16-sections.o -O -fopenmp
```

