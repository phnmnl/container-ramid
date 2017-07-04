#!/bin/bash

apt-get update -y && apt-get install -y --no-install-recommends wget ca-certificates

wget "https://drive.google.com/uc?export=download&id=0B2e3YmwhK4fkdjc2OGgyblVDb0k" -O exchanged.csv 
wget "https://drive.google.com/uc?export=download&id=0B2e3YmwhK4fkd2tmbkNCMVhLcmc" -O wd.zip 

runRamid.R -i exchanged.csv -z wd.zip -o out_exchanged.csv
rc=$?; 
if [[ $rc != 0 ]]; then 
	echo "R process failed with error $rc"
	exit $rc; 
fi

if [ ! -f out_exchanged.csv ]; then
   	echo "File out_exchanged.csv does not exist, failing test."
   	exit 1
fi

echo "ramid runs with test data without error codes, all expected files created."
