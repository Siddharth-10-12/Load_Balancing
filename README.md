
## Load Balancing Strategies for Distributed Systems
This project demonstrates multiple load balancing techniques using NGINX to manage traffic across a globally distributed system. Each region applies a strategy best suited to its specific requirements, offering a practical comparison of modern load balancing approaches.

## Features

- Multiple load balancing strategies tailored to different global regions  
- Dynamic server selection based on real-time performance metrics  
- Health monitoring and adaptive routing for improved resilience  
- **Q-learning-based intelligent routing** (Australia)  
- **Latency-based routing** (South America)  
- **Weight-based routing** (Asia)  
- Traditional **round-robin** and **least-connections** strategies  




| Region            | Strategy                 | Configuration File | Key Features                                                    |
| ----------------- | ------------------------ | ------------------ | --------------------------------------------------------------- |
| **Asia**          | Weight-based selection   | `nginx-asia.conf`  | Dynamic weights adjusted by server health status                |
| **Australia**     | Q-learning reinforcement | `nginx-au.conf`    | Machine learning approach with exploration/exploitation balance |
| **Europe**        | Least connections        | `nginx-eu.conf`    | Chooses the server with the fewest active connections           |
| **South America** | Latency-based routing    | `nginx-sa.conf`    | Selects server with the lowest real-time latency                |
| **United States** | Round-robin              | `nginx-us.conf`    | Evenly distributes requests across all servers                  |


Prerequisites
Ensure the following tools are installed:

Docker

Docker Compose

NGINX
