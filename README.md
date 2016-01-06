# docker-couchbase-devpreview

Simple Docker image to test Couchbase. It features a running, preconfigured couchbase instance loaded with the bucket sample, [CBFT](labs.couchbase.com/cbft/) and the [query workbench](http://developer.couchbase.com/documentation/server/4.1/developer-guide/query-workbench-intro.html).

It's goal is to be able to test the latest features comming up by just dockerunning a single image. (Yes dockerun is a verb).

There are currently two implementations. Modular is not functionning at the moment. It's trying to do all the necessary steps starting from the couchbase:latest image.

The full version is a fork of the official Couchbase image. Build it with:

    docker build -t couchbase-devpreview .

And run it with

    docker run -P --rm -p 8091:8091 -p 8094:8094 -p 8095:8095 couchbase-devpreview 

Couchbase Server has already been setup and is accessible through the 8091 port. The query workbench is accessible through the 8094 port. CBFT is accessible through the 8095 port.

The travel-sample has been imported and the Data, Index and Query services are enabled by default.

## How we Manage all Processes

To run the Couchbase Server, CBFT and QueryWorkbemch processes in the same container, we use [Supervisord](http://supervisord.org/).
