#!/bin/bash

# Load environment variables
if [ ! -f .env ]; then
    echo ".env file not found. Aborting." >&2
    exit 1
fi
set -a
source .env
set +a

# Start MySQL container
echo "Starting MySQL container..."
docker-compose up -d

# Wait for MySQL to be healthy
echo "Waiting for MySQL to be ready..."
while ! docker-compose ps | grep -q "(healthy)"; do
    sleep 5
done

# For injecting an SSH public key into the Multipass VM
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)

HOST_IP=$(hostname -I | awk '{print $1}')
echo "Using host IP: $HOST_IP for database connection"

# Launch instance with SSH key and correct DB_HOST
multipass launch --name wordpress --cloud-init <(sed "s/\${db_name}/$DB_NAME/g; \
    s/\${db_user}/$DB_USER/g; \
    s/\${db_password}/$DB_PASSWORD/g; \
    s/\${db_host}/$HOST_IP/g; \
    s|\${ssh_public_key}|$SSH_KEY|g" cloud-init.yaml)

# Get instance IP
WP_IP=$(multipass info wordpress | grep IPv4 | awk '{print $2}')
echo "Multipass VM running WordPress on http://$WP_IP"