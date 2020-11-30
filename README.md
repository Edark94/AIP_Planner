# AIP_Planner
For coursework in 2020 AIP to test and run domains taken from the 2011 IPC

Read the instructions in TestScript.sh to run tests for your domain. Output (plans) will be saved in your domains hmax folder.
Each solution for each problem will be saved in the domains corresponding folder, either hmax or merge_and_shrink. Text is
filtered to only show the relevant part is a solution is found.

# Planning tools
The docker and planner is taken from the following repo, which runs using Docker and is based on 
https://github.com/nergmada/aip-tools-2020
Which itself is based on Fast Downward:
http://www.fast-downward.org/HomePage

The only thing I've added is the 2011 IPC problems and domains suitable for admissable heuristcs and setting up the file
directory and the script "testScript.sh", which allows one to pick a domain and planners and run each problem with your own settings.

