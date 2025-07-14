import matplotlib.pyplot as plt

# Function to parse Apache Benchmark results
def parse_ab_results(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    # Extract key metrics
    requests_per_second = None
    time_per_request = None
    for line in lines:
        if "Requests per second" in line:
            requests_per_second = float(line.split(":")[1].strip().split(" ")[0])
        if "Time per request" in line and "(mean)" in line:
            time_per_request = float(line.split(":")[1].strip().split(" ")[0])
    
    return requests_per_second, time_per_request

# Parse results for random test servers
try:
    random_rps, random_tpr = parse_ab_results("random_results.txt")
except Exception as e:
    print(f"Error parsing random_results.txt: {e}")
    random_rps, random_tpr = 0, 0

# Parse results for load-balancing server
try:
    lb_rps, lb_tpr = parse_ab_results("load_balancing_results.txt")
except Exception as e:
    print(f"Error parsing load_balancing_results.txt: {e}")
    lb_rps, lb_tpr = 0, 0

# Create a bar chart for Requests Per Second
plt.figure(figsize=(10, 5))
plt.bar(["Random Servers", "Load Balancer"], [random_rps, lb_rps], color=['blue', 'orange'])
plt.title("Requests Per Second Comparison")
plt.ylabel("Requests Per Second")
plt.show()

# Create a bar chart for Time Per Request
plt.figure(figsize=(10, 5))
plt.bar(["Random Servers", "Load Balancer"], [random_tpr, lb_tpr], color=['blue', 'orange'])
plt.title("Time Per Request Comparison")
plt.ylabel("Time Per Request (ms)")
plt.show()
