# Memory allocation : C++ vs. Perl

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

###Perl (dynamic-typed)
---

* Consider the following example. Use the list to store the memory locations of two hash tables. When it is going to reference the variables use the index to get the relative memory location. After that the operator '->' is the necessary component to access the context in the specific memory location. The core in Perl is dynamic binding type of variables. This binding type means the data type of variable is binding(confirmed) after the assignment is achieved. Therefore it is not necessary to follow the strong data binding rule that a variable must be the same data type from the beginning to the end.

```Perl
#!/usr/bin/perl -w

use strict;

my %hash_table1 = (1=>'a' , 2=>'b', 3=>'c', 4=>'d', 5=>'e');
my %hash_table2 = (10=>'f' , 20=>'g', 30=>'h', 40=>'i', 50=>'j');

# '\' used in the following means the reference modifier.
my @database = ( \%hash_table1, \%hash_table2 );

foreach my $keyInHash (keys(%hash_table1)) {
	print $keyInHash,":",$hash_table1{$keyInHash},"\n";
	%{$database[0]}->{$keyInHash} = uc %{$database[0]}->{$keyInHash};
}

print "\nAfter use the pointer to modify the char in uppercase.\n";

foreach my $keyInHash (keys(%hash_table1)) {
	print $keyInHash,":",$hash_table1{$keyInHash},"\n";
}
```

