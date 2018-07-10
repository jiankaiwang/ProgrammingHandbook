# Memory allocation in perl



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

