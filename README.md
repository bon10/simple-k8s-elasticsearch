# Single Node ELK on the Kubernetes
## Whhat is this?
Builds a simple ELK single cluster on Kubernetes.
Suitable for development especially Ruby.

## Required
- Kubernetes v1.14 later.
- Space must be reserved for [Local Volume](https://kubernetes.io/blog/2019/04/04/kubernetes-1.14-local-persistent-volumes-ga/) to use.

```
$ ssh k8s-node
$ sudo mkdir -p /mnt/disks/vol1
$ sudo chmod 777 /mnt/disks/vol1
```

## How to use

```
$ kubectl config get-contexts
$ sudo chmod a+x ./create.sh
$ ./create.sh
```

## Attributes
Namespace: elasticsearch  
StatefulSet: elasticsearch  
Deployment: logstash,kibana,apm-server  

Service:  
  logstash:      Internal 5044 / NodePort 30014  
  elasticsearch: Internal 9200 / NodePort 31001  
  kibana:        Internal 5601 / NodePort 31000  


## FYI
### Use Elasticsearch plugins  

Edit Dockerfile and build&push container for your Docker registry.

```
# Plugin install
RUN bin/elasticsearch-plugin install --batch repository-s3

# keysstore
RUN bin/elasticsearch-keystore create
RUN echo "S3_ACCESS_KEY" | bin/elasticsearch-keystore add s3.client.default.access_key
RUN echo "S3_SECRET_KEY" | bin/elasticsearch-keystore add s3.client.default.secret_key
```

```
$ docker build -t sample.com/elasticsearch:latest .
$ docker push sample.com/elasticsearch:latest
```

And change `image` on kubernetes/elasticsearch-statefulset.yaml like:
```
containers:
  - name: es-client
    image: sample.com/elasticsearch:latest
```

