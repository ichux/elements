# Project of elements dot nl
This project makes the following assumptions.
1. Your PC is Unix/Linux variant
2. You have `curl`, `docker` and `docker-compose` installed and working on your PC
3. You can decide to build docker containers for development or production

# Working routes
Here is a [postman collection](https://www.getpostman.com/collections/d8ce3eaf19e7032160f4) link if you want to import the collections at once.

OR

You can call these with *curl*:

```
curl 'http://127.0.0.1:17002/api/'
curl 'http://127.0.0.1:17002/api/download-url/'

curl --location --request POST 'http://127.0.0.1:17002/api/download-url-data/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://docs.google.com/spreadsheet/ccc?key=0Aqg9JQbnOwBwdEZFN2JKeldGZGFzUWVrNDBsczZxLUE&single=true&gid=0&output=csv"
}'

curl --location --request PUT 'http://127.0.0.1:17002/api/download-url-data/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://docs.google.com/spreadsheet/ccc?key=0Aqg9JQbnOwBwdEZFN2JKeldGZGFzUWVrNDBsczZxLUE&single=true&gid=0&output=csv"
}'

curl 'http://127.0.0.1:17002/api/prime/'
curl 'http://127.0.0.1:17002/api/csv/'
curl 'http://127.0.0.1:17002/api/csv/?limit=10&offset=10'
curl 'http://127.0.0.1:17002/api/csv/1/'
```

# How to set up this project
Please ensure that you follow this process to the latter for it to run as expected.
Type *make bootstrap* as the first command to ensure some necessary files are created for this project to work.

> Set Up for Development
1. type _make build c=dev_
2. to run test: type _make tests c=dev_
3. to create *Super User*: type _make admin c=dev_

> Set Up for Production
1. follow the same steps as outlined in the *Set Up for Development* section but
2. replace *dev* that appears in the *Set Up for Development* section with *prod* e.g. _make tests c=dev_ will become _make tests c=prod_

# Essential files
*make bootstrap* is meant to create two essential files: *.env* and *core/per_settings.py*. Feel free to alter these files to taste.

And be careful not to run it more than once as it overwrites whatever is inside *.env* and *core/per_settings.py*

> the .env file
It contains variables used by both Django and Docker to ensure the app works well.

And

> the core/per_settings.py file
It contains exactly the same thing in core/settings.py and more. Plus you can add other necessary variables to taste.

# The included Makefile
Type *make* on your terminal, while inside the directory that contains this code and see the help it offers. Plus, there are examples of how to use some necessary commands contained in it.
