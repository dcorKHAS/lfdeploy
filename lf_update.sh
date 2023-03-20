#!/bin/sh

while true; do
  nice /opt/liquid_feedback_core/lf_update dbname=liquid_feedback 2>&1 | logger -t "lf_core"
  nice /opt/liquid_feedback_core/lf_update_issue_order dbname=liquid_feedback 2>&1 | logger -t "lf_core"
  nice /opt/liquid_feedback_core/lf_update_suggestion_order dbname=liquid_feedback 2>&1 | logger -t "lf_core"
  sleep 5
done