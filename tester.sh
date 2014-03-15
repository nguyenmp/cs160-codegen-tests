#! /bin/bash

make
echo ""

if [ $? -ne 0 ]; then
  exit 1;
fi

shopt -s nullglob
filepath=(tests/*)

if [ $# -ne 0 ]; then
  filepath=($@)
fi

for file in "${filepath[@]}"
do
        echo "Testing $file"
        ./lang < "$file" 1> /dev/null 2> test.s && gcc -g -m32 -o start start.c test.s && ./start
        echo ""
done
