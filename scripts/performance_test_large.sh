#!/bin/bash

# Define regions and their ports
declare -A regions
regions=(
    ["us"]="8081"
    ["eu"]="8082"
    ["asia"]="8083"
    ["sa"]="8084"
    ["au"]="8085"
)

# Number of requests and concurrency level
REQUESTS=100000  # Large number of requests
CONCURRENCY=500  # High concurrency level

# Output directory for results
OUTPUT_DIR="./performance_results_large"
mkdir -p "$OUTPUT_DIR"

# Run Apache Benchmark for each region
for region in "${!regions[@]}"; do
    port=${regions[$region]}
    echo "Testing region: $region on port $port with $REQUESTS requests and $CONCURRENCY concurrency..."
    ab -n $REQUESTS -c $CONCURRENCY "http://localhost:$port/" > "$OUTPUT_DIR/${region}_results.txt"
    echo "Results saved to $OUTPUT_DIR/${region}_results.txt"
done

echo "Performance testing completed. Results are in $OUTPUT_DIR."
