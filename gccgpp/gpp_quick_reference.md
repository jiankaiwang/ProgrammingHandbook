# g++ Quick Reference



## Basic Operations

```shell
# generate a execution
g++ -c file.cpp -o file.o

# generate a assembly : file.s 
g++ -S file.cpp

# convert file.o to file.dll
# notice that file.o must be converted first
g++ -shared file.o -o file.dll 

# compile files into file.exe or file.o
g++ file.cpp -o file 

# generate file.exe from object and cpp files
g++ file.cpp obj.o -o file 

# generate main.exe from dll and cpp files
g++ file.dll main.cpp -o main

# alternative solution to generate main.exe from file.dll and main.cpp 
# -L. means current dir
g++ -L. -l file main.cpp -o main 

# show all the warning
gcc -Wall -o main main.c

# warning as error
gcc -Wall -Werror -o main main.c
```

