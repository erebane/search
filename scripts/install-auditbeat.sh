sudo apt-get remove auditbeat -y
sudo apt-get install auditbeat -y --allow-change-held-packages
sudo mv /etc/auditbeat/auditbeat.yml /etc/auditbeat/auditbeat.yml.org
sudo ln -s /opt/search/configs/auditbeat/auditbeat.yml /etc/auditbeat/auditbeat.yml
sudo service auditbeat start
