#! /bin/bash

#Extract the last week of data and store the values in a file
echo $(tail -7 synthetic_historical_fc_accuracy.tsv | cut -f6) > scratch.txt

week_fc=($(echo $(cat scratch.txt)))

#validate result:
for i in {0..6}
do
	echo ${week_fc[$i]}
done

#change a sign of negative components
for i in {0..6}
do
	if [[ ${week_fc[$i]} < 0 ]]
	then
		week_fc[$i]=$(((-1)*week_fc[$i]))
	fi
	# validate result:
	echo ${week_fc[$i]}
done

#calculate mininmum and maximium accuracy for a week
minimum=${week_fc[1]}
maximum=${week_fc[1]}
for item in ${week_fc[@]}
do
	if [[ $minimum > $item ]]
	then
		minimum=$item
	fi
	if [[ $maximum < $item ]]
	then
		maximum=$item
	fi
done

echo "minimum absolute error = $minimum"
echo "maximum absolute error = $maximum"
