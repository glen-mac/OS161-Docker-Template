#!/bin/bash
echo "Enter the assignment number (ONLY number) [ENTER]:"
read num
echo "CSE Username:" 
read name
echo "Downloading the asst"
scp -r $name@login.cse.unsw.edu.au:/home/cs3231/assigns/asst$num/src .
sed -i -e "s/ASST[0-9]/ASST$num/g" Dockerfile bashrc
sed -i -e "s/asst[0-9]/asst$num/g" Dockerfile bashrc
docker build . -t "os161-ass$num"
rm -rf src/
