#!/usr/bin/env bash
set -e

echo "=== Updating system ==="
sudo apt update -y
sudo apt upgrade -y

echo "=== Installing Docker (docker.io) ==="
sudo apt install -y docker.io docker-buildx

echo "=== Ensuring docker group exists ==="
# docker group is created automatically by docker.io, but ensure idempotency
if ! getent group docker >/dev/null; then
    sudo groupadd docker
fi

echo "=== Adding current user to docker group ==="
sudo usermod -aG docker "$USER"

echo "=== Enabling BuildKit globally ==="
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json >/dev/null <<EOF
{
  "features": { "buildkit": true }
}
EOF

echo "=== Restarting Docker daemon ==="
sudo systemctl restart docker

echo "=== Docker version ==="
docker --version

echo "=== Buildx version ==="
docker buildx version || echo "buildx not available"

echo
echo "=== Installation complete ==="
echo "You must log out and log back in for docker group membership to take effect."
