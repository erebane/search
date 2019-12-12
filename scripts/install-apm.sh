# Install apm server for golang
# @URL: https://search.hajaan.nu/app/kibana#/home/tutorial/apm?_g=()

# Install APM Server with apt
sudo apt install apm-server

# Set config to /opt/search
sudo ln -sf /opt/search/configs/apm-server/apm-server.yml /etc/apm-server/apm-server.yml

# Start as a service
#sudo /usr/share/apm-server/bin/apm-server  --path.config /etc/apm-server -e
sudo service apm-server start
#sudo service apm-server status

go get go.elastic.co/apm

export ELASTIC_APM_SERVER_URL="http://libby-hyde.hajaan.nu:8224"

