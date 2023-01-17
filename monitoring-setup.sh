# TELECHARGEMENT
#Installer les outils de monitoring ci-dessous

sudo apt install prometheus-alertmanager
sudo apt install prometheus
sudo wget [https://github.com/ncabatoff/process-exporter/releases/download/v0.7.10/process-exporter-0.7.10.linux-amd64.tar.gz](https://github.com/ncabatoff/process-exporter/releases/download/v0.7.10/process-exporter-0.7.10.linux-amd64.tar.gz)
tar xvf process-exporter-*

sudo cp ./process-exporter-*.linux-amd64/process-exporter /usr/local/bin/

# Cp dans /usr/local/bin/
sudo cp ./node_exporter-*.linux-amd64/node_exporter /usr/local/bin/
sudo cp ./process-exporter-*.linux-amd64/process-exporter /usr/local/bin/

# Creation utilisateurs dediés
sudo useradd --no-create-home --shell /usr/sbin/nologin process-exporter

# Creation des repertoires
sudo mkdir /etc/process-exporter

# Change appartenance
sudo chown process-exporter:process-exporter /etc/process-exporter -R
sudo chown process-exporter:process-exporter /usr/local/bin/process-exporter

# Clean up
#rm -rf ./process-exporter*

# Configuration
#sudo cp config/prometheus.yml /etc/prometheus/prometheus.yml
sudo cp config/rules.yml /etc/prometheus/rules.yml
sudo cp config/config.yml /etc/process-exporter/config.yml
#sudo cp config/alertmanager.yml /etc/alertmanager/alertmanager.yml

# Systemd
sudo cp service/process-exporter.service /etc/systemd/system/process-exporter.service

# daemon reload + start services
sudo systemctl start prometheus.service
sudo systemctl start node_exporter.service
sudo systemctl start process-exporter.service
sudo systemctl start alertmanager.service

# Verifications

# enable
sudo systemctl enable prometheus.service
sudo systemctl enable node_exporter.service
sudo systemctl enable process-exporter.service
sudo systemctl enable alertmanager.service

# Test alert-manager
#curl -H "Content-Type: application/json" -d '[{"Test":{"Alert mail par Gmail":"Good !"}}]' localhost:9093/api/v1/alerts

## Add Grafana + install
sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update
sudo apt-get install grafana
sudo systemctl start grafana-server.service

# Plugins Grafana
sudo grafana-cli plugins install camptocamp-prometheus-alertmanager-datasource