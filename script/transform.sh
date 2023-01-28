#!/bin/bash	
for item in ./mount/183*.fb2
do
  echo /media/usb1/work/test/output/$(basename ${item})
  xsltproc ../xslt/transform.xslt $item > /media/usb1/work/test/output/$(basename ${item}).xml
done
