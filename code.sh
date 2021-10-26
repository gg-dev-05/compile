#!/bin/bash
usage="$(basename "$0") [-ld] [-f filename] -- compile c, cpp files 

where:
    -h  display help 
    -l  use -lpthread flag while compiling
    -d  don't delete the compiled file
    -m  compile using mpi
    -f  specify input file"

while getopts ":hf:ldm" opt; do
  case $opt in
    h) 
      echo "$usage"
      exit
      ;;
    f)
      echo "Input File : $OPTARG" >&2
      file=$OPTARG
      ;;
    l)
      echo "using lpthread flag"
      lpthread=1
      ;;
    d) 
      not_delete=1
      ;;
    m) 
      mpi=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "-f requires an input file" >&2
      exit 1
      ;;
  esac
done

if [ -z "$file" ]
then
  echo "$usage"
  echo "Please specify an input file using -f flag"
  echo "For eg. $ ./$(basename "$0") -f main.c"
  exit
fi

if [ ! -f ./${file} ]; then
	echo "${file} does not exist";
	exit 1
fi

extension="${file##*.}"
fileName="${file%.*}"


case $extension in

  "c")
    echo "C File"
    echo "compiling ${fileName}"

    if [ ! -z "$mpi" ]; then
      echo "mpicc ${fileName}.c -o ${fileName}"
      mpicc ${fileName}.c -o ${fileName}
    else
      if [ -z "$lpthread" ]; then
        echo "gcc ${fileName}.c -o ${fileName}"
        gcc ${fileName}.c -o ${fileName}
      else
        echo "gcc ${fileName}.c -o ${fileName} -lpthread"
        gcc ${fileName}.c -o ${fileName} -lpthread
      fi
    fi


    if [ ! -f ./${fileName} ]; then
    	echo "compilation failed!!"
    else 
    	echo "==============="
    	echo "running ${file}"
    	echo "==============="

      if [ ! -z "$mpi" ]; then
        read -p "Enter no. of processors: " processors
        mpirun -n $processors ./${fileName}
        echo
      else
        ./${fileName} ${@:3}
        echo
      fi
    fi
    ;;

  "cpp")

    echo "C++ File"
    echo "compiling ${fileName}"

    if [ ! -z "$mpi" ]; then
      echo "mpic++ ${fileName}.cpp -o ${fileName}"
      mpic++ ${fileName}.cpp -o ${fileName}
    else
      if [ -z "$lpthread" ]; then
        echo "g++ ${fileName}.cpp -o ${fileName}"
        g++ ${fileName}.cpp -o ${fileName}
      else
        echo "g++ ${fileName}.cpp -o ${fileName} -lpthread"
        g++ ${fileName}.cpp -o ${fileName} -lpthread
      fi
    fi


    if [ ! -f ./${fileName} ]; then
    	echo "compilation failed!!"
    else 
    	echo "==============="
    	echo "running ${file}"
    	echo "==============="

      if [ ! -z "$mpi" ]; then
        read -p "Enter no. of processors: " processors
        mpirun -n $processors ./${fileName}
        echo
      else
        ./${fileName} ${@:3}
        echo
      fi
    fi
    ;;

  *)
    echo "unsupported file format"
    echo "Can compile only c and cpp files"
    ;;
esac

# Remove compiled source after running
if [ -z "$not_delete" ]
then
  if [ -f ./${fileName} ]; then
    rm ${fileName}
  fi
fi


