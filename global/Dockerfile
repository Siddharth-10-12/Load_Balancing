FROM nginx:1.21.6

# Remove the conflicting nginx package from the base image
RUN apt-get remove --purge -y nginx nginx-common && \
    apt-get update && \
    apt-get install -y curl gnupg2 lsb-release libnginx-mod-http-geoip2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy custom nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
