#!/bin/bash	
for item in /media/usb1/fb2.Flibusta.Net/*.zip
do
  echo $(basename ${item})
  mkdir /media/usb1/work/test/xsltoutput/$(basename ${item})
  for zipfile in `zipinfo -1 ${item}`
  do    
	if [ -f "/media/usb1/work/test/xsltoutput/$(basename ${item})/${zipfile}.xml" ]; then
		echo "/media/usb1/work/test/xsltoutput/$(basename ${item})/${zipfile}.xml exists."
	else 
		echo ${item}/${zipfile}
		unzip -p ${item} ${zipfile} > /media/usb1/work/test/tmp/${zipfile}
		xsltproc --stringparam archivename $(basename ${item}) --stringparam filename ${zipfile} ./xslt/transform.xslt /media/usb1/work/test/tmp/${zipfile} > /media/usb1/work/test/xsltoutput/$(basename ${item})/${zipfile}.xml
		rm /media/usb1/work/test/tmp/${zipfile}
	fi
  done
done
