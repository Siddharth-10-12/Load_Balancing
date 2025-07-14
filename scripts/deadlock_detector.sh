#!/bin/bash

# Function to simulate deadlock detection
detect_deadlock() {
    echo "Checking for potential deadlocks..."
    
    # Simulate a resource dependency graph using Docker container dependencies
    containers=$(docker ps --format "{{.Names}}")
    declare -A dependency_graph

    # Build a mock dependency graph (for demonstration purposes)
    for container in $containers; do
        # Simulate dependencies (replace this with actual logic if applicable)
        dependency_graph["$container"]="$(docker inspect --format='{{range .HostConfig.Links}}{{.}}{{end}}' "$container")"
    done

    # Detect cycles in the dependency graph
    visited=()
    stack=()

    has_cycle() {
        local node=$1
        visited+=("$node")
        stack+=("$node")

        for neighbor in ${dependency_graph["$node"]}; do
            if [[ ! " ${visited[@]} " =~ " $neighbor " ]]; then
                if has_cycle "$neighbor"; then
                    return 0
                fi
            elif [[ " ${stack[@]} " =~ " $neighbor " ]]; then
                echo "Deadlock detected involving container: $neighbor"
                return 0
            fi
        done

        stack=("${stack[@]/$node}")
        return 1
    }

    for container in "${!dependency_graph[@]}"; do
        if [[ ! " ${visited[@]} " =~ " $container " ]]; then
            if has_cycle "$container"; then
                echo "Deadlock detected in the system!"
                exit 1
            fi
        fi
    done

    echo "No deadlocks detected."
}

# Periodically check for deadlocks
while true; do
    detect_deadlock
    sleep 10 # Check every 10 seconds
done
