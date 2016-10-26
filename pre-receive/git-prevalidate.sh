#!/bin/bash
read from_ref to_ref ref_name
#echo $@
echo $from_ref
echo $to_ref
echo $ref_name
fail=
endpoint="http://www.google.com/"
(
       	git rev-list --format=oneline $from_ref..$to_ref | sed 's/^/  /' |
		while read commit_message 
		do
			pattern="RTC-([0-9])*"
			fail_message="Rejected due to following errors"
			
			## Validate if you can find reference to a pattern
			if [[ $str_text =~ $commit_message ]]; then 
				item=${BASH_REMATCH[0]}
				## We have a item, lets use API to validate this item
				echo $item
				url_with_item=endpoint"/"$item
				echo url_with_item
			else 
				fail=1
				echo >&2 "******** Commits without reference to work item not permitted. *******" 
				# Lets just print all revisions for user to review
				echo >&2 ".. COMMITS .."
				git rev-list --format=oneline $from_ref..$to_ref | sed 's/^/  /'
				echo >&2 "**********************************************" 
				exit -1
				echo $fail
			fi
			
			## USE API to validate if 
		done
)





