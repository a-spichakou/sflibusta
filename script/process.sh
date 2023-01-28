#!/bin/bash	
for item in /media/usb1/fb2.Flibusta.Net/*.zip
do
  echo $(basename ${item})
  fuse-zip ${item} ./mount
  ./script/transform.sh $(basename ${item})
  fusermount -u ./mount
done
