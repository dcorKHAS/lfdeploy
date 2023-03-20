#!/bin/bash

# Step 1: Install dependencies
sudo apt-get update
sudo apt-get install build-essential lua5.4 liblua5.4-dev postgresql postgresql-server-dev-all libpq-dev libbsd-dev bmake imagemagick lsb-release mercurial
sudo pip install markdown2

# Step 2: Grant access to web server user
sudo -u postgres createuser --no-superuser --createdb --no-createrole www-data

# Step 3: Install and configure LiquidFeedback-Core

cd /opt/
hg clone https://www.public-software-group.org/mercurial/liquid_feedback_core
cd liquid_feedback_core
make
sudo -u www-data createdb liquid_feedback
sudo -u www-data createlang plpgsql liquid_feedback
sudo -u www-data psql -v ON_ERROR_STOP=1 -f core.sql liquid_feedback


cd /opt/
hg clone https://www.public-software-group.org/mercurial/moonbridge
cd moonbridge
bmake MOONBR_LUA_PATH=/opt/moonbridge/?.lua

# Step 5: Install WebMCP
cd /opt/
hg clone https://www.public-software-group.org/mercurial/webmcp
cd webmcp
make

cd /opt/
hg clone https://www.public-software-group.org/mercurial/liquid_feedback_frontend
chown www-data /opt/liquid_feedback_frontend/tmp


cd /opt/liquid_feedback_frontend/config
cp example.lua myconfig.lua


cd /opt/lfdeploy
cp lf_update.sh /opt/liquid_feedback_core/
chmod +x /opt/liquid_feedback_core/lf_update.sh

mv liquid_feedback_core.service /etc/systemd/system/
systemctl start liquid_feedback_core
systemctl enable liquid_feedback_core


cd /opt/lfdeploy
cp run.sh /opt/liquid_feedback_frontend/
chmod +x /opt/liquid_feedback_frontend/run.sh

mv liquid_feedback_frontend.service /etc/systemd/system/
systemctl start liquid_feedback_frontend
systemctl enable liquid_feedback_frontend

#chmod +x /opt/liquid_feedback_core/lf_updated