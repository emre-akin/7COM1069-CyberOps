#!/bin/bash
#Checking for usage error
if [ -z "$1" ]
then
    echo "Usage: my_new_whois [data file] [output file]"
    echo "Example: ./my_new_whois.sh who_is_yahoo_mnt.txt output.txt"
    echo "If no output file specified it will be automatically generated."
    exit 1
fi

#Menu of options
echo "============================================================="
echo "Please select one of the following three options to search:"
echo "============================================================="
echo "1. All unique people sorted alphabetically"
echo "2. All inetnums sorted in ascending numerical order"
echo "3. All unique netnames sorted in alphabetical order"
echo "============================================================="

#Checking for valid input
while read -p 'Select 1, 2 or 3: ' n; do    
    case $n in
        [123])
            break
            ;;
         *)
            echo 'Invalid input' >&2
    esac
done

#Option 1
if [ $n == 1 ]
then
    echo "You have selected option number 1 and are searching for unique people"
    #BONUS EXTENSION
    #Checking if the user specified an output. If not then create one.
    if [ -z "$2" ]
    then
        output="person_$(date +%Y_%m_%d_%H_%M_%S)"
        echo "Output file not specified. Generating automatically..."
    else
        output=$2
    fi

    awk '/person/ {for(i=2; i<=NF; ++i) printf "%s ", $i; print ""}' $1 | sort | uniq > $output.txt

    echo "" >> $output.txt
    printf "File created: " >> $output.txt
    date +"%Y-%m-%d.%H.%M:%S" >> $output.txt

    echo "Script completed and exported as $output.txt"

#Option 2
elif [ $n == 2 ]
then
    echo "You have selected option number 2 and are searching for inetnums"
    #BONUS EXTENSION
    #Checking if the user specified an output. If not then create one.
    if [ -z "$2" ]
    then
        output="inetnums_$(date +%Y_%m_%d_%H_%M_%S)"
        echo "Output file not specified. Generating automatically..."
    else
        output=$2
    fi

    awk '/inetnum/ {for(i=2; i<=NF; ++i) printf "%s ", $i; print ""}' $1 | sort -n | uniq > $output.txt

    echo "" >> $output.txt
    printf "File created: " >> $output.txt
    date +"%Y-%m-%d.%H.%M:%S" >> $output.txt

    echo "Script completed and exported as $output.txt"

#Option 3
elif [ $n == 3 ]
then
    echo "You have selected option number 3 and are searching for netnames"
    #BONUS EXTENSION
    #Checking if the user specified an output. If not then create one.
    if [ -z "$2" ]
    then
        output="netnames_$(date +%Y_%m_%d_%H_%M_%S)"
        echo "Output file not specified. Generating automatically..."
    else
        output=$2
    fi

    awk '/netname/ {print $2}' $1 | sort | uniq > $output.txt

    echo "" >> $output.txt
    printf "File created: " >> $output.txt
    date +"%Y-%m-%d.%H.%M:%S" >> $output.txt

    echo "Script completed and exported as $output.txt"

else
    echo "Bad input"

fi