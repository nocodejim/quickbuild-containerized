#!/bin/bash
set -e

QB_AGENT_HOME="/opt/quickbuild-agent"
NODE_PROPS="${QB_AGENT_HOME}/conf/node.properties"

# Use the SERVER_URL environment variable if set, otherwise default
SERVER_URL="${SERVER_URL:-http://quickbuild-server:8810/}"

echo "Configuring agent to connect to: $SERVER_URL"

# Update the serverUrl in node.properties
sed -i "s|^serverUrl=.*|serverUrl=${SERVER_URL}|" "$NODE_PROPS"

# Execute the main command (e.g., "bin/agent.sh console")
exec "$@"
