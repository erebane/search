#!/bin/bash
# Delete Ethereum port traffic from ES packetbeat indice
# @URL https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-delete-by-query.html
curl -XPOST 'http://shontaya-ashburn.perneka.hajaan.nu:9200/packetbeat*/_delete_by_query' -d '
{
    "query": {
	"match": {
	    "source.port": "30303"
	}
    }
}'
curl -XPOST 'http://shontaya-ashburn.perneka.hajaan.nu:9200/packetbeat*/_delete_by_query' -d '
{
    "query": {
	"match": {
	    "dest.port": "30303"
	}
    }
}'
curl -XPOST 'http://shontaya-ashburn.perneka.hajaan.nu:9200/packetbeat*/_forcemerge?only_expunge_deletes=true'
