#!/bin/bash
# Define common backup location
curl -XDELETE 'http://shontaya-ashburn.perneka.hajaan.nu:9200/_snapshot/hajaannu_backup/before-upgrade'
curl -XPUT 'shontaya-ashburn.perneka.hajaan.nu:9200/_snapshot/hajaannu_backup/before-upgrade?wait_for_completion=true&pretty'
