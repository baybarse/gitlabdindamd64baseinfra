This image can use for gitlab ci dind based systems with aws instance based runners(or any other vm)
https://docs.gitlab.com/ee/ci/docker/using_docker_build.html#use-the-docker-executor-with-the-docker-image-docker-in-docker
dind-amd64 version is obligation for current machine(which inside of aws instance runner) architecture that's why we create this https://hub.docker.com/r/yobasystems/alpine-docker

# In Alpine Amd64 Based Image is Include These:

## Mainly
- Azure Cli
- docker
- python3
- pip

## Sidely
- bash
- git
- zip
- iptables
- ca-certificates
- e2fsprogs
- openrc


# Additional Notes
When Docker Deamon Start as service with "dockerd" command, we need to use with & "dockerd &" Also system need a systemctl or some thing for making as a service to docker openrc work for this otherwise alpine cant get services.  When deamon upping with dockerd command system show only deamon logs and cant go to apply to next script. But when we fix this with & symbol for run and just jump to next script, system is instanly run to docker commands with dependend to deamon. Sleep 15 is working for that.


### EXAMPLE:
RUN dockerd &
RUN sleep 15
RUN docker pull ...something..
RUN docker run ..something...


or gitlab-ci.yml example:

```console
<xyz>:
  image: baybarse/gitlabdindamd64baseimage:azurecliamd64basedinfra
  stage: <xyz>
  script:
  - dockerd &
  - sleep 15
  - docker pull <docker image>
  - docker run <docker image>
  - docker push <docker image>
  - az -h
```
