#!/bin/bash

# List of all test servers with exposed ports
test_servers=(
    "localhost:8091"
    "localhost:8092"
    "localhost:8093"
    "localhost:8094"
    "localhost:8095"
    "localhost:8096"
    "localhost:8097"
    "localhost:8098"
    "localhost:8099"
)

# List of IPs to simulate different locations
location_ips=(
    "8.8.8.8"    # US
    "79.133.192.1" # Germany
    "49.207.135.1" # India
    "123.123.123.123" # Default (Asia)
)

# Number of total requests
total_requests=100

# Number of inefficient requests
inefficient_requests=20

# Randomly select inefficient servers
inefficient_servers=()
for ((i=0; i<inefficient_requests; i++)); do
    random_server=${test_servers[$RANDOM % ${#test_servers[@]}]}
    inefficient_servers+=("$random_server")
done

echo "Inefficient servers: ${inefficient_servers[@]}"

# Send requests
for ((i=1; i<=total_requests; i++)); do
    # Select a random server
    random_server=${test_servers[$RANDOM % ${#test_servers[@]}]}

    # Select a random location IP
    random_ip=${location_ips[$RANDOM % ${#location_ips[@]}]}

    # Check if the server is inefficient
    if [[ " ${inefficient_servers[@]} " =~ " ${random_server} " ]]; then
        echo "Sending inefficient request $i to $random_server with IP $random_ip..."
        curl -s -H "X-Forwarded-For: $random_ip" "http://$random_server/debug" --max-time 2 &
    else
        echo "Sending normal request $i to $random_server with IP $random_ip..."
        curl -s -H "X-Forwarded-For: $random_ip" "http://$random_server/debug" &
    fi
done

# Wait for all background requests to complete
wait

echo "All random requests completed."
