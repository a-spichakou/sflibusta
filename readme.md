`fuse-zip /media/usb1/fb2.Flibusta.Net/f.fb2-183066-183652.zip ./mount`
`fusermount -u ./mount`

`bin/solr start`
`bin/solr create -c flibusta`
`bin/post -c flibusta /Volumes/media/usb1/work/test/output/*.xml`

