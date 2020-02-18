curl -H 'Content-Type: application/json' -XPUT 'http://dallen-montgomery.perneka.hajaan.nu:9200/_template' -d '{
  "index.mapping.total_fields.limit": 5000
}'
