#!/bin/bash

# Step 1: Install dependencies
sudo apt-get update
sudo apt-get install build-essential lua5.3 liblua5.3-dev postgresql postgresql-server-dev-all libpq-dev libbsd-dev bmake imagemagick lsb-release mercurial
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
cp /opt/lfdeploy/Makefile.options /opt/webmcp/Makefile.options
make
cp -RL framework/* /opt/webmcp/



cd /opt/
hg clone https://www.public-software-group.org/mercurial/liquid_feedback_frontend
chown www-data /opt/liquid_feedback_frontend/tmp



cp /opt/lfdeploy/configFile.lua /opt/liquid_feedback_frontend/config/myconfig.lua


cd /opt/lfdeploy
cp lf_update.sh /opt/liquid_feedback_core/
chmod +x /opt/liquid_feedback_core/lf_update.sh
	


cd /opt/lfdeploy
cp run.sh /opt/liquid_feedback_frontend/
chmod +x /opt/liquid_feedback_frontend/run.sh

mv startup.service /etc/systemd/system/
systemctl start startup
systemctl enable startup


#chmod +x /opt/liquid_feedback_core/lf_updated
