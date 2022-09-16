# elements.nl
This project makes the following assumptions.
1. Your PC is Unix/Linux variant
2. You have `curl`, `docker` and `docker-compose` installed and working on your PC
3. You can decide to build docker containers for development or production

# Working routes
Here is a [postman collection](https://www.getpostman.com/collections/d8ce3eaf19e7032160f4) 
link if you want to import the collections at once.

OR

You can call these with *curl*:

```
curl -s 'http://127.0.0.1:18003/api/'
curl -s 'http://127.0.0.1:18003/api/download-url/'

curl -XPOST 'http://127.0.0.1:18003/api/download-url-data/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://docs.google.com/spreadsheets/d/e/2PACX-1vQCWpPxfs56UYwEn2wooltUmA7L1gjzLeuG3MixbhA1XxkBI3eIlFbKN0-xXvtpwhGUx_ERY3VZq7zD/pub?gid=217478775&single=true&output=csv"
}'


curl -XPUT 'http://127.0.0.1:18003/api/download-url-data/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://docs.google.com/spreadsheets/d/e/2PACX-1vQCWpPxfs56UYwEn2wooltUmA7L1gjzLeuG3MixbhA1XxkBI3eIlFbKN0-xXvtpwhGUx_ERY3VZq7zD/pub?gid=217478775&single=true&output=csv"
}'

curl -s 'http://127.0.0.1:18003/api/prime/'
curl -s 'http://127.0.0.1:18003/api/csv/'
curl -s 'http://127.0.0.1:18003/api/csv/?limit=10&offset=10'
curl -s 'http://127.0.0.1:18003/api/csv/1/'
```

# How to set up this project
Please ensure that you follow this process to the latter for it to run as expected.
1. Type *make bootstrap* as the first command to ensure a necessary file is created for this project to work.
2. Type

```
# note that you should change '192.168.8.1' and '192.168.8.0/24' to your IP, probably a Home Router IP
docker network create --gateway 192.168.8.1 --subnet 192.168.8.0/24 elements
```
3. On *Line 23* of *dev-docker-compose.yml* change the IP address there to taste.


> Set Up for Development
1. type _make build c=dev_
2. to run test: type _make tests c=dev_
3. to create *Super User*: type _make admin c=dev_

> Set Up for Production
1. follow the same steps as outlined in the *Set Up for Development* section but
2. replace *dev* that appears in the *Set Up for Development* section with *prod* 
3. e.g. _make tests c=dev_ will become _make tests c=prod_

# Essential files
*make bootstrap* is meant to create an essential file: *.env*. Feel free to alter these files to taste.

And be careful not to run it more than once as it overwrites whatever is inside the *.env*

> the .env file:
It contains variables used by both Django and Docker to ensure the app works well.

# The included Makefile
Type *make* on your terminal, while inside the directory that contains this code and see the help it offers. 
Plus, there are examples of how to use some necessary commands contained in it.

# How this project works
There are 2 monitoring services: download_file and monitor_file. And you can see them and monitor, restart, 
see their log details, etc by visiting the [dev link](http://127.0.0.1:17001) or 
the [prodution link](http://127.0.0.1:18003).

[Read more](ancillaries/READMORE.md) about this project.
