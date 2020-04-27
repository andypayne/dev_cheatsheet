# RabbitMQ Notes

## Using with docker

Use the [Rabbitmq docker image](https://registry.hub.docker.com/_/rabbitmq/).

```shell
docker run -d --hostname my-rabbit --name some-rabbit rabbitmq:3
```

To use the management console and map the ports through so that RabbitMQ is
mapped to localhost:5672, and http://localhost:8082/ points to the management console:
```shell
docker run -d --hostname my-rabbit --name some-rabbit-mgmt -p 8082:15672 -p 5672:5672 rabbitmq:3-management
ef529b6f90708d09c4e1b45b1cde966de5e3e0fe2fed92fcdbb0cb9f1513ba3d
```

Status:
```shell
docker exec -it some-rabbit rabbitmqctl status
docker exec -it some-rabbit rabbitmqctl list_queues
docker exec -it some-rabbit rabbitmqctl cluster_status
```

Check logs:
```shell
docker logs some-rabbit
```

List plugins, enable the management console plugin:
```shell
docker exec -it some-rabbit rabbitmq-plugins list
docker exec -it some-rabbit rabbitmq-plugins enable rabbitmq_management
```

To prune old containers:
```shell
docker container prune
WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N] y
Deleted Containers:
4fdf991394296f545a703ea56f5d5b2734df6993b4a17eec5864113ee018210f

Total reclaimed space: 2.491GB
```
