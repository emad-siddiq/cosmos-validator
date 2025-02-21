# Cosmos Validator Node Setup Guide

This guide explains how to set up a pruned [Cosmos Validator node](https://hub.cosmos.network/main/validators/validator-setup), and manage it using `systemd`.

![cosmos-hub-image-64b35193bcb3998afd27f30060ed5ab5](https://github.com/user-attachments/assets/ea44a632-87ad-42bc-9179-a9c90cc460a9)

## 1. Install Go

```bash
chmod +x install_go.sh
./install_go.sh
```

This installs Go from `go1.21.0.linux-amd64.tar.gz` and sets up the environment.

## 2. Install Gaia

```bash
chmod +x install_gaia.sh
./install_gaia.sh
```

This installs `gaiad` and its dependencies.

## 3. Initialize the Gaia Node

```bash
chmod +x init_gaia_node.sh
./init_gaia_node.sh
```

This initializes the Gaia node, sets up configuration, and downloads required files **without starting `gaiad`**.

## 4. Set Up a Pruned Gaia Snapshot

```bash
chmod +x setup_pruned_gaia_snapshot.sh
./setup_pruned_gaia_snapshot.sh
```

This downloads and sets up a pruned snapshot for faster sync.

## 5. Set Up Systemd for Gaia

Copy the `gaiad.service` file to the correct location:

```bash
sudo cp gaiad.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable gaiad
```

## 6. Start and Manage Gaia with Systemd

- **Start Gaia**:
  ```bash
  sudo systemctl start gaiad
  ```

- **Check Gaia Status**:
  ```bash
  sudo systemctl status gaiad
  ```

- **View Logs**:
  ```bash
  journalctl -fu gaiad
  ```

- **Restart Gaia**:
  ```bash
  sudo systemctl restart gaiad
  ```

- **Stop Gaia**:
  ```bash
  sudo systemctl stop gaiad
  ```

## Troubleshooting

If `gaiad` fails to start, ensure:
- The binary exists and is executable: `ls -l /home/ubuntu/go/bin/gaiad`
- Permissions are correct: `chmod +x /home/ubuntu/go/bin/gaiad`
- The `gaiad.service` file has the correct `ExecStart` path.

For persistent errors, check logs using:
```bash
journalctl -xeu gaiad
```


