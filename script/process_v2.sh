#!/bin/bash	
archivepath=$1
outputpath=$2

for item in $archivepath/*.zip
do
  echo $(basename ${item})
  mkdir $outputpath/$(basename ${item})
  for zipfile in `zipinfo -1 ${item}`
  do    
	if [ -f "$outputpath/$(basename ${item})/${zipfile}.xml" ]; then
		echo "$outputpath/$(basename ${item})/${zipfile}.xml exists."
	else 
		echo ${item}/${zipfile}
		unzip -p ${item} ${zipfile} > /tmp/${zipfile}
		xsltproc --stringparam archivename $(basename ${item}) --stringparam filename ${zipfile} ./xslt/transform.xslt /tmp/${zipfile} > $outputpath/$(basename ${item})/${zipfile}.xml
		rm /tmp/${zipfile}
	fi
  done
done
