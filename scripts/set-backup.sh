#!/bin/bash
# Define common backup location
curl -XDELETE 'http://shontaya-ashburn.perneka.hajaan.nu:9200/_snapshot/hajaannu_backup'
curl -H 'Content-Type: application/json' -XPUT 'http://shontaya-ashburn.perneka.hajaan.nu:9200/_snapshot/hajaannu_backup' -d '{
    "type": "fs",
    "settings": {
        "location": "hajaannu_backup",
        "compress": true
    }
}'
curl -XPUT 'shontaya-ashburn.perneka.hajaan.nu:9200/_snapshot/hajaannu_backup/snapshot_1?wait_for_completion=true&pretty'
