!/bin/bash

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
REQUESTS=1000
CONCURRENCY=50

# Output directory for results
OUTPUT_DIR="./performance_results"
mkdir -p "$OUTPUT_DIR"

# Run Apache Benchmark for each region
for region in "${!regions[@]}"; do
    port=${regions[$region]}
    echo "Testing region: $region on port $port..."
    ab -n $REQUESTS -c $CONCURRENCY "http://localhost:$port/" > "$OUTPUT_DIR/${region}_results.txt"
    echo "Results saved to $OUTPUT_DIR/${region}_results.txt"
done

echo "Performance testing completed. Results are in $OUTPUT_DIR."
