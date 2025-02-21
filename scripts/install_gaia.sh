#!/bin/bash
set -e

echo "🔹 Installing Gaia..."
cd $HOME
rm -rf gaia
git clone https://github.com/cosmos/gaia.git
cd gaia
LATEST_VERSION=$(curl -s https://api.github.com/repos/cosmos/gaia/releases/latest | jq -r '.tag_name')
git checkout $LATEST_VERSION
make install

echo "✅ gaiad installed: $(gaiad version)"

