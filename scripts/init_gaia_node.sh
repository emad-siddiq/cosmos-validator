#!/bin/bash

set -e  # Exit script on any error

# Set chain ID and node moniker
CHAIN_ID="cosmoshub-4"
NODE_NAME="mynode"

# Initialize gaiad only if it's not already initialized
if [ ! -d "$HOME/.gaia/config" ]; then
    echo "📌 Initializing Gaia node..."
    gaiad init ${NODE_NAME} --chain-id ${CHAIN_ID}
else
    echo "✅ Gaia node already initialized, skipping."
fi

# Ensure Gaia config directory exists
mkdir -p $HOME/.gaia/config

# Download and set up the latest genesis file if it doesn't exist
GENESIS_FILE="$HOME/.gaia/config/genesis.json"
if [ ! -f "$GENESIS_FILE" ]; then
    echo "📥 Downloading genesis file..."
    GENESIS_URL="https://raw.githubusercontent.com/cosmos/mainnet/master/genesis/genesis.cosmoshub-4.json.gz"
    wget -O genesis.json.gz ${GENESIS_URL}
    gzip -d genesis.json.gz
    mv genesis.json $GENESIS_FILE
else
    echo "✅ genesis.json already exists, skipping download."
fi

# Set pruning configuration
echo "🔧 Configuring pruning..."
APP_TOML="$HOME/.gaia/config/app.toml"
sed -i 's/^pruning = .*/pruning = "custom"/' ${APP_TOML}
sed -i 's/^pruning-keep-recent = .*/pruning-keep-recent = "100"/' ${APP_TOML}
sed -i 's/^pruning-keep-every = .*/pruning-keep-every = "0"/' ${APP_TOML}
sed -i 's/^pruning-interval = .*/pruning-interval = "10"/' ${APP_TOML}

# Configure network peers (use seeds instead of modifying addrbook.json)
echo "🔗 Configuring network peers..."
CONFIG_TOML="$HOME/.gaia/config/config.toml"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@seeds.polkachu.com:14956"
sed -i "s/^seeds = .*/seeds = \"${SEEDS}\"/" ${CONFIG_TOML}

# Configure minimum gas price to avoid spam transactions
echo "⛽ Configuring gas and fees..."
sed -i 's/^minimum-gas-prices = .*/minimum-gas-prices = "0.025uatom"/' ${APP_TOML}

echo "✅ Gaia initialized with pruning enabled and Polkachu seed!"
echo "🔗 Next steps:"
echo "🔗 Copy gaiad.service to /etc/systemd/system/gaiad.service"
echo "🔗 Reload systemd: sudo systemctl daemon-reload"
echo "🔗 Enable gaiad to start on boot: sudo systemctl enable gaiad"
echo "🔗 Start with : sudo systemctl start gaiad"
echo "🔗 Check status: sudo systemctl status gaiad"
echo "🔗 Check logs: journalctl -fu gaiad"
