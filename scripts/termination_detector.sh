#!/bin/bash

# Function to check the status of all containers
check_containers() {
    echo "Checking container statuses..."
    stopped_containers=$(docker ps -a --filter "status=exited" --format "{{.Names}}")
    
    if [ -z "$stopped_containers" ]; then
        echo "All containers are running."
    else
        echo "The following containers have stopped:"
        echo "$stopped_containers"
        exit 1
    fi
}

# Periodically check container statuses
while true; do
    check_containers
    sleep 10 # Check every 10 seconds
done
