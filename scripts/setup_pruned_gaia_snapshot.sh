#!/bin/bash

set -e  # Exit on error

echo "🔹 Installing dependencies..."
sudo apt-get update && sudo apt-get install -y wget liblz4-tool aria2 jq zstd

# Define the latest snapshot URL
URL="https://storage1.quicksync.io/cosmos/mainnet/minimal/latest.tar.zst"

echo "📥 Downloading pruned snapshot from: $URL"
cd $HOME/.gaia
wget -O latest.tar.zst "$URL"

echo "🔹 Extracting snapshot..."
tar --use-compress-program=unzstd -xvf latest.tar.zst
rm latest.tar.zst

echo "✅ Pruned snapshot applied!"

