#! /bin/bash

k=$(wc -l rx_poc.log | cut -d " " -f1)

for ((i=1; i<=$k-2; i++));
do
	j=$(($i+1))
	#extract weather for yesterday
	yesterday_fc=$(tail -$j rx_poc.log | head -1 | cut -f5)

	#extract weather for today	
	today_temp=$(tail -$i rx_poc.log | head -1 | cut -f4)

	#calculate the difference between today and yesterda	yy
	accuracy=$(($yesterday_fc-$today_temp))
	echo "Accuracy is $accuracy"

	#asign a label to each forecast
	if [[ $accuracy == 1 ]] || [[ $accuracy == -1 ]]
	then
		accuracy_range=excellent
	elif [[ $accuracy == 2 ]] || [[ $accuracy == -2 ]]
	then
		accuracy_range=good
	elif [[ $accuracy == 3 ]] || [[ $accuracy == -3 ]]
	then
		accuracy_range=fair
	else
		accuracy_range=poor
	fi

	echo "Forecast accuracy is $accuracy_range"

	#append a record to the historical file	
	row=$(tail -$j rx_poc.log)
	year=$( echo $row | cut -d " " -f1)
	month=$( echo $row | cut -d " " -f2)
	day=$( echo $row | cut -d " " -f3)
	echo -e "$year\t$month\t$day\t$today_temp\t$yesterday_fc\t$accuracy\t$accuracy_range" >> historical_fc_accuracy.tsv
done
