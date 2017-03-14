# Docker containers vulnerability scan

When you work with containers (Docker) you are not only packaging your application but also part of the OS. Therefore it is crucial to know what kind of libraries are vulnerable in you container. There are many ways to find out, you can have Docker Hub or quay.io scan your container. But what's the point in knowing if you are not acting on it, and in security means deny all until I say yes.

What does this mean? The process should look like this:

1. Build and test your application
1. Build the container
1. Test the container for vulnerabilities
1. Check the vulnerabilities against allowed ones, if everything is allowed pass, otherwise fail

The problem is that this is not easy to achieve when using the services like Docker Hub or quay.io, because they don't have an API or they trigger afterwards and making it harder to do straight forward CI-CD pipeline. (Although it is possible to achieve this with quay.io because they have an web hook that notifies you about the vulnerabilities).

## Partial Solution

CoreOS has created an awesome container scan tool (also used by quay.io) called "clair". There are three problems with clair to easily incorporate it in the 4 step plan:

1. Building the DB takes 20 to 30 minutes
1. Clair needs to access your Docker to scan the image meaning it needs to run locally or it needs to be able to access your Docker remotely
1. Clair only tells you which vulnerabilities your container has but it will not fail or succeed based on a whitelist of vulnerabilities

The fix is for the first two problems is to build the DB daily and then run clair including the DB as part of your CI-CD pipeline. But this does not solve the third problem.

Daily Clari DB image can be found here: https://hub.docker.com/r/arminc/clair-db/
The build can be found here: https://travis-ci.org/arminc/clair

For the convenience I am using an extended clair docker container.
You can find it here: https://hub.docker.com/r/arminc/clair/

## Whitelisting Solution

TODO

## How to use in Jenkins

TODO

## TODO

* Configure travis to push the image to docker hub
  * Create an extra user for docker hub
* Test scanning images