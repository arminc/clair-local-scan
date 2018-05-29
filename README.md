# Clair server or local

[![Build Status](https://travis-ci.org/arminc/clair-local-scan.svg?branch=master)](https://travis-ci.org/arminc/clair-local-scan)

CoreOs Clair <https://github.com/coreos/clair>, using the latest version 2.0.1

You can run a dedicated clair server with a database but if you want to run clair standalone in your CI/CD pipeline then you are in a surprise:

* Starting clair from scratch takes about 20 to 30 minutes for the DB to be filled up
* Clair needs to access the container layers and therefore you need remote access from clair to your build job

To fix these problems I have created a Travis scheduled job that creates the DB daily. This DB can be used to run clair standalone in your build job.

* You can find the image here <https://hub.docker.com/r/arminc/clair-db>
* And you can find the Travis Job here <https://travis-ci.org/arminc/clair-local-scan>

Important: Keep in mind that you can use a new version of the DB with updated vulnerabilities data. Just change the tag from '2017-03-15' to a today's date.

To be able to fill the database we need a clair server, for the convenience and later usability I am using an extended clair docker container.

* You can find it here: <https://hub.docker.com/r/arminc/clair-local-scan>

## How to scan containers

Start the clair DB and clair locally or in your job

```bash
docker run -d --name db arminc/clair-db:2017-03-15
docker run -p 6060:6060 --link db:postgres -d --name clair arminc/clair-local-scan:v2.0.3
```

Having clair locally working is nice but you need to do something with it. You can either scan it with the 'official' analyze-local-images from CoreOS, or you can use a version modified by me. My version verifies which vulnerabilities are accepted and which are not (using a whitelist). You can find more info here <https://github.com/arminc/clair-scanner>

### Scan using analyze-local-images

```bash
analyze-local-images -endpoint http://IP:6060 -my-address IP arminc/clair-db:2017-03-15
```

### Scan using clair-scanner

```bash
clair-scanner nginx:1.11.6-alpine example-nginx.yaml http://YOUR_LOCAL_IP:6060 YOUR_LOCAL_IP
```
