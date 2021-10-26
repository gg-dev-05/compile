## code.sh (compile and run any c or cpp file)

#### Download and install:
``` bash
git clone https://github.com/gg-dev-05/compile.git
cd compile
chmod +x code.sh
```
#### Aliases (optional)
*You can also add an [alias](https://www.tecmint.com/create-alias-in-linux/) for this script to run it from any directory  
for eg. add this to your .bashrc file*
```bash
alias runc="YOUR_PATH_TO_THIS_SCRIPT/./code.sh"
```


#### Usage:
```
  ./code.sh [options...] [args...]
    
Available Options:
    -h  display help 
    -l  use -lpthread flag while compiling
    -d  don't delete the compiled file
    -m  compile using mpi
    -f  specify input file"
```
#### Examples:
##### compiling and running a c file
```console
foo@bar:~$ ./code.sh -f main.c
Input File : main.c
C File
compiling main
gcc main.c -o main
===============
running main.c
===============
HELLO WORLD
```

##### using lpthread flag
```console
foo@bar:~$ ./code.sh -lf main.c
using lpthread flag
Input File : main.c
C File
compiling main
gcc main.c -o main -lpthread
===============
running main.c
===============
HELLO WORLD
```
##### using mpi 
```console
foo@bar:~$ ./code.sh -mf main.c
Input File : main.c
C File
compiling main
mpicc main.c -o main
===============
running main.c
===============
Enter no. of processors: 2
HELLO WORLD
HELLO WORLD
```


