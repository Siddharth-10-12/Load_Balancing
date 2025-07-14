#!/bin/bash

# Function to initiate the snapshot process
initiate_snapshot() {
    echo "Initiating snapshot for termination detection..."
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

# Function to check if the snapshot should be initiated
check_and_initiate_snapshot() {
    running_containers=$(docker ps -q | wc -l)
    if [ "$running_containers" -eq 1 ]; then
        echo "Only one container is running. Initiating snapshot..."
        initiate_snapshot
    fi
}

# Function to check if all containers have terminated
check_termination() {
    echo "Checking for termination..."
    containers=$(docker ps -a --format "{{.Names}}")
    all_terminated=true

    for container in $containers; do
        status=$(docker inspect --format='{{.State.Status}}' "$container")
        if [ "$status" != "exited" ]; then
            all_terminated=false
            echo "Container $container is still running."
        fi
    done

    if $all_terminated; then
        echo "All containers have terminated. System has reached a global termination state."
        exit 0
    else
        echo "System has not yet terminated."
    fi
}

# Schedule snapshot check every 10 seconds
while true; do
    check_and_initiate_snapshot
    check_termination
    sleep 10
done