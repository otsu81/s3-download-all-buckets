#!/bin/sh

#Read region
region=`grep region ~/.aws/config | sed 's/region = //'`
echo  "Enter region (default: $region)"
read rinput

if [ -n "$rinput" ]; then
	region=$rinput
fi

# display which region will be used for S3 sync
echo "Region: $region \n"

# list all buckets available to the region
echo "Available buckets: "

array=($(aws s3 ls))
length=${#array[*]}

for((i=2;i<=(($length - 1));i = i + 3))
do
	echo "${array[i]} "
done

# Begin copying all files from the buckets in the array
echo "Begin copying..."
for((i=2;i<=(($length - 1));i = i + 3))
do
	echo `aws s3 sync s3://${array[i]} ./s3-backup/${array[i]} --region $region`
done

