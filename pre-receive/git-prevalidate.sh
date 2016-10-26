#!/bin/bash
read from_ref to_ref ref_name
#echo $@
echo $from_ref
echo $to_ref
echo $ref_name
fail=
endpoint="https://github.com/ravijk/git-hooks/blob/master/README.md/"
(
       	git rev-list --format=oneline $from_ref..$to_ref | sed 's/^/  /' |
		while read commit_message 
		do
			pattern="RTC-([0-9])*"
			fail_message="Rejected due to following errors"
			
			## Validate if you can find reference to a pattern
			if [[ $commit_message =~ $pattern ]]; then 
				item=${BASH_REMATCH[0]}
				## We have a item, lets use API to validate this item
				url_with_item=$endpoint$item
				echo $url_with_item
				
				status=$(curl -s --head $url_with_item | head -n 1 )
				echo $status
				if [[ $stauts =~ "200 OK" ]]; then 
					echo "Work item :" $item " Validated = OK"
					
					#API returns 200 OK, don't do anything
				else 
					echo >&2 "Unable to validate item: " $item 
					echo >&2 $url_with_item ." returns " .$status
					exit -1
				fi	
			else 
				fail=1
				echo >&2 "*** Commits without reference to work item not permitted. ***" 
				echo >&2 $commit_message 
				url_with_item=endpoint + $item
				echo $url_with_item
				exit -1
				echo $fail
			fi
			
			## USE API to validate if 
		done
)





