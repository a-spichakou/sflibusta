from flask import Flask, request, jsonify
import requests
import zipfile
import os
import io
import xml.etree.ElementTree as ET

app = Flask(__name__)

# Solr base URL
SOLR_URL = "http://192.168.1.42:8983/solr/flibusta/select"  # Update with your Solr collection URL
#ARCHIVE_PATH = "/archives/"
ARCHIVE_PATH = "../test/"

namespaces = {
    'l': 'http://www.w3.org/1999/xlink',
    'f': 'http://www.gribuser.ru/xml/fictionbook/2.0'
}

@app.route('/search/flibusta/select', methods=['GET'])
def search_solr():
    # Get parameter for Solr search from request
    search_param = request.args.get('q')
    rows = request.args.get('rows')
    if not search_param:
        return jsonify({"error": "Missing query parameter 'q'"}), 400

    try:
        # Step 1: Make a search in Solr index by given parameter
        solr_response = requests.get(SOLR_URL, params={"q": search_param, "wt": "json", "rows": rows})
        solr_response.raise_for_status()
        solr_data = solr_response.json()
        solr_docs = solr_data.get('response', {}).get('docs', [])
        print(solr_docs)

        for doc in solr_docs:
            # Step 2: Get `archivename` and `id` attributes from Solr response
            archive_path = ARCHIVE_PATH + doc.get('archivename')[0]

            file_id = doc.get('filename')[0]

            if not archive_path or not file_id:
                continue  # Skip if attributes are missing

            # Step 3: Extract the file from ZIP archive
            with zipfile.ZipFile(archive_path, 'r') as zf:
                if file_id in zf.namelist():
                    with zf.open(file_id) as xml_file:
                        print("Opening file" + file_id)
                        xml_content = xml_file.read().decode('utf-8', errors='ignore')

                        # Step 4: Parse XML to get 'binary' node and 'content-type' attribute
                        root = ET.fromstring(xml_content)
                        cover = root.find("f:description/f:title-info/f:coverpage", namespaces)
                        binary_node = root.find("f:binary", namespaces)

                        print(binary_node)
                        if binary_node is not None:
                            binary_value = binary_node.text
                            content_type = binary_node.attrib.get("content-type")

                            # Append the extracted data to Solr JSON result
                            doc['binary'] = binary_value
                            doc['content-type'] = content_type
                        else:
                            doc['binary'] = None
                            doc['content-type'] = None

        # Step 5: Respond back with the updated Solr JSON result
        return jsonify(solr_data)

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)