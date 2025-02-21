#!/bin/bash

GO_VERSION="1.21.0"
INSTALL_DIR="/usr/local"
GO_TARBALL="go${GO_VERSION}.linux-amd64.tar.gz"
GO_URL="https://go.dev/dl/${GO_TARBALL}"

# Remove existing Go installation
sudo rm -rf ${INSTALL_DIR}/go

# Download and extract Go
curl -LO ${GO_URL} && sudo tar -C ${INSTALL_DIR} -xzf ${GO_TARBALL}

# Clean up
rm ${GO_TARBALL}

# Add Go to PATH
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

# Verify installation
go version

