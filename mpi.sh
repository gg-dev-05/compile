if [ $# -eq 0 ]; then
    echo "No Input File Specified"
    exit 1
fi

file="$1"

if [ ! -f ./${file} ]; then
	echo "${file} does not exist";
	exit 1
fi

if [ ! $2 ]; then
	echo "Number of processors not specified";
	exit 1
fi

fileName=${file: 0:-2} # striping last 2 characters from file name
echo "Compiling ${fileName}"
echo "mpicc ${fileName}.c -o ${fileName}"
mpicc ${fileName}.c -o ${fileName}
if [ ! -f ./${fileName} ]; then
	echo "Compilation Failed!!"
else 
	echo "mpirun -n $2 ./${fileName}"
	echo "==============="
	echo "Running ${file}"
	echo "==============="
	echo
	echo

	mpirun -n $2 ./${fileName}
	echo
fi

if [ -f ./${fileName} ]; then
	rm ${fileName}
fi