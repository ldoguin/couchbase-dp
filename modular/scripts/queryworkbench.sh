#!/bin/bash
set -xv
sleep 5 && cd /couchbase-query-workbench && COUCHBASE_URL=http://$HOSTNAME:8091/ ./launch-cbq-gui.sh
