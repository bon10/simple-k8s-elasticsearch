FROM docker.elastic.co/elasticsearch/elasticsearch:7.3.1

WORKDIR /usr/share/elasticsearch

# Plugin install
RUN bin/elasticsearch-plugin install --batch repository-s3

# keysstore
RUN bin/elasticsearch-keystore create
RUN echo "S3_ACCESS_KEY" | bin/elasticsearch-keystore add s3.client.default.access_key
RUN echo "S3_SECRET_KEY" | bin/elasticsearch-keystore add s3.client.default.secret_key
