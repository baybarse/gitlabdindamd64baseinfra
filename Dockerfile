#Explanation: #:Header | ##:Subheader | ###: Normal Comment Line
### This image can use for gitlab dind based systems with aws instance based runners(or any other vm)
###https://docs.gitlab.com/ee/ci/docker/using_docker_build.html#use-the-docker-executor-with-the-docker-image-docker-in-docker
###dind-amd64 version is obligation for current machine(which inside of aws instance runner) architecture that's why we create this 
FROM yobasystems/alpine-docker:dind-amd64
### https://hub.docker.com/r/yobasystems/alpine-docker
## Normal Install Requirements
RUN apk --update add bash
RUN apk --update add git
RUN apk --update add zip
RUN apk --update add iptables
RUN apk --update add ca-certificates
RUN apk --update add e2fsprogs
## Docker Requirements
RUN apk --update add docker
## Docker Deamon Requirements
### "openrc" for adds to service abilities to alpine
RUN apk --update add openrc
### Also when Docker Deamon Start as service with "dockerd" command, we need to use with & "dockerd &"
### Additional note:Also system need a systemctl or some thing for making as a service to docker openrc work for this otherwise alpine cant get services. 
#When deamon upping with dockerd command system show only deamon logs and cant go to apply to next script. But when we fix this with & symbol for run and just jump to next script, system is instanly run to docker commands with dependend to deamon. Sleep 15 is working for that.
###---EXAMPLE---
###dockerd &
###sleep 15
###docker pull ...something..
###docker run ..something...
###---EXAMPLE---
## Python Requirements
RUN apk add --no-cache python3 
RUN if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi
## Pip Requirements
RUN python3 -m ensurepip
RUN rm -r /usr/lib/python*/ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools wheel 
RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi
## Azure CLI Requirements
RUN apk update
RUN apk upgrade
RUN apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python3-dev make
RUN pip --no-cache-dir install -U pip
RUN pip --no-cache-dir install azure-cli
RUN apk del --purge build 
