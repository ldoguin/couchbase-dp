FROM couchbase:latest

MAINTAINER Couchbase Docker Team <docker@couchbase.com>

# Install supervisor
RUN apt-get update && \
    apt-get install -yq supervisor && \
    apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CBFT_VERSION=0.3.1 \
    CBFT_PACKAGE=cbft-v0.3.1-0-ga690828.linux.amd64.tar.gz \
    QUERY_WORKBENCH_VERSION=dp1 \
    QUERY_WORKBENCH_PACKAGE=couchbase-query-workbench_dp1-linux_x86_64.tar.gz

# Install CBFT
RUN wget -N $CB_RELEASE_URL/cbft/$CBFT_VERSION/$CBFT_PACKAGE && \
    tar -zxvf $CBFT_PACKAGE && rm -f ./$CBFT_PACKAGE

# Install Query Workbench
RUN wget -N $CB_RELEASE_URL/query-workbench/$QUERY_WORKBENCH_VERSION/$QUERY_WORKBENCH_PACKAGE && \
    tar -zxvf $QUERY_WORKBENCH_PACKAGE && rm -f ./$QUERY_WORKBENCH_PACKAGE

# Requires a docker host with at least 8G of Ram
RUN set -xv && /entrypoint.sh couchbase-server start & sleep 7 && set -xv && /opt/couchbase/bin/couchbase-cli  cluster-init -c $HOSTNAME:8091 --cluster-username=Administrator  --cluster-password=password --cluster-port=8091 --cluster-ramsize=256 --cluster-index-ramsize=256 --services=data,index,query && /opt/couchbase/bin/couchbase-cli bucket-create -c $HOSTNAME:8091 --bucket=default --bucket-type=couchbase --bucket-port=11211  --bucket-ramsize=128  --bucket-replica=0 -u Administrator -p password && /opt/couchbase/bin/cbdocloader -n $HOSTNAME:8091 -u Administrator -p password -b travel-sample /opt/couchbase/samples/travel-sample.zip


# Add supervisor configuration, wrap cbft and queryworkbench call in scripts to allow 5 seconds sleep and let couchbase starts
COPY scripts/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY scripts/queryworkbench.sh /queryworkbench.sh
COPY scripts/cbft.sh /cbft.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]

EXPOSE 8091 8092 8093 8094 8095 11207 11210 11211 18091 18092
VOLUME /opt/couchbase/var
