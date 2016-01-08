
# Test the Latest Couchbase Features with a Docker Image

We have very active developers and engineers here at Couchbase and they are coming up with new things to test quite often. If you follow this blog you might have seen we published a developer preview for [CBFT](http://blog.couchbase.com/announcing-cbft-developer-preview) and for the [query workbench](http://blog.couchbase.com/2015/october/announcing-the-couchbase-query-workbench-dp1). 

The goal of these early developer preview version is to gather your feedback in advance and include it during our development. And this is something really important as it helps us shape a better product. So what I want to do is make it easier for you test these things.

And to me the easiest way to test new software in 2016 is dockerunning it. Yes dockerun is a verb. I created a new Docker image that features a preconfigured Couchbase instance with the travel and beer sample imported as well as the data, index and query services activated. [CBFT](http://labs.couchbase.com/cbft/) and the [query workbench](http://developer.couchbase.com/documentation/server/4.1/developer-guide/query-workbench-intro.html) will also be running in the same image.

Everything in just one image so that all you have to do to test our new features is 

    docker run -P --rm -p 8091:8091 -p 8094:8094 -p 8095:8095 ldoguin/couchbase-dp

Once your image is running, get the ip of the container and you'll have access to Couchabse on port 8091, the query workbench on port 8094 and CBFT on port 8095.

If you are using Kinematic it's even simpler. Search the hub for couchbase-dp and you should be able to create an image from it and start testing. I made a short video of it:

<script charset="ISO-8859-1" src="//fast.wistia.com/assets/external/E-v1.js" async></script><div class="wistia_embed wistia_async_7x81xej4kv" style="height:400px;width:640px">&nbsp;</div>

The fulltext query ran in CBFT are using [Bleve](http://www.blevesearch.com/) as indexer. You can find the detailed query string documentation [here](http://www.blevesearch.com/docs/Query-String-Query/). Cleve brings full-text search and indexing for Go. It's one of Couchabse's most active open source project too!

If you test CBFT and the query workbench, please give us your feedback and tell us how we can make these better. Thanks!