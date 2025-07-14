#!/bin/bash

# Function to initiate the snapshot process
initiate_snapshot() {
    echo "Initiating Chandy-Lamport snapshot algorithm..."
    containers=$(docker ps --format "{{.Names}}")

    # Mark the state of each container
    for container in $containers; do
        echo "Recording state of container: $container"
        docker exec "$container" sh -c "echo 'Snapshot State: $(date)' > /tmp/snapshot_state.txt"
    done

    # Simulate recording of messages (network traffic)
    echo "Recording inter-container messages..."
    for container in $containers; do
        echo "Recording messages for container: $container"
        docker logs "$container" > "/tmp/${container}_messages.log"
    done

    echo "Snapshot completed. States and messages recorded in /tmp."
}

# Start the snapshot process
initiate_snapshot
