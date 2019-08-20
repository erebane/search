sudo apt install elasticsearch-curator

sudo systemctl disable shrink-es-indices.service
sudo systemctl disable shrink-es-indices.timer

sudo systemctl enable /opt/search/scripts/systemd-timer/shrink-es-indices.service --now
sudo systemctl enable /opt/search/scripts/systemd-timer/shrink-es-indices.timer --now

sudo systemctl status shrink-es-indices.timer shrink-es-indices.service
