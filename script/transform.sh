#!/bin/bash	
for item in ./mount/*.fb2
do
  echo ./output/$(basename ${item})
  xsltproc --stringparam archivename f.fb2-183066-183652.zip --stringparam filename $(basename ${item}) ./xslt/transform.xslt  $item > /media/usb1/work/test/output/$(basename ${item}).xml
done
