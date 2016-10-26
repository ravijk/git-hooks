#!/bin/bash
read from_ref to_ref ref_name
#echo $@
echo $from_ref
echo $to_ref
echo $ref_name
fail=
(
       	git rev-list --format=oneline $from_ref..$to_ref | sed 's/^/  /' |
		while read commit_message 
		do
			str_text="Hello world RTC-2345 testing code"
			pattern="RTC-([0-9])*"
			fail_message="Rejected due to following errors"
			if [[ $str_text =~ $commit_message ]];
			  then 
				fail=1
				echo >&2 "*** Commits without reference to work item not permitted. ***" 
				echo $fail
			fi
		done
		
		if [$fail == 1]
		then
		  exit -1
		fi
)





