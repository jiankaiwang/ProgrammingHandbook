# Quick Start



## Prepare



* Install NVIDIA Drivers : http://www.nvidia.com.tw/Download/index.aspx?lang=tw	

* Install NVIDIA CUDA Toolkit : https://developer.nvidia.com/cuda-downloads

  

## Sample Code



The simple CUDA example is as the following, and save it as `example.cu`.



```c++
#include <stdio.h>

//
// Nearly minimal CUDA example.
// Compile with:
//
// nvcc -o example example.cu
//

#define N 1000

//
// A function marked __global__
// runs on the GPU but can be called from
// the CPU.
//
// This function multiplies the elements of an array
// of ints by 2.
//
// The entire computation can be thought of as running
// with one thread per array element with blockIdx.x
// identifying the thread.
//
// The comparison i<N is because often it isn't convenient
// to have an exact 1-1 correspondence between threads
// and array elements. Not strictly necessary here.
//
// Note how we're mixing GPU and CPU code in the same source
// file. An alternative way to use CUDA is to keep
// C/C++ code separate from CUDA code and dynamically
// compile and load the CUDA code at runtime, a little
// like how you compile and load OpenGL shaders from
// C/C++ code.
//
__global__
void add(int *a, int *b) {
	int i = blockIdx.x;
	if (i<N) {
		b[i] = 2 * a[i];
	}
}

int main() {
	//
	// Create int arrays on the CPU.
	// ('h' stands for "host".)
	//
	int ha[N], hb[N];

	//
	// Create corresponding int arrays on the GPU.
	// ('d' stands for "device".)
	//
	int *da, *db;
	cudaMalloc((void **)&da, N * sizeof(int));
	cudaMalloc((void **)&db, N * sizeof(int));

	//
	// Initialise the input data on the CPU.
	//
	for (int i = 0; i<N; ++i) {
		ha[i] = i;
	}

	//
	// Copy input data to array on GPU.
	//
	cudaMemcpy(da, ha, N * sizeof(int), cudaMemcpyHostToDevice);

	//
	// Launch GPU code with N threads, one per
	// array element.
	//
	add << <N, 1 >> >(da, db);

	//
	// Copy output array from GPU back to CPU.
	//
	cudaMemcpy(hb, db, N * sizeof(int), cudaMemcpyDeviceToHost);

	for (int i = 0; i<N; ++i) {
		printf("%d\n", hb[i]);
	}

	//
	// Free up the arrays on the GPU.
	//
	cudaFree(da);
	cudaFree(db);

	return 0;
}
```



## Windows



* Install Visual Studio first. There is a `cl.exe` while you install the visual studio. It is Microsoft's C/C++ compiler. The `nvcc.exe` requires `cl.exe` to compile the CUDA code.
* Compile the CUDA code as the below.

```shell
nvcc -o example example.cu

# if no cl.exe exists (not registering as environment variables)
nvcc -o example example.cu -ccbin "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.12.25827\bin\Hostx64\x64"
```



## Linux



* Prepare

```shell
# example to install cuda toolkit
wget https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda-repo-ubuntu1604-9-2-local_9.2.148-1_amd64
sudo dpkg -i cuda-repo-ubuntu1604-9-2-local_9.2.148-1_amd64.deb
sudo apt-key add /var/cuda-repo-<version>/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda
```



* Compile the CUDA code as the below.

```shell
nvcc -o example example.cu
./example
```











