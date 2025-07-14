FROM nginx:1.22.1

# Remove conflicting packages and install required NGINX modules
RUN apt-get update && \
    apt-get remove --purge -y nginx nginx-common && \
    apt-get install -y libnginx-mod-http-echo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the custom NGINX configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx_1.conf /etc/nginx/nginx.conf

# Copy the HTML and images directory to the NGINX default web root
COPY html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
