#! /bin/bash

#creating a filename for today's weather report
today=$(date +%Y%m%d)
weather_report=raw_data_$today

#downloading the weather report for Casablanca
city=Casablanca
curl wttr.in/$city --output $weather_report

#extract row with required data
#-m 1 - only the first finding
grep "°C" $weather_report > temperatures.txt

#extract the current temperature, and store it in a variable
obs_tmp=$(cat -A temperatures.txt |head -1 | cut -d "+" -f2 | cut -d "^" -f1 )
echo "observed temperature = $obs_tmp" 

#extract tomorrow's temperature forecast for noon, and store it in a variable
fc_tmp=$(cat -A temperatures.txt | head -3 | tail -1 | cut -d "+" -f2 | cut -d "(" -f1 | cut -d "^" -f1 )
echo "fc temp = $fc_tmp"

#store the current hour, day, month, and year in corresponding shell variables
hour=$(TZ='Morocco/Casablanca' date -u +%H)
day=$(TZ='Morocco/Casablanca' date -u +%d)
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)

#merge the fields into a tab-delimited record
printf "$year\t$month\t$day\t$obs_tmp\t$fc_tmp" >> rx_poc.log

