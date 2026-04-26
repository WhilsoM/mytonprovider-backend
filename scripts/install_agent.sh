#!/bin/bash
# install_agent.sh
set -e

COORDINATOR_URL=${1:-"http://localhost:8080"}

echo "--- Installing Agent (Go 1.24.0) ---"
apt-get update && apt-get install -y curl git build-essential

# 1. Install Go 1.24.0
if ! command -v go &> /dev/null; then
    curl -OL https://golang.org/dl/go1.24.0.linux-amd64.tar.gz
    tar -C /usr/local -xzf go1.24.0.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
fi

# 2. Setup project in a separate directory to avoid conflicts
git clone https://github.com/WhilsoM/mytonprovider-backend.git /opt/ton-agent
cd /opt/ton-agent

# 3. Create Agent .env
cat <<EOF > .env
ROLE=agent
COORDINATOR_URL=$COORDINATOR_URL
LOG_LEVEL=info
EOF

# 4. Build
go build -o ton-agent ./cmd/...

echo "--- Agent Installed. Run with: ./ton-agent ---"