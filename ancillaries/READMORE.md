# The download_file service
This service monitor a link at the inteval set in *CHECK_URL_INTERVAL* which is inside [.env](../.env). Once it detects that there's a url added to a specific DB table, it fetches it while considering that the file might be large. Once it is done, it goes back to monitoring the url once more.

You can add the url of the downloadable csv file using the route below, or through the Django Admin page on the *DownloadURL* table.

```
curl POST 'http://127.0.0.1:17002/api/download-url-data/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://docs.google.com/spreadsheet/ccc?key=0Aqg9JQbnOwBwdEZFN2JKeldGZGFzUWVrNDBsczZxLUE&single=true&gid=0&output=csv"
}'
```

Also, if you update that specific field in the DB, either through the Django Admin page or a PUT request to 

```
curl PUT 'http://127.0.0.1:17002/api/download-url-data/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://docs.google.com/spreadsheet/ccc?key=0Aqg9JQbnOwBwdEZFN2JKeldGZGFzUWVrNDBsczZxLUE&single=true&gid=0&output=csv"
}'
```

the service kicks off to check for a change in url. Once this condition is met, it downloads the new file from the new link and goes back to waiting.

# The monitor_file service
This service does the following things

1. checks for a [new file](../essential-data.csv) at a specified location which can be downloaded through the *download_file* service or
2. checks for an update to an already existing file

Once it detects any of the above conditions, it updates the essential DB table is a manner that takes into consideration of the file size and the volume of the data to process.

# Supervisor dashboard
Supervisor helps to keep things simple by offering an interface to manage these service. The url can be found at the [dev link](http://127.0.0.1:17001) or the [prodution link](http://127.0.0.1:18001).

The login details for the [dev link](dev-supervisor.conf) while the login details for the [prodution link](prod-supervisor.conf)