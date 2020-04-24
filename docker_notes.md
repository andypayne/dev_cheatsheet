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

