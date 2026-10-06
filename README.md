# Arkovia Linux Full Node

Standalone Linux packaging for the [Arkovia blockchain](https://github.com/mycreationhaven/Arkovia-Blockchain), including a headless Java 17 build, hardened systemd service, first-install script, local-only wallet/API configuration, status reporting, and an isolated smoke test.

## Build

On Debian or Ubuntu, install Git and the OpenJDK 17 JDK:

```bash
sudo apt-get update
sudo apt-get install -y git openjdk-17-jdk-headless python3 ca-certificates
git clone https://github.com/mycreationhaven/Arkovia-Linux-Full-Node.git
cd Arkovia-Linux-Full-Node
bash build.sh
```

The build fetches and verifies upstream source commit [`dabcf44d51dcf5047118ca47347465a97b26369a`](https://github.com/mycreationhaven/Arkovia-Blockchain/tree/dabcf44d51dcf5047118ca47347465a97b26369a), applies this repository's Linux packaging, and creates:

```text
dist/arkovia-linux-full-node.tar.gz
dist/arkovia-linux-full-node.tar.gz.sha256
```

It does not build from a moving branch. The archive includes the compiled node, browser wallet, installable Arkovia Signer PWA under `/signer/`, original genesis data, bundled dependencies, corresponding core source, and license notices.

## Install

An existing Arkovia peer is required because the upstream source has no default seed peers. Replace the example peer before installing:

```bash
tar -xzf dist/arkovia-linux-full-node.tar.gz
cd arkovia-linux-full-node
sudo bash linux/install.sh YOUR_EXISTING_PEER:47874
sudo systemctl enable --now arkovia
sudo journalctl -u arkovia -f
```

The full guide covers firewall settings, SSH wallet access, verification, backups, upgrades, and rollback: **[Linux full-node guide](linux/README.md)**.

## Security defaults

- Full validation enabled; light-client mode and API proxying disabled.
- Peer traffic uses TCP port `47874`.
- Wallet/API binds only to `127.0.0.1:7876`.
- Installer generates a random API admin password.
- Dedicated unprivileged `arkovia` system account.
- No wallet secret phrase or automatic forging configuration.
- Existing installation paths are never overwritten.

## Validation

The delivered build passed Java 17 headless compilation, five selected upstream crypto/address tests, genesis initialization, wallet/API checks, clean shutdown, and restart against the same database. See **[validation details](linux/VALIDATION.md)**.

Live peer synchronization and installation on a production server still require verification with a real Arkovia peer and target host. A process remaining at genesis height is not synchronized.

## License

Consensus, genesis, and dependency versions remain unchanged. The original source license notices are preserved in [LICENSE.txt](LICENSE.txt) and [3RD-PARTY-LICENSES.txt](3RD-PARTY-LICENSES.txt).
