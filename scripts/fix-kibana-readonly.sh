curl -H 'Content-Type: application/json' -XPUT 'http://shontaya-ashburn.perneka.hajaan.nu:9200/_settings' -d '{
    "index": {
	"blocks": {
	    "read_only_allow_delete": "false"
	}
    }
}'
