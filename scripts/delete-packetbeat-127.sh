#!/bin/bash
# Delete all ES documents based on match
# @URL https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-delete-by-query.html
curl -XPOST 'http://shontaya-ashburn.perneka.hajaan.nu:9200/packetbeat*/_delete_by_query' -d '
{
    "query": {
	"match": {
	    "source.ip": "127.0.0.1"
	}
    }
}'
curl -XPOST 'http://shontaya-ashburn.perneka.hajaan.nu:9200/packetbeat*/_delete_by_query' -d '
{
    "query": {
	"match": {
	    "source.ipv6": "::1"
	}
    }
}'
curl -XPOST 'http://shontaya-ashburn.perneka.hajaan.nu:9200/packetbeat*/_delete_by_query' -d '
{
    "query": {
	"match": {
	    "dest.ipv6": "::1"
	}
    }
}'
curl -XPOST 'http://shontaya-ashburn.perneka.hajaan.nu:9200/packetbeat*/_forcemerge?only_expunge_deletes=true'
