# Clair server or local

[![Build Status](https://travis-ci.org/arminc/clair-local-scan.svg?branch=master)](https://travis-ci.org/arminc/clair-local-scan)

CoreOs Clair <https://github.com/coreos/clair>

You can run a dedicated Clair server with a database and use that in your ci/cd pipeline but if you want to run Clair as part of your ci/cd pipeline then you are in a surprise:

* Starting Clair from scratch takes about 20 to 30 minutes because the database needs to be filled up with CVEs
* Clair needs to access the container layers and therefore you need remote access from Clair to your build job

To fix these problems I have created a Travis scheduled job that creates the database daily. This database can be used to run clair standalone in your build job. For this, to work you need Clair which can talk to a database and a database already filled with CVEs. This repository builds all of those:

* Travis Job <https://travis-ci.org/arminc/clair-local-scan>
* Clair image <https://cloud.docker.com/repository/docker/arminc/clair-local-scan>
* Prefilled Database <https://cloud.docker.com/repository/docker/arminc/clair-db>

Important: Keep in mind that you can use a new version of the database with updated vulnerabilities data. Just change the tag from '2017-03-15' to a today's date.

## How to scan containers

Start the Clair database and Clair locally or while running your job

```bash
docker run -d --name db arminc/clair-db:latest
docker run -p 6060:6060 --link db:postgres -d --name clair arminc/clair-local-scan:v2.0.6
```

Example of how to use today's date (for OSX)

```bash
docker run -d --name db arminc/clair-db:$(date +%Y-%m-%d)
```

Having Clair locally working is nice but you need to do something with it. You can use it to scan your images for vulnerabilities using my clair-scanner <https://github.com/arminc/clair-scanner>. It verifies which vulnerabilities are accepted and which are not (using a whitelist).

### Scan using clair-scanner

For more information see <https://github.com/arminc/clair-scanner>

```bash
clair-scanner nginx:1.11.6-alpine example-nginx.yaml http://YOUR_LOCAL_IP:6060 YOUR_LOCAL_IP
```
