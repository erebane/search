#!/bin/bash
# Drop templates
#curl -XDELETE shontaya-ashburn.perneka.hajaan.nu:9200/_template/beat
#curl -XDELETE shontaya-ashburn.perneka.hajaan.nu:9200/_template/topbeat
#curl -XDELETE shontaya-ashburn.perneka.hajaan.nu:9200/_template/filebeat
#curl -XDELETE shontaya-ashburn.perneka.hajaan.nu:9200/_template/packetbeat

#curl -XPUT shontaya-ashburn.perneka.hajaan.nu:9200/_template/topbeat -d @template/beat.json
#curl -XPUT shontaya-ashburn.perneka.hajaan.nu:9200/_template/topbeat -d @template/topbeat.json
#curl -H'Content-Type: application/json' -XPUT shontaya-ashburn.perneka.hajaan.nu:9200/_template/filebeat -d @template/filebeat.json
#curl -XPUT shontaya-ashburn.perneka.hajaan.nu:9200/_template/packetbeat -d @template/packetbeat.json
#curl -H'Content-Type: application/json' -XPUT shontaya-ashburn.perneka.hajaan.nu:9200/_template/finnish -d @template/finnish.json
