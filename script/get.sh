#!/bin/bash
archivedir="/media/homelib/fb2.Flibusta.Net"
maildir="/home/inferno/mail/new"
scriptdir="/home/inferno/work/sflibusta/script/"
solrurl="http://localhost:8983/solr/flibusta/select"
tempdir="/tmp/sflibusta"

if [[ ! -e $tempdir ]]; then
    mkdir $tempdir
elif [[ ! -d $tempdir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi


getmail 

if [ -n "$(ls -A $maildir 2>/dev/null)" ]
then
  echo "Has new messages"
else
  echo "Has no new messages"
  exit 0
fi


for mail in $maildir/*
do
	subject=`cat $mail | formail -x Subject | perl -MEncode -ne 'print encode("UTF8",decode("MIME-Header",$_))' | xargs`
	from=`cat $mail | formail -x From`
	sender=($from)

	echo "Subject: $subject"
	echo "Sender: $sender"

	if [ ${subject:0:3} = "GET" ]
	then
		docid=`echo ${subject:4} | sed 's/[[:space:]]//g' | base64 --decode`
		echo $docid

		searchResp=`curl -s $solrurl \
		--data-urlencode "indent=true" \
		--data-urlencode "q.op=OR" \
		--data-urlencode "q=id:\"$docid\"" \
		--data-urlencode "rows=1"`

		filePath=`echo $searchResp | jq -r '.response.docs[] | "\(.archivename[0])/\(.filename[0])"'`
		bookTitle=`echo $searchResp | jq -r '.response.docs[] | "\(."book-title"[0])"'`
		bookAuthor=`echo $searchResp | jq -r '.response.docs[] | "\(."author-first-name"[0]) \(."author-last-name"[0])"'`

		for bookInfo in "$filePath"
		do
			echo "Book title: $bookTitle"
			targetFilename="$bookAuthor.$bookTitle"

			archive=$archivedir/$(dirname "${filePath}")
			bookfile=$(basename ${filePath})
			echo "Archive path: " $archive
			echo "Book file path: " $bookfile
			unzip -p $archive $bookfile > $tempdir/$bookfile
			ebook-convert $tempdir/$bookfile "$tempdir/$targetFilename.epub"
			mpack -s "$targetFilename" -c application/octet-stream "$tempdir/$targetFilename.epub" $sender
			rm $tempdir/*
		done
	else
		$scriptdir/search.sh $sender "RE: $subject" "$subject" > $tempdir/body.html
		ssmtp -t < $tempdir/body.html
		rm $tempdir/*
	fi
	rm $mail
done


