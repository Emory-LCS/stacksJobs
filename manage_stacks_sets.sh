#!/bin/bash

function run_scripts {
    cat ${add_members} |\
    while read line; do
        if [ ${line} != "end" ]; then
            ruby ${create_set}
            ruby ${add_barcodes}
            ruby ${run_job} ${library}
            ruby ${delete_set}
        else
            echo "no barcodes found"
            exit 1
        fi
    done
}

stacks_api="/home/alex/stacksJobs/stacks_apis.rb"
create_set="/home/alex/stacksJobs/create_stacks_set.rb"
delete_set="/home/alex/stacksJobs/delete_stacks_set.rb"
add_barcodes="/home/alex/stacksJobs/add_barcodes_to_set.rb"
run_job="/home/alex/stacksJobs/run_stacks_job.rb"
add_members="/home/alex/stacksJobs/files/addMembers.xml"
set_id_file="/home/alex/stacksJobs/files/setId"

#Robert W. Woodruff
ruby ${stacks_api} "univ" > ${add_members}
library="univ"
run_scripts
#Business
ruby ${stacks_api} "bus" > ${add_members}
library="bus"
run_scripts
#SciCom
ruby ${stacks_api} "chem" > ${add_members}
library="chem"
run_scripts
#Health
ruby ${stacks_api} "hlth" > ${add_members}
library="hlth"
run_scripts
#Library Service Center
ruby ${stacks_api} "lsc" > ${add_members}
library="lsc"
run_scripts
#Music and Media
ruby ${stacks_api} "musme" > ${add_members}
library="musme"
run_scripts
ruby ${stacks_api} "wd" > ${add_members}
library="wd"
run_scripts

exit 0
