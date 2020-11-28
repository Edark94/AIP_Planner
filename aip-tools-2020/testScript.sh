
#!/bin/bash


# To run this script you need to change the following:
# 1: Set path to your domain by changing the path var.
#
# 2: Set planner to whicher you want to test.
#    For hmax it is simply "hmax()"
#    Default is merge and shrink with recommended settings taken
#    from http://www.fast-downward.org/Doc/Evaluator#FF_heuristic
#
# 3: Set folder to the correct one.
#    For hmax it is "hmax".
#    For merge_and_shrink it is "merge_and_shrink"
#
# 4: Set time, default 900s (15m).
#
# To run this script you need to write simply:
# sudo ./testScript.sh
# and it will start going through each problem 1 by 1.

# ------------ SETTINGS ------------

time='10s'
path='./src/barman-sequential-optimal/'
planner='merge_and_shrink(shrink_strategy=shrink_bisimulation(greedy=false),merge_strategy=merge_sccs(order_of_sccs=topological,merge_selector=score_based_filtering(scoring_functions=[goal_relevance,dfp,total_order])),label_reduction=exact(before_shrinking=true,before_merging=false),max_states=50k,threshold_before_merge=1)'
folder='merge_and_shrink'

# ---------------------------------- 

domain="${path}domain.pddl"
for i in $path'instances/'*-10.pddl;
do
    noExtension=${i%.pddl}
    name=${noExtension##*/}
    fullname=${path}"${folder}/"${name}.txt
    touch $fullname
    chmod 666 $fullname
    r="CMD fd --plan-file ${fullname} --overall-time-limit ${time} ${domain} ${i} --search 'astar(${planner})'"
    sed -i "12s|.*|$r|" student.Dockerfile
    ./build.sh
    ./run.sh > plan.txt
    # grep -Fxq "Time limit has been reached." plan.ttx
    if grep -q "Time limit has been reached." plan.txt
    then
        tail -n 7 plan.txt > $fullname
    else
        from1=Solution; to2=exit; a="$(cat plan.txt)"; a="$(echo "${a#*"$from1"}")"; echo "$from1${a%%"$to2"*}$to2" > $fullname
    fi
done
