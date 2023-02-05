#!/bin/bash

echo "to: $1"
echo "Subject: $2"
echo "MIME-Version: 1.0"
echo "Content-Type: text/html; charset=utf-8"

echo "
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head><title></title>
	</head>
	<body>
	<table> 
	    <tbody> "
#query=`echo -n "$3" | jq -Rsa .`
#echo "$query"

curl -s "http://192.168.88.233:8983/solr/flibusta/select" \
--data-urlencode "indent=true" \
--data-urlencode "q.op=OR" \
--data-urlencode "q=content:\"$3\"" \
--data-urlencode "rows=100" \
| jq -r '.response.docs[] | "
<tr> 
	<td><a href=\"mailto:sflibustarobot@int.pl?subject=GET:\(.id)\">\(."book-title"[0])</a></td>
	<td>\(."author-first-name"[0])\t\(."author-last-name"[0])</td>
	<td>\(."annotation"[0] // "-")</td>
</tr>"'


echo    "</tbody> 
</table>
</body>
</html>"


