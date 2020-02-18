#!/bin/bash
# Drop all indices
curl -XDELETE shontaya-ashburn.perneka.hajaan.nu:9200/topbeat*
curl -XDELETE shontaya-ashburn.perneka.hajaan.nu:9200/packetbeat*
curl -XDELETE shontaya-ashburn.perneka.hajaan.nu:9200/filebeat*
curl -XDELETE shontaya-ashburn.perneka.hajaan.nu:9200/metricbeat*
curl -XDELETE shontaya-ashburn.perneka.hajaan.nu:9200/events
curl -XDELETE shontaya-ashburn.perneka.hajaan.nu:9200/wiki*
