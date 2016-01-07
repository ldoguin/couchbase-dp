FROM ubuntu:12.04

MAINTAINER Couchbase Docker Team <docker@couchbase.com>

# Install dependencies
RUN apt-get update && \
    apt-get install -yq runit wget python-httplib2 supervisor && \
    apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CB_VERSION=4.1.0 \
    CB_RELEASE_URL=http://packages.couchbase.com/releases \
    CB_PACKAGE=couchbase-server-enterprise_4.1.0-ubuntu12.04_amd64.deb \
    CBFT_VERSION=0.3.1 \
    CBFT_PACKAGE=cbft-v0.3.1-0-ga690828.linux.amd64.tar.gz \
    QUERY_WORKBENCH_VERSION=dp1 \
    QUERY_WORKBENCH_PACKAGE=couchbase-query-workbench_dp1-linux_x86_64.tar.gz \
    CB_SHA256=38b92711a52cbb0f8d4ab977e0ea2fb4e25022a0660dacc26fd7a60031eb70d2 \
    PATH=$PATH:/opt/couchbase/bin:/opt/couchbase/bin/tools:/opt/couchbase/bin/install \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/couchbase/lib

# Create Couchbase user with UID 1000 (necessary to match default
# boot2docker UID)
RUN groupadd -g 1000 couchbase && useradd couchbase -u 1000 -g couchbase -M

# Install couchbase, init the cluster and create a default bucket
RUN wget -N $CB_RELEASE_URL/$CB_VERSION/$CB_PACKAGE && \
    echo "$CB_SHA256  $CB_PACKAGE" | sha256sum -c - && \
    dpkg -i ./$CB_PACKAGE && rm -f ./$CB_PACKAGE && \
    sleep 10 && /opt/couchbase/bin/couchbase-cli  cluster-init -c $HOSTNAME:8091 --cluster-username=Administrator  --cluster-password=password --cluster-port=8091 --cluster-ramsize=384 --cluster-index-ramsize=384 --services=data,index,query && /opt/couchbase/bin/couchbase-cli bucket-create -c $HOSTNAME:8091 --bucket=default --bucket-type=couchbase --bucket-port=11211  --bucket-ramsize=100  --bucket-replica=0 -u Administrator -p password && /opt/couchbase/bin/cbdocloader -n $HOSTNAME:8091 -u Administrator -p password -b travel-sample /opt/couchbase/samples/travel-sample.zip && /opt/couchbase/bin/cbdocloader -n $HOSTNAME:8091 -u Administrator -p password -b beer-sample /opt/couchbase/samples/beer-sample.zip

# Add runit script for couchbase-server
COPY scripts/run /etc/service/couchbase-server/run


# Install CBFT
RUN wget -N $CB_RELEASE_URL/cbft/$CBFT_VERSION/$CBFT_PACKAGE && \
    tar -zxvf $CBFT_PACKAGE && rm -f ./$CBFT_PACKAGE

# Install Query Workbench
RUN wget -N $CB_RELEASE_URL/query-workbench/$QUERY_WORKBENCH_VERSION/$QUERY_WORKBENCH_PACKAGE && \
    tar -zxvf $QUERY_WORKBENCH_PACKAGE && rm -f ./$QUERY_WORKBENCH_PACKAGE

# Add supervisor configuration, wrap cbft and queryworkbench call in scripts to allow 5 seconds sleep and let couchbase starts
COPY scripts/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY scripts/queryworkbench.sh /queryworkbench.sh
COPY scripts/cbft.sh /cbft.sh

# Add bootstrap script
COPY scripts/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]

EXPOSE 8091 8092 8093 8094 8095 11207 11210 11211 18091 18092
VOLUME /opt/couchbase/var
