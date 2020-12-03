#!/bin/bash

# To run this script you need to write simply:
# sudo ./testScript.sh
#
# The output will be 1 txt file for each domain where problem 3 is solved
# using blind search. The name of the txt file will be the domain.
#
# It will also make 4 "nomysterHmax" outputs which is 4 runs of the 4'th instance
# in the no mystery domain using hmax. 

# ----------------------------------
cd ./src/
for d in */ ; do
    fullname=${d%?}
    textFile="./blindOutput/${fullname}.txt"
    cd ..
    touch $textFile
    chmod 666 $textFile
    problem="./src/${fullname}/instances/instance-3.pddl"
    domain="./src/${fullname}/domain.pddl"
    r="CMD fd --plan-file ${textFile} --overall-memory-limit 6000M --overall-time-limit 1800 ${domain} ${problem} --search 'astar(blind())'"
    sed -i "12s|.*|$r|" student.Dockerfile
    ./build.sh
    ./run.sh > $textFile
    cd ./src/
done
cd ..
for run in {0..3}; do
    fullname="nomysterHmax${run}"
    textFile="./blindOutput/${fullname}.txt"
    touch $textFile
    chmod 666 $textFile
    problem="./src/no-mystery-sequential-optimal/instances/instance-4.pddl"
    domain="./src/no-mystery-sequential-optimal/domain.pddl"
    r="CMD fd --plan-file ${textFile} --overall-memory-limit 6000M --overall-time-limit 1800 ${domain} ${problem} --search 'astar(hmax)'"
    sed -i "12s|.*|$r|" student.Dockerfile
    ./build.sh
    ./run.sh > $textFile
done
