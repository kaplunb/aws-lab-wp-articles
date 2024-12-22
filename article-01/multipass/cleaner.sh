#!/bin/bash

# Stop and remove containers while keeping the images
echo "Stopping and removing Docker containers..."
docker-compose down

# Delete the Multipass instance
echo "Removing Multipass instance..."
multipass delete wordpress
multipass purge

echo "Cleanup completed."