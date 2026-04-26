#!/bin/bash

apt-get update && apt-get upgrade -y
apt-get install -y curl git make build-essential

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

curl -OL https://golang.org/dl/go1.22.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

docker --version
go version