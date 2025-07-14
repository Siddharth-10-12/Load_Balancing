FROM openresty/openresty:alpine
ARG REGION

# Install ping utility and Lua HTTP module
RUN apk add --no-cache iputils lua-resty-http

# Copy the custom OpenResty configuration
COPY nginx-${REGION}.conf /etc/nginx/conf.d/default.conf
COPY nginx-${REGION}.conf /usr/local/openresty/nginx/conf/nginx.conf

EXPOSE 80

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
