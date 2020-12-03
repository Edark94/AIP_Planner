#Using the Planner image on my repo to get the base image 
FROM adamfgreen/aip2020:latest
#Copy the input folder into the container and call it input e.g.
# ./input on your computer > /input on the container
COPY . /src
#Set the working directory to the input folder
WORKDIR /src

#Run the domain.pddl and problem.pddl in this folder on optic
#CMD optic domain.pddl problem.pddl

CMD fd --plan-file ./blindOutput/nomysterHmax3.txt --overall-memory-limit 6000M --overall-time-limit 1800 ./src/no-mystery-sequential-optimal/domain.pddl ./src/no-mystery-sequential-optimal/instances/instance-1.pddl --search 'astar(hmax)'

#Other software available is
# - fd
# - metricff
# - SMTPlan
# - Validate
# - enhsp
# Note all program names are case sensitive and as stated above
