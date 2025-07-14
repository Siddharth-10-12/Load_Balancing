# Load_Balancing
Load Balancing Strategies for Distributed Systems
This project demonstrates various load balancing techniques implemented with NGINX for a globally distributed system. Each region uses a different load balancing strategy tailored to its specific requirements.

Features
Multiple load balancing strategies for different regions

Dynamic server selection based on real-time metrics

Health monitoring and adaptive routing

Q-learning based intelligent routing (Australia region)

Latency-based routing (South America region)

Weight-based routing (Asia region)

Traditional round-robin and least-conn strategies

Load Balancing Strategies
Region	Strategy	Configuration File	Key Features
Asia	Weight-based selection	nginx-asia.conf	Dynamic weights adjusted by health status
Australia	Q-learning reinforcement	nginx-au.conf	Machine learning approach with exploration/exploitation
Europe	Least connections	nginx-eu.conf	Traditional least connections algorithm
South America	Latency-based	nginx-sa.conf	Routes to server with lowest measured latency
United States	Round-robin	nginx-us.conf	Simple round-robin distribution

Prerequisites
Docker

Docker Compose

NGINX 
