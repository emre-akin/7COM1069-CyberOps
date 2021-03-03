#!/bin/bash

#### task 1 ####
function task1_q1 {
	echo "Hello everyone!"
}

function task1_q2 {
	read -p "Please enter your name: " name
	echo "Welcome, $name, to my Cyber Operations assessment"
}

function task1_q3 {
	read -p "Please enter the first number: " num_a
	read -p "Please enter the second number: " num_b
	total=$(($num_a * $num_b))
	echo $total
}

function task1_q4 {
	read -p "Enter a value between 1 and 100: " num_c
	if [[ $num_c -lt 50 ]]
	then
		echo "Failed"
	elif [[ $num_c -ge 50 ]]
	then
		echo "Passed"
	fi
}

function task1_q5 {
	read -p "Enter a file name: " file_name
	if [[ -f $file_name ]]
	then
		echo "The file already exists"
	else
		touch $file_name
	fi
}

#### task 2 ####
function task2_q1 {
	read -p "Enter a directory to search: " directory_name
	if [[ -d $directory_name ]]
	then
		cd $directory_name
		ls | grep .txt
		cd ..
	fi
}

function task2_q2 {
	cat dig_google.txt | grep SERVER: | cut -d: -f2 | sed 's/ //' | cut -d'(' -f1
}

function task2_q3 {
	for i in $(cat urls.txt)
	do
		read -p "$i y or n: " ans
		if [[ $ans == "y" ]]
		then
			echo $i >> saved_domains.txt
		fi
	done
}

function task2_q4 {
	#For sort command, Referance: https://www.madboa.com/geek/sort-addr/
	cat ips.txt | grep '^127' | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 > loopback_ips.txt
	cat ips.txt | grep '^162' | sort -u -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 > suspect_ips.txt
	cat ips.txt | grep '^175' | sort -u -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 >> suspect_ips.txt
}

#### task 3 ####
function task3_q1 {
	#regex referance: https://www.rexegg.com/regex-quickstart.html
	cat webpage.html | grep -E -o '[A-Za-z0-9._%+-]+@[A-Za-z0-9]+[.]+[A-Za-z]{2,3}+[^.\"]' | sort > emails.txt

	cat webpage.html | grep -o '[0-9]\{5\}\s[0-9]\{6\}' > numbers.txt
	cat webpage.html | grep -o '([0-9]\{5\})\s[0-9]\{6\}' >> numbers.txt
	cat webpage.html | grep -o '([0-9]\{5\})[0-9]\{6\}' >> numbers.txt
}


function task3_q2 {
	myArray=()

	if [[ -f averages.txt ]]
	then
		rm averages.txt
	fi

	if [[ -f login.txt ]]
	then
		rm login.txt
	fi

	avg=0

	avgWed=0
	userCount=0

	superUserCount=0
	avgSuper=0

	for i in $(cat user-list.txt | sed 's/ //g' | sed 's/,/\n/g')
	do
		myArray+=($i)
	done

	for i in "${!myArray[@]}"
	do
		if [[ i -gt 6 ]]
		then
			if [[ $((i%7)) == 0 ]]
			then
				#Question 1
				avg=$(bc <<< "scale=1; (${myArray[i+2]}+${myArray[i+3]}+${myArray[i+4]}+${myArray[i+5]}+${myArray[i+6]})/5")
				echo "${myArray[i+1]}" $avg | sed 's/\.0//' >> averages.txt

				#Question 2
				avgWed=$((avgWed+${myArray[i+4]}))
				userCount=$((userCount+1))

				#Question 3
				userId=$(echo ${myArray[i+1]} | sed 's/User//')
				if [[ $((userId%2)) == 0 ]]
				then
					avgSuper=$(bc <<< "scale=2; $avg+$avgSuper")
					superUserCount=$((superUserCount+1))
				fi

				#Question 4
				if [[ ${myArray[i+2]} != 0 ]]
				then
					echo ${myArray[i+1]} >> login.txt
				fi
			fi
		fi
	done

	#Question 1
	sort -n -k 2,2 averages.txt -o averages.txt
	#Question 2
	bc <<< "scale=1; $avgWed/$userCount" | sed 's/\.0//' > wednesday.txt
	#Question 3
	bc <<< "scale=2; $avgSuper/$superUserCount" | sed 's/\.0//' > superuser.txt
	#Question 4
	sort -V login.txt -o login.txt
}

##### Execute your functions below this comment (do not delete this comment) ######

task1_q1
task1_q2
task1_q3
task1_q4
task1_q5
task2_q1
task2_q2
task2_q3
task2_q4
task3_q1
task3_q2


######### DO NOT PUT ANYTHING BELOW THIS COMMENT ##########