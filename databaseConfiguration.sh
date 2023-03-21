#!/bin/bash

# Switch to the www-data user
sudo -u www-data -s <<EOF
  # Navigate to the liquid_feedback_core directory
  cd /opt/liquid_feedback_core

  # Connect to the liquid_feedback database and run the configuration commands
  psql liquid_feedback <<EOS
    INSERT INTO system_setting (member_ttl) VALUES ('1 year');
    INSERT INTO contingent (polling, time_frame, text_entry_limit, initiative_limit) VALUES (false, '1 hour', 20, 6);
    INSERT INTO contingent (polling, time_frame, text_entry_limit, initiative_limit) VALUES (false, '1 day', 80, 12);
    INSERT INTO contingent (polling, time_frame, text_entry_limit, initiative_limit) VALUES (true, '1 hour', 200, 60);
    INSERT INTO contingent (polling, time_frame, text_entry_limit, initiative_limit) VALUES (true, '1 day', 800, 120);
    INSERT INTO member (invite_code, admin) VALUES ('dcorus', true);
    \q
EOS

  # Exit the www-data shell
  exit
EOF
