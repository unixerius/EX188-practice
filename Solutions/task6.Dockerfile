# Edit this file to create an nginx webserver
# Pull from centos:9
FROM centos:9

# Install nginx
RUN dnf install -y nginx && dnf clean all

# Publish port 80 to the outside world
EXPOSE 80

# Copy index.html and duffman.png into /usr/share/nginx/html directory
COPY index.html /usr/share/nginx/html/index.html
COPY duffman.png /usr/share/nginx/html/duffman.png

# Run the command 'nginx -g daemon off;'
ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]
