#!/bin/sh
# echo "length: ${#array[*]}"
# echo "first line:  ${array[1]}"

#echo "Enter region to copy from:"
#read region
region=`grep region ~/.aws/config | sed 's/region = //'`
echo  "Enter region (default: $region)"
read rinput

if [ -n "$rinput" ]; then
	region=$rinput
fi


echo "Region: $region \n"
echo "Available buckets: "

array=($(aws s3 ls))
length=${#array[*]}

for((i=2;i<=(($length - 1));i = i + 3))
do
	echo "${array[i]} "
done

echo "Begin copying..."
for((i=2;i<=(($length - 1));i = i + 3))
do
	echo `aws s3 sync s3://${array[i]} ./s3-backup/${array[i]} --region $region`
done

