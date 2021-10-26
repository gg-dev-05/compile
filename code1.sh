if [ $# -eq 0 ]; then
    echo "No Input File Specified"
    exit 1
fi

file="$1"

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
    echo "gcc ${fileName}.c -o ${fileName}"
    gcc ${fileName}.c -o ${fileName}
    if [ ! -f ./${fileName} ]; then
    	echo "compilation failed!!"
    else 
    	echo "==============="
    	echo "running ${file}"
    	echo "==============="

    	./${fileName} {@:2}$
    	echo
    fi
    ;;

  "cpp")
    echo "C++ File"
    echo "compiling ${fileName}"
    echo "g++ ${fileName}.cpp -o ${fileName}"
    g++ ${fileName}.cpp -o ${fileName}
    if [ ! -f ./${fileName} ]; then
    	echo "compilation failed!!"
    else 
    	echo "==============="
    	echo "running ${file}"
    	echo "==============="

    	./${fileName} {@:2}$
    	echo
    fi
    ;;

  "py")
    echo "Python File"
    python3 ${fileName}.py
    ;;

  *)
    echo "unsupported"
    ;;
esac


# Remove compiled source after running
if [ -f ./${fileName} ]; then
	rm ${fileName}
fi

# echo "compiling ${fileName}"
# echo "gcc ${fileName}.c -o ${fileName}"
# gcc ${fileName}.c -o ${fileName}
# if [ ! -f ./${fileName} ]; then
# 	echo "Compilation Failed!!"
# else 
# 	echo "==============="
# 	echo "Running ${file}"
# 	echo "==============="

# 	./${fileName} {@:2}$
# 	echo
# fi

