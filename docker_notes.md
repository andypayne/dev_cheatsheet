# Notes on Docker


## Installing on Linux - Ubuntu 18.04

This is mostly based on a [DigitalOcean guide to Docker on Ubuntu
18.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04).

Double-check the OS version:
```shell
lsb_release -a
```

Install dependencies:
```shell
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

Install Docker's apt key:
```shell
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Add the apt repository:
```shell
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
```

Update again:
```shell
sudo apt update
```

Check that the `docker-ce` package will install from docker.com and not from the
official Ubuntu repo:
```shell
apt-cache policy docker-ce
```

Install:
```shell
sudo apt install docker-ce
```

Check that the server is running:
```shell
sudo systemctl status docker
```

Output on my system (with some warnings):
```shell
● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
   Active: active (running) since Thu 2020-04-23 07:50:07 PDT; 2h 14min ago
     Docs: https://docs.docker.com
 Main PID: 21345 (dockerd)
    Tasks: 20
   CGroup: /system.slice/docker.service
           └─21345 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

Apr 23 07:50:07 blade dockerd[21345]: time="2020-04-23T07:50:07.198531630-07:00" level=warning msg="Your kernel does not support swap memory limit"
Apr 23 07:50:07 blade dockerd[21345]: time="2020-04-23T07:50:07.198548210-07:00" level=warning msg="Your kernel does not support cgroup rt period"
Apr 23 07:50:07 blade dockerd[21345]: time="2020-04-23T07:50:07.198552873-07:00" level=warning msg="Your kernel does not support cgroup rt runtime"
Apr 23 07:50:07 blade dockerd[21345]: time="2020-04-23T07:50:07.198651218-07:00" level=info msg="Loading containers: start."
Apr 23 07:50:07 blade dockerd[21345]: time="2020-04-23T07:50:07.550205585-07:00" level=info msg="Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can be used to set a preferred IP address"
Apr 23 07:50:07 blade dockerd[21345]: time="2020-04-23T07:50:07.903106175-07:00" level=info msg="Loading containers: done."
Apr 23 07:50:07 blade dockerd[21345]: time="2020-04-23T07:50:07.960027233-07:00" level=info msg="Docker daemon" commit=afacb8b7f0 graphdriver(s)=overlay2 version=19.03.8
Apr 23 07:50:07 blade dockerd[21345]: time="2020-04-23T07:50:07.960099546-07:00" level=info msg="Daemon has completed initialization"
Apr 23 07:50:07 blade dockerd[21345]: time="2020-04-23T07:50:07.990255707-07:00" level=info msg="API listen on /var/run/docker.sock"
Apr 23 07:50:07 blade systemd[1]: Started Docker Application Container Engine.
```

And it should be installed:
```shell
which docker
```

Add your user to the docker group to avoid requiring sudo, and then login:
```shell
sudo usermod -aG docker ${USER}
su - ${USER}
```

Now `docker ps` succeeds, for example:
```shell
docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED         STATUS              PORTS               NAMES
```

And docker's hello-world image runs:
```shell
docker run hello-world

Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
0e03bdcc26d7: Pull complete
Digest: sha256:6a65f928fb91fcfbc963f7aa6d57c8eeb426ad9a20c7ee045538ef34847f44f1
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

```


## Build/Run

Here's a simple example Dockerfile for Alpine Linux for Go:

```
FROM golang:alpine
RUN apk add --no-cache git
```

To build:
```shell
docker build .
```

Then the image should be listed:
```shell
docker images
REPOSITORY          TAG                 IMAGE ID            CREATED        SIZE
golang              alpine              3289bf11c284        2 weeks ago    370MB
hello-world         latest              bf756fb1ae65        5 months ago   13.3kB
...
```

Then run:
```shell
docker run -it 3289bf11c284
```

And you should get a shell.
```shell
/go # which git
/usr/bin/git
```

Another example Dockerfile that sets up a user and project location:
```
FROM golang:alpine

# Install git for go dependencies
RUN apk add --no-cache git

ENV user andy
ENV proj_path /gomicro/

# Run as non-root
RUN adduser -D -u 10000 $user
RUN mkdir $proj_path && chown $user $proj_path
USER $user

WORKDIR $proj_path
ADD . $proj_path
```

```shell
docker build -f ./Dockerfile -t alpine-proj .
```


## Networking

If the Dockerfile exposes a port, for example:
```
ENV port=8080
...
EXPOSE $port
```

Then by default the service will listen on the `bridge` network. To see the
networks:
```shell
docker network ls

NETWORK ID          NAME                DRIVER              SCOPE
1046046eb833        bridge              bridge              local
e236b58c33ac        host                host                local
04c75d4451f1        none                null                local
```

To see the IP addresses and containers connected to the network:
```shell
docker network inspect bridge

[
    {
        "Name": "bridge",
        "Id": "2042047ebf33a207279b01cb2d043ea214ca637d17cf1f4d7585054ba1576023",
        "Created": "2020-06-23T08:01:54.40621988-07:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "772d0a3cec5b8f2cc06d719af9c2e34c1a9fe946fa3b611384a0b02c3a30e093": {
                "Name": "practical_leavitt",
                "EndpointID": "89c9353f7cdc8966d54415faeb5370347a11bbcc0cf6cb5fdfd3732f061060f5",
                "MacAddress": "03:24:ad:11:01:17",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]
```

This shows that the host container will be listening on `172.17.0.2:8080`.


## Docker on Mac

### Old notes

Remember to unset/remove env vars that mess with things.

```shell
docker build -f Dockerfile -t img-name .
ERRO[0000] failed to dial gRPC: unable to upgrade to h2c, received 502
context canceled
```

To address this, enable experimental features in Docker on Mac. This may no longer be necessary.

