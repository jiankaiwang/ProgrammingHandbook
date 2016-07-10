# Memory allocation

<script type="text/javascript" src="../js/general.js"></script>

###C++ (static-typed)
---

* Consider the following example. Use the allocation syntax "new" with "[ ]" to dynamically allocate a fixed number of memory space. In C++ there are some syntax to access the memory location/context. The basic concept is that the variable name is directly representing the location of memory for OS, not for the hardware. When using the "new" to allocate memory OS would distribute a accuracy space to the process. After the allocation is confirmed the value could be stored into the memory allocated by OS. The syntax of " Variable + index " means the shift unit from the beginning of the memory. Using "[ ]" and index is another way of accessing the context of the specific memory location.

```cpp
#include <iostream>
#include <cstdlib>
#include <cctype>

using namespace std;

int main() {
    char* ptr_table1 = new char[5];
    ptr_table1[0] = 'a';
    ptr_table1[1] = 'b';
    ptr_table1[2] = 'c';
    ptr_table1[3] = 'd';
    ptr_table1[4] = 'e';

    for(int i = 0 ; i < 5 ; i++) {
        cout << i << ":" << *(ptr_table1+i) << endl;
        *(ptr_table1+i) = toupper(ptr_table1[i]);
    }
    cout << "\nAfter use the pointer to modify the char in uppercase." << endl;
    for(int i = 0 ; i < 5 ; i++) {
        cout << i << ":" << *(ptr_table1+i) << endl;
    }
    delete [] ptr_table1;
    return 0;
}
```