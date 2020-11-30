#Using the Planner image on my repo to get the base image 
FROM adamfgreen/aip2020:latest
#Copy the input folder into the container and call it input e.g.
# ./input on your computer > /input on the container
COPY . /src
#Set the working directory to the input folder
WORKDIR /src

#Run the domain.pddl and problem.pddl in this folder on optic
#CMD optic domain.pddl problem.pddl

CMD fd --plan-file ./src/floor-tile-sequential-optimal/merge_and_shrink/instance-1.txt --overall-time-limit 1800s ./src/floor-tile-sequential-optimal/domain.pddl ./src/floor-tile-sequential-optimal/instances/instance-1.pddl --search 'astar(merge_and_shrink(shrink_strategy=shrink_bisimulation(greedy=false),merge_strategy=merge_sccs(order_of_sccs=topological,merge_selector=score_based_filtering(scoring_functions=[goal_relevance,dfp,total_order])),label_reduction=exact(before_shrinking=true,before_merging=false),max_states=50k,threshold_before_merge=1))'

#Other software available is
# - fd
# - metricff
# - SMTPlan
# - Validate
# - enhsp
# Note all program names are case sensitive and as stated above
