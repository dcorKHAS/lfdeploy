#!/bin/bash


sudo -u www-data /opt/liquid_feedback_core/lf_update.sh & 
sudo -u www-data /opt/liquid_feedback_frontend/run.sh &