#!/bin/bash	
mkdir /media/usb1/work/test/output/$1
for item in ./mount/*.fb2
do
  echo /media/usb1/work/test/output/$1/$(basename ${item}).xml
  xsltproc --stringparam archivename f.fb2-183066-183652.zip --stringparam filename $(basename ${item}) ./xslt/transform.xslt  $item > /media/usb1/work/test/output/$1/$(basename ${item}).xml
done
