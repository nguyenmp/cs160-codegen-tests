#! /bin/bash

noColor="\033[0m"
redColor="\033[0;31m"

make

if [ $? -ne 0 ]; then
  exit 1;
fi

shopt -s nullglob
filepath=(tests/test.*)

if [ $# -ne 0 ]; then
  filepath=($@)
fi

for file in "${filepath[@]}"
do
        echo "Testing $file"

        ./lang < "$file" 1> /dev/null 2> test.s && gcc -g -m32 -o start start.c test.s

        if [ $? -eq 0 ]; then ./start;
        else echo -e $redColor$(head -n 1 test.s)$noColor
        fi

        echo ""
done
