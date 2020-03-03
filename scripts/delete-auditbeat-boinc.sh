#!/bin/bash
# Delete all ES documents based on match
# @URL https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-delete-by-query.html
curl -H 'Content-Type: application/json' -XPOST 'http://shontaya-ashburn.perneka.hajaan.nu:9200/auditbeat*/_delete_by_query' -d '
{
    "query": {
	"match": {
	    "user.name": "boinc"
	}
    }
}'
curl -XPOST 'http://shontaya-ashburn.perneka.hajaan.nu:9200/auditbeat*/_forcemerge?only_expunge_deletes=true'
