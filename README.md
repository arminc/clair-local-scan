# Clair server

You can run a dedicated clair server with a database but if you want to run clair standalone in your CI/CD pipeline then you are in a surprise. Because starting clair from scratch takes about 20 to 30 minutes for the DB to be filled up.

The fix this problem I have created a Travis scheduled job that creates the DB daily. 

* You can find the image here https://hub.docker.com/r/arminc/clair-db 
* And you can find the Travis Job here https://travis-ci.org/arminc/clair

To be able to fill the datbase we need a clair server, for the convenience and usabillity later I am using an extended clair docker container. 

* You can find it here: https://hub.docker.com/r/arminc/clair

## How to scan containers

Start the clair db and clair

```bash
docker run -d --name db arminc/clair-db:2017-03-15
docker run -p 6060:6060 --link db:postgres -d --name clair arminc/clair:v2.0.0-rc.0
```

Having clair locally working is nice but you need to do something with it. You can either scan it with the 'official' analyze-local-images from CoreOS. Or you can use my tool that also verifies which vulnerabilities are accepted and which are nog. You can find more info here https://github.com/arminc/clair-scanner 

### Scan using analyze-local-images

```bash
analyze-local-images -endpoint http://IP:6060 -my-address IP arminc/clair-db:2017-03-15
```

### Scan using clair-scanner

TODO