#!/bin/sh
source config.sh
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install postgresql postgresql-contrib
sudo -u postgres psql
sudo wget https://releases.mattermost.com/{$version}/mattermost-${version}-linux-amd64.tar.gz
tar -xvzf mattermost*.gz
sudo mv mattermost /opt
sudo mkdir /opt/mattermost/data
sudo cp config.json /opt/mattermost/config/config.json
sudo useradd --system --user-group mattermost
sudo chown -R mattermost:mattermost /opt/mattermost
sudo chmod -R g+w /opt/mattermost
sudo cp mattermost.service /lib/systemd/system/mattermost.service
sudo systemctl daemon-reload
sudo --login --user postgres
sudo -u postgres psql -f init.sql
sudo systemctl start mattermost.service
sudo -u mattermost /opt/mattermost/bin/mmctl user create --email {$email} --username {$username} --password {$password} --system_admin --email_verified --local