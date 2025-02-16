#!/bin/bash
solrurl="http://localhost:8983/solr/flibusta/select"

echo "to: $1"
echo "Subject: $2"
echo "MIME-Version: 1.0"
echo "Content-Type: text/html; charset=utf-8"

echo "
<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd\">
  <head>
    <meta charset="UTF-8">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Email Table</title>
  </head>
<body>
    <table style=\"border-collapse: collapse; width: 100%; max-width: 600px; margin: 0 auto; font-family: Arial, sans-serif; font-size: 14px; color: #333;\">
      <thead>
        <tr>
          <th style=\"border: 1px solid #ddd; padding: 8px; background-color: #f4f4f4; text-align: left;  width: 10%;\">Book</th>
          <th style=\"border: 1px solid #ddd; padding: 8px; background-color: #f4f4f4; text-align: left;  width: 10%;\">Author</th>
          <th style=\"border: 1px solid #ddd; padding: 8px; background-color: #f4f4f4; text-align: left;  width: 80%;\">Description</th>
        </tr>
      </thead>
      <tbody>"

curl -s $solrurl \
--data-urlencode "indent=true" \
--data-urlencode "q.op=OR" \
--data-urlencode "q=content:\"$3\"" \
--data-urlencode "rows=100" \
| jq -r '.response.docs[] | "
<tr> 
	<td style=\"border: 1px solid #ddd; padding: 8px;\"><a href=\"mailto:sflibustarobot@int.pl?subject=GET:\(.id | @base64)\">\(."book-title"[0])</a></td>
	<td style=\"border: 1px solid #ddd; padding: 8px;\">\(."author-first-name"[0])\t\(."author-last-name"[0])</td>
	<td style=\"border: 1px solid #ddd; padding: 8px;\">\(."annotation"[0] // "-")</td>
</tr>"'


echo    "  </tbody>
             </table>
           </body>
         </html>"


