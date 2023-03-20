#/bin/bash

/opt/moonbridge/moonbridge /opt/webmcp/bin/mcp.lua /opt/webmcp/ /opt/liquid_feedback_frontend/ main myconfig  2>&1 | logger -t "lf_frontend"