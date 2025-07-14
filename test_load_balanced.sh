
#!/bin/bash

# Global router endpoint
load_balancer="http://localhost:8080"

# List of IPs to simulate different locations
location_ips=(
    "8.8.8.8"    # US
    "79.133.192.1" # Germany
    "49.207.135.1" # India
    "123.123.123.123" # Default (Asia)
)

# Number of total requests
total_requests=100

# Send requests
for ((i=1; i<=total_requests; i++)); do
    # Select a random location IP
    random_ip=${location_ips[$RANDOM % ${#location_ips[@]}]}

    echo "Sending request $i to load balancer with IP $random_ip..."
    curl -s -H "X-Forwarded-For: $random_ip" "$load_balancer/debug" &
done

# Wait for all background requests to complete
wait

echo "All load-balanced requests completed."
