# Perl

<script type="text/javascript" src="../js/general.js"></script>

###Data Type
---

| api | desc |
| -- | -- |
| my $var = 100; | define a variable |
| my $varToStr = $var." is a string\n";| concatenate as string |
| my $var = "100"; | transform into string |
| my $varToInt = $var + 200; | to integer |
| my $varToFloat = $var + 200.12; | to float |

###Loop
---

```Perl
# for loop-index				
for(my $i = 0; $i < 10; $i++) { }
```

```Perl
# for-each loop
my @total = ("is","a","string.");
foreach my $element (@total) { }
```

```Perl
# while loop
my %hash = ( "k1" => "v1", "k2" => "v3", "k3" => "v3");
while(($key,$value)=each %hash) { }
```

###System interaction
---

```Perl
# count the parameters passed
my $total = scalar(@ARGV);		
```

```Perl
# show the parameters, start from 0, the first parameter, not file name
for(my $i = 0; $i < scalar(@ARGV); $i++) { }
```

###Function
---

```perl
# declear function
sub getNum {
	my ($getString, $getOption) = @_;
    return 1;
}
```

```Perl
# use function
my $getRes = getNum("input",1);
```

###List
---

| api | desc |
| -- | -- |
| my @aList = (123,"A","the string"); | declear a list |
| push(@aList,"new element"); | push a element |
| my $getEle = pop(@aList); | pop a element |
| scalar(@aList); | length of a list |
| if(existInList("element",@aList)) [self][common.pl] | length of a list |
| indexOfList("A", @aList) [self][common.pl] | length of a list |

###Dictionary
---

| api | desc |
| -- | -- |
| my %newHash = (); | declear a hash |
| my $allKey = keys(%newHash); | all keys |
| my $allValue = values(%newHash); | all values |
| $newHash{"testKey"} = "testValue"; | replace a value by its key |
| if(exists ($newHash{"testKey"})) | check key exists |
| length(keys(%newHash)) | length |
| $newHash{"newKey"} = "newValue"; | add a pair |
| delete $newHash{"newKey"}; | delete the pair |

###File I/O
---

```Perl
# Read file
open(fin,"data.txt") or die("Error: File input error.\n");
foreach my $line (<fin>) { }
close(fin);
```

```Perl
# Write file
open(fout,"> data.out") or die("Error: File output error.\n");
print fout $i."\n";
close(fout);
```


