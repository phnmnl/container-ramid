#!/bin/bash

apt-get update -y && apt-get install -y --no-install-recommends wget ca-certificates

wget "https://drive.google.com/uc?export=download&id=0B1lAg6jyw6lvc3dvOHhZSzI4Mms" -O exchanged.csv 
wget "https://drive.google.com/uc?export=download&id=0B1lAg6jyw6lvZkpjOTdXdGlvZlU" -O wd.zip 

runRamid.R -i exchanged.csv -o out_exchanged.csv -z wd.zip
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
